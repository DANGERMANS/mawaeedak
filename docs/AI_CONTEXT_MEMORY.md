# AI Context Memory — Mawaeedak

This is the canonical operational memory file for AI agents and reviewers working on `DANGERMANS/mawaeedak`.

Agents must read this file before any task. It exists to prevent repeated mistakes, context loss, accidental redesign, uncontrolled scope expansion, environment-blocked false completion, and unsupported `done/ready` claims.

## 0. Mandatory Reading Order

Before any task, every agent must read in this order:

1. `AGENTS.md`
2. `docs/AI_CONTEXT_MEMORY.md`
3. `docs/AI_TEAM_OPERATING_SYSTEM.md`
4. `docs/AGENT_TASK_TEMPLATE.md`
5. `docs/ACCEPTANCE_GATES.md`
6. `docs/AGENT_REPORT_TEMPLATE.md`
7. Task-specific docs, including migration/status/QA docs when relevant

If any of these files are missing in the current branch, stop and report which branch was inspected and which file is missing.

## 1. Executive Summary — Where We Are Now

Current project state:

- The repository is `DANGERMANS/mawaeedak`.
- The project was discovered as Web-first.
- The web app lives mainly under `artifacts/mawaeedak/`.
- The real mobile app must live under `mobile/`.
- `mobile/` is the approved target for the real mobile application.
- `artifacts/mawaeedak/` is a reference only for product behavior, Arabic wording, and current visual identity.
- The active web design is frozen and must not be changed during mobile migration tasks.
- The current mobile migration is started but not verified.
- The current blocker is environment verification, not a new feature request.
- The only safe next step is running the mobile verification commands in an environment that has repository access and working GitHub connectivity.

Current acceptance state:

- Mobile migration work: `PARTIAL`.
- Runtime verification: `BLOCKED / UNVERIFIED`.
- TypeScript verification: `BLOCKED / NOT RUN`.
- Expo verification: `BLOCKED / NOT RUN`.
- Overall current verdict: `BLOCKED BY ENVIRONMENT` until verification runs.

## 2. Current Executive Decision

The following decisions are fixed unless the user explicitly overrides them:

- `mobile/` is the approved real mobile application path.
- `artifacts/mawaeedak/` is the current web application and may be used as a reference only.
- The web app must not be deleted, redesigned, or modified during mobile migration tasks unless the user explicitly asks.
- The current active design is frozen.
- Do not change the active web design, colors, CSS, components, layout, cards, typography, or visual identity.
- The mobile migration must be gradual, controlled, phase-gated, and evidence-based.
- Do not treat Web/PWA as the real mobile app.
- Do not use WebView as a shortcut.
- Do not copy HTML/CSS/DOM/Vite-specific web code into React Native.
- Do not move to a new phase until current verification passes or is explicitly accepted with documented gaps.

## 3. Current Branch Reality

Current known branches:

- Control/base branch: `codex/setup-control-files`.
- Current mobile migration branch: `codex/mobile-web-to-mobile-controlled-migration`.
- `main` must not be touched unless the user explicitly commands it.

Branch notes:

- Control files and this memory live on `codex/setup-control-files`.
- Mobile migration work exists on `codex/mobile-web-to-mobile-controlled-migration`.
- Agents must clearly state which branch they inspected, changed, or attempted to run.
- If an agent works on a different branch, it must stop and request confirmation before modifying anything.

## 4. What We Already Did

### 4.1 Governance and Team System

Completed:

- Established a controlled AI team model inside the repository.
- Added/updated `AGENTS.md`.
- Added `docs/AI_TEAM_OPERATING_SYSTEM.md`.
- Added `docs/AGENT_TASK_TEMPLATE.md`.
- Added `docs/ACCEPTANCE_GATES.md`.
- Added `docs/AGENT_REPORT_TEMPLATE.md`.
- Added `docs/PROJECT_REALITY_AUDIT.md`.
- Expanded the team from a technical group to a complete company operating model:
  - Leadership.
  - Product.
  - AI orchestration.
  - Architecture.
  - Mobile engineering.
  - Backend/API.
  - Database/Supabase.
  - QA.
  - Security.
  - Privacy/legal/store readiness.
  - SRE/observability.
  - Incident management.
  - Backup/disaster recovery.
  - Cost/FinOps.
  - Content/data quality.
  - Arabic/localization.
  - Accessibility.
  - Customer support.
  - Product analytics.
  - AI context librarian.

### 4.2 Repository Reality Audit

Completed as static inspection only:

- Audited repository reality.
- Determined the project is Web-first.
- Determined `artifacts/mawaeedak/` contains the main web product.
- Determined `mobile/` was missing, empty, or incomplete depending on inspected branch.
- Determined `mobile/app/index.tsx` originally returned `null` or did not provide a functional app shell.
- Determined API/backend and web/admin/data-source areas exist but are outside the immediate mobile verification task.
- Determined production/readiness cannot be claimed without runtime, typecheck, build, security, QA, and deployment evidence.

Audit limitation:

- The audit was not a runtime test.
- Build/typecheck/Expo/Supabase/RLS were not actually verified in the blocked environment.

### 4.3 Mobile Migration Start

Completed partially on `codex/mobile-web-to-mobile-controlled-migration`:

- Created/used mobile migration branch.
- Added or initialized `mobile/` on the migration branch.
- Added `mobile/package.json`.
- Added Expo-related mobile config files.
- Added `mobile/app/_layout.tsx`.
- Added `mobile/app/index.tsx`.
- Added `mobile/src/MobileApp.tsx`.
- Added a first mobile shell.
- `mobile/app/index.tsx` now renders `MobileApp` instead of returning `null`.
- Added bottom navigation in this fixed order:
  1. `الرئيسية`
  2. `الرواتب`
  3. `الخدمات`
  4. `التقويم`
  5. `المزيد`
- Added initial non-empty screens for:
  - Home.
  - Salaries.
  - Services.
  - Calendar.
  - More.
- Used safe waiting states instead of fake official data, such as:
  - `بانتظار ربط المصدر الرسمي`
  - `بانتظار ربط البيانات الرسمية`
- Added `Pressable` actions / alerts for visible actions where full functionality is not complete.
- Did not intentionally modify `main`.
- Did not intentionally modify `artifacts/mawaeedak`.
- Did not intentionally modify admin/API/Supabase/RLS.

### 4.4 Mobile Migration Documentation

Completed/created/updated on the migration branch according to agent reports:

- `docs/MOBILE_MIGRATION_PLAN.md`.
- `docs/MOBILE_MIGRATION_STATUS.md`.
- `docs/MOBILE_QA_CHECKLIST.md`.
- `docs/MOBILE_RELEASE_READINESS.md` was later created as a status-only document and marked blocked/not launch ready.

Important: these docs do not prove runtime success. They document migration state and blockers only.

## 5. What We Have NOT Done Yet

Do not claim these are done:

- Mobile typecheck has not been successfully run.
- `npm run doctor` has not been successfully run.
- `npx expo start --clear` has not been successfully run.
- Expo runtime has not been verified.
- Mobile app has not been tested on simulator/device.
- Mobile navigation has not been runtime verified.
- Mobile accessibility has not been runtime verified.
- TypeScript correctness is unknown until `npm run typecheck` succeeds.
- Expo config correctness is unknown until Expo/doctor runs.
- Supabase is not connected for mobile.
- Auth is not implemented or verified for mobile.
- Notifications are not implemented or verified for mobile.
- Calendar CRUD is not implemented or verified for mobile.
- Real official financial/prayer data is not connected for mobile.
- EAS Build has not been run.
- EAS Submit has not been run.
- App Store / Google Play release is not ready.
- Production readiness is not true.
- Launch readiness is not true.
- Store readiness is not true.

## 6. Current Blocking Problem

The current blocker is environment access, not a product-design issue.

Reported error:

```text
fatal: unable to access 'https://github.com/DANGERMANS/mawaeedak.git/': Could not resolve host: github.com
```

Meaning:

- The agent environment cannot resolve GitHub DNS.
- The environment cannot clone/fetch the repository.
- The environment cannot run verification on the branch.
- The environment cannot prove typecheck/runtime success.
- The agent must stop and report `BLOCKED BY ENVIRONMENT` if it cannot run the required commands.

Do not keep retrying the same blocked environment. Move verification to a valid environment.

## 7. Current Only Safe Next Step

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

If `npm install` is not appropriate because dependencies are already installed, report that and proceed to verification commands.

If any command fails:

- Send the full error output.
- Fix only inside `mobile/`.
- Do not expand scope.
- Do not start a new phase.
- Do not touch `artifacts/mawaeedak`.
- Do not touch admin/API/Supabase/RLS.
- Do not touch `main`.

If all commands succeed:

- Report exact command results.
- State whether Expo opened actually.
- List files changed.
- List remaining errors/gaps.
- Provide exactly one next safe step.

## 8. Current Review Judgment Rules

When reviewing the current mobile work:

Accept as partial only if:

- It created a real mobile shell.
- It did not modify forbidden areas.
- It documents that verification is missing.

Reject as final closure if:

- Typecheck was not run.
- Expo was not run.
- Runtime was not verified.
- It claims the app is done/ready without evidence.
- It starts new phases before verification.

Current correct verdict language:

```text
BLOCKED / NEEDS FIXES
Accepted as status update only.
Rejected as final closure.
```

## 9. Standing Product Rules

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

## 10. Standing Mobile Migration Rules

- `mobile/` is the real mobile app.
- `artifacts/mawaeedak/` is reference-only during migration.
- The active web design is frozen.
- Do not modify the current web design.
- Do not modify web CSS/components/layout/colors/cards/fonts during mobile migration.
- Do not use WebView.
- Do not copy HTML/CSS/DOM into React Native.
- Build mobile UI with React Native primitives/components only.
- Do not show fake official data.
- Do not present placeholders as completed features.
- A placeholder must say clearly that it is waiting for official source/runtime wiring.
- Each visible button/card action must have real `onPress` behavior or clear user feedback.

## 11. Standing Engineering Rules

- No feature is accepted as working without evidence.
- A button/action is not working merely because `onPress`/`onClick` exists.
- Any visible action must have a real handler, real behavior, user-visible result, failure handling when relevant, and test evidence.
- Do not show fake official data.
- Do not show fake success states.
- Do not silently fall back to fake/local/mock data in production paths.
- `localStorage`/local storage is not a production source of truth for real user/admin data.
- Supabase/RLS/auth/admin work is security-sensitive and requires focused review.
- Do not expose secrets, service-role keys, tokens, JWTs, refresh tokens, or admin credentials.
- Do not add external services without explaining privacy/cost/operational impact.

## 12. Standing Execution Rules

- One task only.
- One phase only unless the prompt explicitly permits multiple phase-gated phases.
- Do not move to the next phase before the current phase is verified and accepted.
- Do not claim `ready`, `done`, `production ready`, `launch ready`, or `store ready` without command output and runtime evidence.
- Do not create broad repair tasks like `fix everything`.
- Do not use long chat history as the source of truth when this file or `docs/` files contain the decision.
- If tool/environment access fails, report it as a blocker and stop rather than pretending verification passed.
- Do not keep adding documentation as a substitute for verification when the current blocker is environment access.

## 13. What To Tell A New Agent Now

Use this short instruction for the next agent:

```text
Read first:
AGENTS.md
docs/AI_CONTEXT_MEMORY.md

Current task only:
Verify the mobile migration branch.

Repository:
DANGERMANS/mawaeedak

Branch:
codex/mobile-web-to-mobile-controlled-migration

Run:
git fetch origin
git checkout codex/mobile-web-to-mobile-controlled-migration
cd mobile
npm install
npm run typecheck
npm run doctor
npx expo start --clear

Forbidden:
- Do not touch main.
- Do not modify artifacts/mawaeedak.
- Do not modify admin/API/Supabase/RLS.
- Do not add features.
- Do not start a new phase.
- Do not deploy.
- Do not run EAS Build.

If blocked by environment, report BLOCKED BY ENVIRONMENT and stop.
If errors occur, fix only inside mobile/ and report full output.
```

## 14. Response Format Preference for Reviews

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

## 15. Memory Update Protocol

Update this file only when the user approves a stable decision that future agents must remember.

Do not update it for speculation or unverified success claims.

Environment blockers may be documented only when they define the current safe next step.

Each update must preserve:

- Current executive decision.
- Current branch reality.
- What has been done.
- What has not been done.
- Current blocker.
- Current only safe next step.
- Fixed product rules.
- Standing prohibitions.

## 16. Final Rule

If a future instruction conflicts with this file, stop and ask for confirmation unless the user explicitly states that the new instruction overrides the memory.

If an agent cannot read this file, it must not proceed with any code changes.
