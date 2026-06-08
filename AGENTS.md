# AGENTS.md

## Project Identity

This repository is `DANGERMANS/mawaeedak`.

The active controlled setup/work branch is:

`codex/setup-control-files`

This project must be treated as a production-intended Saudi Arabic scheduling/events mobile application until a full audit proves otherwise.

## Mandatory Control Files

Every agent must read these files before any work:

1. `AGENTS.md`
2. `docs/AI_TEAM_OPERATING_SYSTEM.md`
3. `docs/AGENT_TASK_TEMPLATE.md`
4. `docs/ACCEPTANCE_GATES.md`
5. `docs/AGENT_REPORT_TEMPLATE.md`

For the first repository-wide inspection, agents must also use:

- `docs/PROJECT_REALITY_AUDIT.md`

## Operating Rule

This repository is operated by a controlled AI team model. Agents are not allowed to act as independent uncontrolled workers.

Each assignment must have:

- One primary role.
- One task.
- Clear scope.
- Explicit out-of-scope items.
- Allowed files/folders.
- Required verification.
- Required evidence.
- A final report using the approved report template.

## Repository Architecture

Expected repository areas may include:

- Root workspace and package control files.
- Real mobile application path, expected to be `mobile/` unless the audit proves otherwise.
- Web/frontend artifacts.
- API/backend server artifacts.
- Shared API/schema/client libraries.
- Documentation and QA control files under `docs/`.

Do not assume the architecture is correct or complete until a full audit is performed.

## First Required Mission

After these control files are installed, the first team mission must be:

**Repository Reality Audit — inspection only, no source-code changes.**

Use `docs/PROJECT_REALITY_AUDIT.md` as the required audit template.

The audit must determine actual reality before repair:

- Actual mobile path.
- Actual web/frontend path.
- Actual admin/owner-panel path.
- Actual API/backend path.
- Current data source model.
- Build/typecheck/test status.
- Whether visible buttons/actions are real, partial, fake, broken, or unverified.
- Auth/admin/security reality.
- First safe repair sequence.

## Absolute Forbidden Actions

Never do any of the following unless the user explicitly requests that exact action:

- Work directly on `main` for uncontrolled setup or repair work.
- Delete files or folders.
- Restore files or reset branches.
- Run broad repository scans repeatedly.
- Run expensive installs/builds/typechecks/migrations/deployments when the task does not call for them.
- Modify application source code during documentation/control-file tasks.
- Claim the project is production ready before evidence-based QA, security, release, and launch checks are complete.
- Expose secrets, tokens, service keys, JWTs, refresh tokens, reset tokens, or admin credentials.
- Add fake data, fake buttons, fake success states, or fake integrations.
- Treat Web/PWA as the real mobile application when the task concerns mobile.
- Silently fall back to fake/local/mock data in production paths.

## Security/Auth/Admin Rules

- Treat auth, admin access, password reset, and privileged routes as high risk.
- Admin-only behavior must be enforced server-side or through verified secure data policies, not only in the UI.
- Never rely on client-side role checks as the source of truth.
- Any security change requires explicit verification steps and a rollback-aware summary.
- Never log secrets, JWTs, refresh tokens, reset tokens, or private Supabase keys.
- Owner/admin panel work requires Security Lead review before acceptance.

## Supabase/RLS Rules

- Supabase Row Level Security must be considered mandatory for user-owned or privileged data.
- Do not disable RLS as a workaround.
- Policies must be least-privilege and tied to authenticated user identity or verified admin role.
- Service-role keys must never be exposed to frontend or mobile client code.
- Any RLS change must include policy intent, affected tables, and verification queries or smoke checks.

## Data Source Rules

- Identify the source of truth before changing data flows.
- Do not create duplicate competing data sources.
- Mock, seed, local, fallback, and production data must be clearly separated.
- Frontend/mobile views must not silently fall back to fake data in production paths.
- Any migration or data-shape change requires an explicit verification plan.
- Financial date sources must be the official owning Saudi government authority for each program.
- Source names and URLs must not be displayed inside user-facing financial/prayer cards; source explanation belongs in app information/about content.

## Frontend RTL/Mobile Rules

- Arabic and RTL behavior must be treated as a first-class requirement.
- Mobile layout must be verified for primary flows.
- Text must not overlap, truncate critical meaning, or break controls on small screens.
- Forms, navigation, dialogs, and admin screens must be usable in RTL.
- Visual-reference work must be isolated and verified separately from functional fixes.
- Visual references define identity, colors, cards, fonts, layout, and RTL behavior; do not copy phone frames, status bars, notches, clocks, or screenshot artifacts.
- The approved bottom navigation order is: `الرئيسية - الرواتب - الخدمات - التقويم - المزيد`.

## API/Backend Rules

- API routes must validate input and return predictable error responses.
- Authenticated and admin endpoints must enforce authorization on the server or through verified secure policy boundaries.
- Backend code must not trust client-submitted role or ownership fields.
- Error handling must avoid leaking internals or secrets.
- API changes require focused smoke checks for success and failure paths.

## Verification Rules

- Verification must match the scope of the task.
- Do not run expensive commands unless the task explicitly calls for them.
- Prefer focused checks over broad repeated scans.
- If a command is not run, report that honestly.
- Do not claim a fix is verified unless the verification actually ran and passed.
- UI/action work requires practical flow verification, not only static code checks.

## Definition of a Working Button or Action

A visible action is not accepted as working unless it has all applicable items:

1. Real press/click handler.
2. Real execution logic.
3. Real data read/write or side effect where required.
4. Loading state.
5. Success state.
6. Error state.
7. Visible UI update.
8. Persistence after refresh/reopen when data changes.
9. Authorization/ownership protection when protected data is involved.
10. Test evidence.

## Final Report Format

Every task report must follow:

`docs/AGENT_REPORT_TEMPLATE.md`

At minimum, every task report must include:

- Verdict.
- Role.
- Single task.
- Files read.
- Files changed.
- Commands run.
- Verification performed.
- Manual verification when relevant.
- Risks or gaps.
- Next safe step.

## Allowed Final Verdicts

Use only the verdicts required by the task or these default statuses:

- `ACCEPTED`
- `REJECTED`
- `NEEDS FIXES`
- `BLOCKED`
- `READY FOR NEXT STEP`

Do not use `production ready` unless release, security, QA, build, deployment, rollback, and launch gates are all satisfied.
