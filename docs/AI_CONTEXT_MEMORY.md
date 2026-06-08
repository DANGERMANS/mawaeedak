# AI Context Memory - Mawaeedak

This is the canonical operational memory for AI agents and reviewers working on `DANGERMANS/mawaeedak`.

Agents must read this file before any task. It exists to prevent repeated mistakes, context loss, accidental redesign, uncontrolled scope expansion, false completion, and unsupported ready claims.

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

## 1. Current Verified State

As of commit `fbbea503da852fd2524363ee872c62371451c970` on branch `codex/mobile-web-to-mobile-controlled-migration`, the mobile shell path is no longer blocked by the old environment issue.

Current mobile shell verdict:

```text
READY FOR NEXT STEP - limited to mobile shell verification only
```

This is not launch ready.
This is not production ready.
This is not store ready.
This is not final merge ready.

## 2. Branch Reality

- Repository: `DANGERMANS/mawaeedak`
- Base/control branch: `codex/setup-control-files`
- Mobile work branch: `codex/mobile-web-to-mobile-controlled-migration`
- PR: `#31`
- PR state: Draft
- Last known mergeability before conflict resolution: `mergeable=false`
- `main` must not be touched unless the user explicitly commands it.

Agents must clearly state which branch they inspected, changed, or attempted to run. If an agent works on a different branch, it must stop and request confirmation before modifying anything.

## 3. Fixed Executive Decisions

These are fixed unless the user explicitly overrides them:

- `mobile/` is the approved real mobile application path.
- `artifacts/mawaeedak/` is the current web application and may be used as a reference only.
- The web app must not be deleted, redesigned, or modified during mobile migration tasks unless the user explicitly asks.
- The current active web design is frozen.
- Do not change the active web design, colors, CSS, components, layout, cards, typography, or visual identity.
- The mobile migration must be gradual, controlled, phase-gated, and evidence-based.
- Do not treat Web/PWA as the real mobile app.
- Do not use WebView as a shortcut.
- Do not copy HTML/CSS/DOM/Vite-specific web code into React Native.
- Do not move to a new phase until current verification passes or is explicitly accepted with documented gaps.

## 4. Verified Mobile Evidence

The following checks were run inside `mobile/` after the mobile fixes:

- `npm install`: passed using `npm.cmd install` on Windows.
- `npm run typecheck`: passed.
- `npm run doctor`: passed with `18/18 checks passed`.
- `npx expo start --clear`: Metro/Expo started locally.
- `http://127.0.0.1:8081/status`: returned `packager-status:running`.

## 5. Accepted Scope

Accepted only as initial mobile shell verification:

- The mobile shell exists.
- TypeScript passes.
- Expo doctor passes.
- Metro starts locally.
- The runtime status endpoint reports running.

This does not prove complete mobile migration, production readiness, launch readiness, store readiness, or final merge readiness.

## 6. What We Already Did

### 6.1 Governance and Team System

Completed:

- Established a controlled AI team model inside the repository.
- Added/updated `AGENTS.md`.
- Added `docs/AI_TEAM_OPERATING_SYSTEM.md`.
- Added `docs/AGENT_TASK_TEMPLATE.md`.
- Added `docs/ACCEPTANCE_GATES.md`.
- Added `docs/AGENT_REPORT_TEMPLATE.md`.
- Added `docs/PROJECT_REALITY_AUDIT.md`.

### 6.2 Repository Reality Audit

Completed as static inspection only:

- Determined the project is Web-first.
- Determined `artifacts/mawaeedak/` contains the main web product.
- Determined `mobile/` is the real mobile target.
- Determined API/backend/admin/Supabase areas exist but are outside the current mobile shell verification task.
- Determined production/readiness cannot be claimed without runtime, typecheck, build, security, QA, and deployment evidence.

### 6.3 Mobile Migration Start

Completed partially on `codex/mobile-web-to-mobile-controlled-migration`:

- Added or initialized `mobile/`.
- Added Expo-related mobile config files.
- Added a first mobile shell.
- `mobile/app/index.tsx` renders `MobileApp`.
- Added initial non-empty screens and bottom navigation.
- Used safe waiting states instead of fake official data.
- Did not intentionally modify `main`.
- Did not intentionally modify `artifacts/mawaeedak`.
- Did not intentionally modify admin/API/Supabase/RLS.

## 7. Explicit Non-Readiness

Do not claim any of the following:

- Launch ready.
- Production ready.
- Store ready.
- Full app ready.
- Mobile feature-complete.
- Final merge ready.

Still not done:

- Expo Go was not tested on a physical device.
- Simulator/device interaction was not fully tested.
- Sentry is not practically initialized or tested.
- Auth is not implemented or verified for mobile.
- Supabase is not connected or verified for mobile.
- Notifications are not implemented or verified for mobile.
- Calendar CRUD is not implemented or verified for mobile.
- EAS Build was not run.
- EAS Submit was not run.

## 8. Remaining Risks

- `npm audit` still reports `14 moderate severity vulnerabilities`.
- The npm suggested fix requires `npm audit fix --force` and would upgrade to `expo@56.0.9`, a breaking change; do not run it without an explicit user decision.
- Vercel failures are outside the mobile shell scope and should not be treated as proof that mobile failed.
- Vercel failures may still block final merge if branch protection requires them.
- PR `#31` must remain Draft until the user explicitly approves changing it.
- Mergeability must be checked after conflict resolution before any Ready-for-review or merge decision.

## 9. Standing Product Rules

- App name: `Mawaeedak` / `مواعيدك`.
- Timezone: `Asia/Riyadh`.
- Day rollover is after 12:00 AM, not 12:00 PM.
- Financial dates must be sourced from the official Saudi government authority that owns each program.
- User-facing financial/prayer cards must not display source names or URLs.
- Official data must show waiting/unapproved states until source approval and runtime wiring are verified.

## 10. Standing Mobile Migration Rules

- `mobile/` is the real mobile app.
- `artifacts/mawaeedak/` is reference-only during migration.
- The active web design is frozen.
- Do not modify the current web design.
- Do not use WebView.
- Do not copy HTML/CSS/DOM into React Native.
- Build mobile UI with React Native primitives/components only.
- Do not show fake official data.
- Do not present placeholders as completed features.
- Each visible button/card action must have real `onPress` behavior or clear user feedback.

## 11. Standing Engineering Rules

- No feature is accepted as working without evidence.
- A button/action is not working merely because `onPress`/`onClick` exists.
- Do not show fake official data.
- Do not show fake success states.
- Do not expose secrets, service-role keys, tokens, JWTs, refresh tokens, or admin credentials.

## 12. Standing Execution Rules

- One task only.
- Do not move to the next phase before the current phase is verified and accepted.
- Do not claim `ready`, `done`, `production ready`, `launch ready`, or `store ready` without command output and runtime evidence.
- If tool/environment access fails, report it as a blocker and stop rather than pretending verification passed.

## 13. Forbidden Areas For PR #31

Do not modify:

- `main`
- `artifacts/mawaeedak`
- web/admin/API/Supabase/RLS
- deployment configuration outside mobile scope

Do not:

- Add features.
- Run EAS Build.
- Deploy.
- Convert PR `#31` to Ready.

## 14. Current Review Judgment Rules

Correct current judgment:

```text
Accepted as limited mobile shell verification.
PR remains Draft.
Not launch ready.
Not production ready.
Not store ready.
Investigate remaining checks before Ready or merge.
```

Incorrect current judgment:

```text
The old environment-blocked verdict is still current for mobile shell verification.
```

That old statement is no longer accurate after commit `fbbea503da852fd2524363ee872c62371451c970`.

## 15. Next Safe Step

Check PR `#31` mergeability and Vercel status after this conflict-resolution commit while keeping the PR Draft and without changing code outside the allowed scope.

## 16. Memory Update Protocol

Update this file only when the user approves a stable decision that future agents must remember.

## 17. Final Rule

If a future instruction conflicts with this file, stop and ask for confirmation unless the user explicitly states that the new instruction overrides this memory.

If an agent cannot read this file, it must not proceed with code changes.
