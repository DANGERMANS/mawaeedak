# Project Reality Audit

This is the required first mission after installing the AI team control files.

The audit is **inspection only**. Do not modify application source code during this audit.

## Audit Verdict

Use one of:

- `READY FOR CONTROLLED REPAIR`
- `BLOCKED`
- `NEEDS DEEPER INSPECTION`

Do not use `production ready` in this audit.

## Required Audit Scope

### 1. Repository Identity

- Repository:
- Branch:
- Latest commit inspected:
- Auditor role:
- Date/time:

### 2. Paths and Architecture

Identify actual paths for:

- Mobile app:
- Web/frontend app:
- Admin/owner panel:
- API/backend server:
- Shared packages/libraries:
- Scripts:
- Docs:
- Config files:

Classify each as:

- Active.
- Legacy.
- Unknown.
- Broken.
- Out of scope.

### 3. Package and Command Inventory

For every relevant `package.json`, document:

- Path.
- Scripts available.
- Build command.
- Typecheck command.
- Test command.
- Lint command.
- Start/dev command.

### 4. Data Source Model

Identify:

- Primary production data source.
- Local/dev data source.
- Mock/seed/fallback data.
- Any competing data sources.
- Whether production can silently fall back to fake/local data.
- Supabase usage.
- API server usage.
- localStorage usage.

### 5. Auth/Admin/Security Reality

Inspect and report:

- Auth provider(s).
- Admin role enforcement location.
- Client-side role checks.
- Server-side authorization.
- RLS presence/status.
- Exposed secret risk.
- Admin route protection.
- User data isolation risk.

### 6. Mobile Reality

If `mobile/` exists, inspect:

- Framework.
- Entry point.
- Navigation structure.
- Key screens.
- Bottom nav order.
- RTL support.
- Persistence approach.
- Notification approach.
- Whether screens are functional or mostly static.

### 7. Admin/Owner Panel Reality

Inspect:

- Path.
- Sections present.
- Data reads.
- Data writes.
- Buttons/actions.
- Auth/admin protection.
- Persistence.
- Fake/superficial controls.

### 8. Button and Action Reality Sampling

Select representative actions from:

- Mobile app.
- Admin panel.
- Auth flow.
- Data CRUD.
- Notifications/integrations.

Classify each as:

- `WORKING`
- `PARTIAL`
- `FAKE/SUPERFICIAL`
- `BROKEN`
- `UNVERIFIED`

For each sampled action, include:

- File path.
- Handler/function.
- Data source.
- Persistence result.
- Error handling.
- Evidence.

### 9. Build/Typecheck/Test Reality

Run only approved commands for this audit.

Document:

- Command.
- Working directory.
- Result.
- Error summary if failed.
- Whether failure blocks repair.

If commands are intentionally not run, explain why.

### 10. Production/Deployment Reality

Inspect:

- Vercel config.
- Expo/EAS config if present.
- API deployment config.
- Environment variables examples.
- Production build path.
- Known deployment blockers.
- Web vs mobile deployment distinction.

### 11. Risk Register

Classify risks:

| Severity | Risk | Evidence | Root Cause | Required Owner |
|---|---|---|---|---|
| Critical |  |  |  |  |
| High |  |  |  |  |
| Medium |  |  |  |  |
| Low |  |  |  |  |

### 12. First Safe Repair Sequence

List the first five repair tasks only.

Each task must include:

- Role owner.
- Single task.
- Scope.
- Files likely involved.
- Required verification.
- Acceptance criteria.

Do not recommend broad tasks like `fix the whole app`.

### 13. Audit Files Read

List all files read.

### 14. Commands Run

List all commands run and results.

### 15. Final Audit Decision

Use this format:

```text
Verdict:

Why:

Top blockers:
1.
2.
3.

First safe next step:
```

## Audit Prohibitions

During this audit, do not:

- Modify application source code.
- Rebuild architecture.
- Add features.
- Delete files.
- Change data sources.
- Edit environment variables.
- Claim production readiness.
- Open multiple repair tasks.

The audit exists to identify reality before repair.
