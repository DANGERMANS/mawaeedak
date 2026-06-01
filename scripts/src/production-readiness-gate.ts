type CheckStatus = "passed" | "failed";

type CheckResult = {
  name: string;
  status: CheckStatus;
  detail: string;
};

const results: CheckResult[] = [];

function pass(name: string, detail: string): void {
  results.push({ name, status: "passed", detail });
  console.log(`✅ ${name}: ${detail}`);
}

function fail(name: string, detail: string): void {
  results.push({ name, status: "failed", detail });
  console.error(`❌ ${name}: ${detail}`);
}

function requiredEnv(name: string): string | undefined {
  const value = process.env[name]?.trim();
  if (!value) {
    fail(`env:${name}`, "missing");
    return undefined;
  }
  pass(`env:${name}`, "present");
  return value;
}

function optionalEnv(name: string): string | undefined {
  const value = process.env[name]?.trim();
  if (!value) {
    console.log(`⚠️ env:${name}: not set; related optional smoke skipped`);
    return undefined;
  }
  pass(`env:${name}`, "present");
  return value;
}

function normalizeUrl(name: string, raw: string | undefined): string | undefined {
  if (!raw) return undefined;
  try {
    const url = new URL(raw);
    const normalized = url.toString().replace(/\/+$/, "");
    pass(`url:${name}`, normalized);
    return normalized;
  } catch {
    fail(`url:${name}`, `invalid URL: ${raw}`);
    return undefined;
  }
}

async function expectStatus(
  name: string,
  url: string | undefined,
  expectedStatuses: number[],
  init?: RequestInit,
): Promise<void> {
  if (!url) return;

  try {
    const response = await fetch(url, init);
    if (expectedStatuses.includes(response.status)) {
      pass(name, `HTTP ${response.status}`);
      return;
    }

    const text = await response.text().catch(() => "");
    fail(name, `expected ${expectedStatuses.join("/")}, got HTTP ${response.status}${text ? ` — ${text.slice(0, 180)}` : ""}`);
  } catch (error) {
    const message = error instanceof Error ? error.message : String(error);
    fail(name, message);
  }
}

async function main(): Promise<void> {
  const apiBase = normalizeUrl("PRODUCTION_API_BASE_URL", requiredEnv("PRODUCTION_API_BASE_URL"));
  const webBase = normalizeUrl("PRODUCTION_WEB_BASE_URL", optionalEnv("PRODUCTION_WEB_BASE_URL"));
  const serverSupabaseUrl = normalizeUrl("SUPABASE_URL", requiredEnv("SUPABASE_URL"));
  const clientSupabaseUrl = normalizeUrl("VITE_SUPABASE_URL", requiredEnv("VITE_SUPABASE_URL"));
  const serverAnonKey = requiredEnv("SUPABASE_ANON_KEY");
  const clientAnonKey = requiredEnv("VITE_SUPABASE_ANON_KEY");
  requiredEnv("DATABASE_URL");

  if (serverSupabaseUrl && clientSupabaseUrl && serverSupabaseUrl !== clientSupabaseUrl) {
    fail("supabase:url-consistency", "SUPABASE_URL and VITE_SUPABASE_URL point to different projects");
  } else if (serverSupabaseUrl && clientSupabaseUrl) {
    pass("supabase:url-consistency", "server and client URLs match");
  }

  if (serverAnonKey && clientAnonKey && serverAnonKey !== clientAnonKey) {
    fail("supabase:anon-key-consistency", "SUPABASE_ANON_KEY and VITE_SUPABASE_ANON_KEY differ");
  } else if (serverAnonKey && clientAnonKey) {
    pass("supabase:anon-key-consistency", "server and client anon keys match");
  }

  await expectStatus("api:healthz", apiBase ? `${apiBase}/api/healthz` : undefined, [200]);

  await expectStatus(
    "supabase:auth-user-with-anon-only-rejected",
    serverSupabaseUrl ? `${serverSupabaseUrl}/auth/v1/user` : undefined,
    [401, 403],
    serverAnonKey
      ? {
          headers: {
            apikey: serverAnonKey,
            Authorization: `Bearer ${serverAnonKey}`,
          },
        }
      : undefined,
  );

  await expectStatus(
    "admin:protected-without-token",
    apiBase ? `${apiBase}/api/admin/stats` : undefined,
    [401],
  );

  const adminToken = optionalEnv("LIVE_ADMIN_BEARER_TOKEN");
  if (adminToken) {
    await expectStatus(
      "admin:authorized-smoke",
      apiBase ? `${apiBase}/api/admin/stats` : undefined,
      [200],
      { headers: { Authorization: `Bearer ${adminToken}` } },
    );
  }

  if (webBase) {
    await expectStatus("web:root", webBase, [200]);
  }

  const failed = results.filter((result) => result.status === "failed");
  console.log("\nProduction readiness gate summary");
  console.table(results);

  if (failed.length > 0) {
    console.error(`\nProduction readiness gate failed with ${failed.length} blocker(s).`);
    process.exit(1);
  }

  console.log("\nProduction readiness gate passed.");
}

main().catch((error) => {
  const message = error instanceof Error ? error.stack ?? error.message : String(error);
  console.error(message);
  process.exit(1);
});
