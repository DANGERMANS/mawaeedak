# AI Context Memory — Mawaeedak

This is the canonical memory file for AI agents and reviewers working on `DANGERMANS/mawaeedak`.

Agents must read this file before any task. It exists to prevent repeated mistakes, context loss, accidental redesign, uncontrolled scope expansion, and unsupported completion claims.

## Current Executive Decision

- The repository is `DANGERMANS/mawaeedak`.
- `mobile/` is the approved real mobile application path.
- `artifacts/mawaeedak/` is the current web application and may be used as a reference only.
- The web app must not be deleted, redesigned, or modified during mobile migration tasks unless the user explicitly asks.
- The current active design is frozen. Do not change the active web design, colors, CSS, components, layout, cards, typography, or visual identity.
- The mobile migration must be gradual, controlled, and phase-gated.
- Do not treat Web/PWA as the real mobile app.
- Do not use WebView as a shortcut.
- Do not copy HTML/CSS/DOM/Vite-specific web code into React Native.

## Current Branches

- Control/base branch: `codex/setup-control-files`.
- Current mobile migration branch: `codex/mobile-web-to-mobile-controlled-migration`.
- Do not work directly on `main` unless the user explicitly commands that exact action.

## Current Known Status

- The repository was audited as Web-first with `artifacts/mawaeedak/` holding most product behavior.
- The original mobile path was missing or incomplete on the control branch.
- A mobile migration branch was created.
- `mobile/app/index.tsx` on the migration branch now renders `MobileApp` instead of returning `null`.
- A first mobile shell was added with the approved bottom navigation order:
  - `الرئيسية`
  - `الرواتب`
  - `الخدمات`
  - `التقويم`
  - `المزيد`
- Initial mobile screens exist, but runtime verification is not complete.
- `npm run typecheck`, `npm run doctor`, and `npx expo start --clear` have not been successfully run in the reported blocked environment.
- The blocker was environment/DNS failure: `Could not resolve host: github.com`.
- The work must not be accepted as complete until verification runs in a valid environment.

## Current Blocking Problem

The current blocker is not a product-design issue. It is a verification-environment issue.

Reported error:

```text
fatal: unable to access 'https://github.com/DANGERMANS/mawaeedak.git/': Could not resolve host: github.com
```

Meaning:

- The agent environment cannot resolve GitHub DNS.
- It cannot clone/fetch the repository.
- It cannot prove typecheck/runtime success.
- It must stop and report `BLOCKED BY ENVIRONMENT` if it cannot run the required commands.

## Current Only Safe Next Step

Run verification in an environment that already has repository access or has working GitHub connectivity.

Required commands on the migration branch:

```bash
git fetch origin
git checkout codex/mobile-web-to-mobile-controlled-migration
cd mobile
npm install
npm run typecheck
npm run doctor
npx expo start --clear
```

If any command fails:

- Send the full error output.
- Fix only inside `mobile/`.
- Do not expand scope.
- Do not start a new phase.

If all commands succeed:

- Report exact results.
- State whether Expo opened actually.
- List files changed.
- List remaining errors.
- Provide exactly one next safe step.

## Standing Product Rules

- App name: `مواعيدك`.
- Main slogan: `كل موعد له وقته`.
- Mobile bottom navigation order is fixed:
  1. `الرئيسية`
  2. `الرواتب`
  3. `الخدمات`
  4. `التقويم`
  5. `المزيد`
- Services order is fixed:
  1. `احسب هدفك`
  2. `حساب التكاليف`
  3. `ذكرني`
  4. `السفر`
  5. `الدراسة والإجازات`
  6. `الوظائف والأخبار`
  7. `بطاقة اليوم`
  8. `صوتك مسموع`
- Timezone: `Asia/Riyadh`.
- Day rollover is after 12:00 AM, not 12:00 PM.
- Internal time calculations should be canonical 24-hour/Riyadh time while display may support 12-hour or 24-hour according to settings.
- Financial dates must be sourced from the official Saudi government authority that owns each program.
- User-facing financial/prayer cards must not display source names or URLs; source explanation belongs in app info/about content.
- Official data must show waiting/unapproved states until source approval and runtime wiring are verified.

## Standing Engineering Rules

- No feature is accepted as working without evidence.
- A button/action is not working merely because `onPress`/`onClick` exists.
- Any visible action must have a real handler, real behavior, user-visible result, failure handling when relevant, and test evidence.
- Do not show fake official data.
- Do not show fake success states.
- Do not silently fall back to fake/local/mock data in production paths.
- `localStorage`/local storage is not a production source of truth for real user/admin data.
- Supabase/RLS/auth/admin work is security-sensitive and requires focused review.
- Do not expose secrets, service-role keys, tokens, JWTs, refresh tokens, or admin credentials.

## Standing Execution Rules

- One task only.
- One phase only unless the prompt explicitly permits multiple phase-gated phases.
- Do not move to the next phase before the current phase is verified and accepted.
- Do not claim `ready`, `done`, `production ready`, or `launch ready` without command output and runtime evidence.
- Do not create broad repair tasks like `fix everything`.
- Do not use long chat history as the source of truth when this file or `docs/` files contain the decision.
- If tool/environment access fails, report it as a blocker and stop rather than pretending verification passed.

## Response Format Preference for Reviews

When reviewing reports, use:

```text
الحكم:
القرار:
النواقص:
هل أقبله أو أرفضه:
الرد الجاهز:
```

When diagnosing errors/logs/screenshots, use:

```text
السبب:
مكان الخلل:
الحل:
الأمر الصحيح:
النتيجة المتوقعة:
```

## Memory Update Protocol

Update this file only when the user approves a stable decision that future agents must remember.

Do not update it for temporary errors, speculation, or unverified claims.

Each update must preserve:

- Current executive decision.
- Current branch reality.
- Current only safe next step.
- Fixed product rules.
- Standing prohibitions.

## Final Rule

If a future instruction conflicts with this file, stop and ask for confirmation unless the user explicitly states that the new instruction overrides the memory.
