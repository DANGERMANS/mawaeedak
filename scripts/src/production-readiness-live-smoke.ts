type SmokeStatus = "PASS" | "FAIL";

type SmokeResult = {
  name: string;
  status: SmokeStatus;
  detail: string;
};

type SupabaseSession = {
  access_token?: string;
  user?: {
    id?: string;
    email?: string;
  };
};

type AppointmentRow = {
  id: number;
  user_id: string;
  title: string;
};

const results: SmokeResult[] = [];

function record(name: string, status: SmokeStatus, detail: string): void {
  results.push({ name, status, detail });
  const marker = status === "PASS" ? "✅" : "❌";
  console.log(`${marker} ${name}: ${detail}`);
}

function fail(message: string): never {
  throw new Error(message);
}

function requireEnv(name: string): string {
  const value = process.env[name]?.trim();
  if (!value) fail(`Missing required environment variable: ${name}`);
  return value;
}

function normalizeBaseUrl(value: string): string {
  try {
    const parsed = new URL(value);
    return parsed.toString().replace(/\/+$/, "");
  } catch {
    fail(`Invalid URL value for production smoke gate: ${value}`);
  }
}

function joinUrl(base: string, path: string): string {
  return `${base.replace(/\/+$/, "")}/${path.replace(/^\/+/, "")}`;
}

async function fetchWithTimeout(url: string, init: RequestInit = {}, timeoutMs = 15000): Promise<Response> {
  const controller = new AbortController();
  const timeout = setTimeout(() => controller.abort(), timeoutMs);
  try {
    return await fetch(url, { ...init, signal: controller.signal });
  } finally {
    clearTimeout(timeout);
  }
}

async function readJson<T>(response: Response): Promise<T> {
  const text = await response.text();
  if (!text) return {} as T;
  try {
    return JSON.parse(text) as T;
  } catch {
    fail(`Expected JSON response from ${response.url}, received non-JSON body.`);
  }
}

async function checkFrontend(appUrl: string): Promise<void> {
  const response = await fetchWithTimeout(appUrl);
  const body = await response.text();
  if (!response.ok) fail(`Frontend returned HTTP ${response.status}`);
  if (!/(<!doctype|<html|id=["']root["'])/i.test(body)) {
    fail("Frontend response does not look like a built HTML application.");
  }
  record("Frontend production URL", "PASS", `HTTP ${response.status}`);
}

async function checkApiHealth(apiBaseUrl: string): Promise<void> {
  const candidates = [joinUrl(apiBaseUrl, "/api/healthz"), joinUrl(apiBaseUrl, "/healthz")];
  const failures: string[] = [];

  for (const url of candidates) {
    try {
      const response = await fetchWithTimeout(url);
      if (!response.ok) {
        failures.push(`${url} -> HTTP ${response.status}`);
        continue;
      }
      const data = await readJson<{ status?: string }>(response);
      if (data.status !== "ok") {
        failures.push(`${url} -> unexpected status payload`);
        continue;
      }
      record("API health endpoint", "PASS", `${url} returned status=ok`);
      return;
    } catch (error) {
      failures.push(`${url} -> ${(error as Error).message}`);
    }
  }

  fail(`API health check failed. Attempts: ${failures.join(" | ")}`);
}

async function signIn(supabaseUrl: string, anonKey: string, email: string, password: string): Promise<Required<SupabaseSession>> {
  const response = await fetchWithTimeout(joinUrl(supabaseUrl, "/auth/v1/token?grant_type=password"), {
    method: "POST",
    headers: {
      apikey: anonKey,
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ email, password }),
  });

  if (!response.ok) fail(`Supabase Auth sign-in failed for configured test user. HTTP ${response.status}`);

  const session = await readJson<SupabaseSession>(response);
  if (!session.access_token || !session.user?.id) fail("Supabase Auth sign-in did not return access_token and user.id.");

  return session as Required<SupabaseSession>;
}

async function checkSupabaseAuth(supabaseUrl: string, anonKey: string, session: Required<SupabaseSession>): Promise<void> {
  const response = await fetchWithTimeout(joinUrl(supabaseUrl, "/auth/v1/user"), {
    headers: {
      apikey: anonKey,
      Authorization: `Bearer ${session.access_token}`,
    },
  });

  if (!response.ok) fail(`Supabase Auth user verification failed. HTTP ${response.status}`);

  const user = await readJson<{ id?: string }>(response);
  if (user.id !== session.user.id) fail("Supabase Auth user verification returned a different user id.");

  record("Supabase Auth live verification", "PASS", "test user token verified through Supabase Auth API");
}

async function supabaseRest<T>(supabaseUrl: string, anonKey: string, accessToken: string, path: string, init: RequestInit = {}): Promise<{ response: Response; data: T }> {
  const response = await fetchWithTimeout(joinUrl(supabaseUrl, `/rest/v1/${path}`), {
    ...init,
    headers: {
      apikey: anonKey,
      Authorization: `Bearer ${accessToken}`,
      "Content-Type": "application/json",
      ...(init.headers ?? {}),
    },
  });

  const data = await readJson<T>(response);
  return { response, data };
}

async function checkRlsIsolation(
  supabaseUrl: string,
  anonKey: string,
  userA: Required<SupabaseSession>,
  userB: Required<SupabaseSession>,
): Promise<void> {
  const probeTitle = `production-readiness-smoke-${Date.now()}`;

  const insert = await supabaseRest<AppointmentRow[]>(supabaseUrl, anonKey, userA.access_token, "appointments?select=id,user_id,title", {
    method: "POST",
    headers: { Prefer: "return=representation" },
    body: JSON.stringify({
      user_id: userA.user.id,
      title: probeTitle,
      description: "Temporary production readiness RLS probe. Safe to delete.",
      date: new Date().toISOString().slice(0, 10),
      time: "00:00",
      category: "اختبار",
      reminder_enabled: false,
    }),
  });

  if (!insert.response.ok) fail(`RLS own insert failed on appointments. HTTP ${insert.response.status}`);
  const inserted = insert.data[0];
  if (!inserted?.id || inserted.user_id !== userA.user.id) fail("RLS own insert did not return the expected appointment row.");

  try {
    const crossRead = await supabaseRest<AppointmentRow[]>(
      supabaseUrl,
      anonKey,
      userB.access_token,
      `appointments?select=id,user_id,title&id=eq.${inserted.id}`,
    );

    if (!crossRead.response.ok) fail(`RLS cross-user select probe failed unexpectedly. HTTP ${crossRead.response.status}`);
    if (crossRead.data.length !== 0) fail("RLS isolation failed: second test user could read first user's appointment.");

    record("Supabase RLS user isolation", "PASS", "user A row was not readable by user B");
  } finally {
    const cleanup = await supabaseRest<Record<string, never>>(supabaseUrl, anonKey, userA.access_token, `appointments?id=eq.${inserted.id}`, {
      method: "DELETE",
    });

    if (!cleanup.response.ok && cleanup.response.status !== 204) {
      record("Supabase RLS cleanup", "FAIL", `temporary appointment cleanup returned HTTP ${cleanup.response.status}`);
    } else {
      record("Supabase RLS cleanup", "PASS", "temporary appointment row removed by owning user");
    }
  }
}

async function checkAdminApi(apiBaseUrl: string, adminAccessToken: string): Promise<void> {
  const response = await fetchWithTimeout(joinUrl(apiBaseUrl, "/api/admin/stats"), {
    headers: {
      Authorization: `Bearer ${adminAccessToken}`,
    },
  });

  if (!response.ok) fail(`Admin API smoke failed. Expected HTTP 200, received HTTP ${response.status}`);

  await readJson<unknown>(response);
  record("Admin API live authorization", "PASS", "/api/admin/stats accepted configured admin bearer token");
}

async function main(): Promise<void> {
  const productionAppUrl = normalizeBaseUrl(requireEnv("PRODUCTION_APP_URL"));
  const productionApiBaseUrl = normalizeBaseUrl(requireEnv("PRODUCTION_API_BASE_URL"));
  const supabaseUrl = normalizeBaseUrl(requireEnv("SUPABASE_URL"));
  const supabaseAnonKey = requireEnv("SUPABASE_ANON_KEY");
  const userAEmail = requireEnv("SUPABASE_TEST_USER_A_EMAIL");
  const userAPassword = requireEnv("SUPABASE_TEST_USER_A_PASSWORD");
  const userBEmail = requireEnv("SUPABASE_TEST_USER_B_EMAIL");
  const userBPassword = requireEnv("SUPABASE_TEST_USER_B_PASSWORD");
  const adminAccessToken = requireEnv("SUPABASE_ADMIN_ACCESS_TOKEN");

  await checkFrontend(productionAppUrl);
  await checkApiHealth(productionApiBaseUrl);

  const userA = await signIn(supabaseUrl, supabaseAnonKey, userAEmail, userAPassword);
  const userB = await signIn(supabaseUrl, supabaseAnonKey, userBEmail, userBPassword);

  if (userA.user.id === userB.user.id) fail("RLS smoke requires two different Supabase test users.");

  await checkSupabaseAuth(supabaseUrl, supabaseAnonKey, userA);
  await checkRlsIsolation(supabaseUrl, supabaseAnonKey, userA, userB);
  await checkAdminApi(productionApiBaseUrl, adminAccessToken);

  const failed = results.filter((result) => result.status === "FAIL");
  if (failed.length > 0) fail(`Production readiness live smoke failed with ${failed.length} failed check(s).`);

  console.log("\nPRODUCTION READINESS LIVE SMOKE PASSED");
}

main().catch((error: unknown) => {
  const message = error instanceof Error ? error.message : String(error);
  record("Production readiness live smoke", "FAIL", message);
  console.error("\nPRODUCTION READINESS LIVE SMOKE FAILED");
  process.exit(1);
});
