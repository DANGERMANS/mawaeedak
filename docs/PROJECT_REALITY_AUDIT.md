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
- Persistence model.
- Data ownership boundaries.

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
- Password/reset/session risk if applicable.

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
- Whether Web/PWA is being mistaken for real mobile.

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
- Audit logs or owner-action traceability if present.

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
- Execution logic.
- Data source.
- Persistence result.
- Loading state.
- Success state.
- Error handling.
- Authorization boundary when relevant.
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
- Rollback/release evidence if present.

### 11. Business and Product Reality

Inspect and report:

- Current product scope.
- Current launch-critical flows.
- Features that are real vs planned.
- Features that look user-facing but are not functionally complete.
- Any roadmap or priority conflicts.
- Any monetization/business assumptions found.

### 12. Legal, Privacy, and Store Reality

Inspect and report:

- Privacy policy presence/status.
- Terms/status.
- Disclaimer/status.
- Account deletion/data deletion flow.
- Data permissions and consent text.
- App Store/Google Play metadata readiness if present.
- Store screenshots/assets readiness if present.
- Store rejection risks.

### 13. Support and Customer Operations Reality

Inspect and report:

- Support/contact path.
- Complaints/suggestions flow.
- Escalation categories.
- Response ownership.
- User-facing help content.
- Support data privacy risk.

### 14. Observability, Incident, Backup, and Cost Reality

Inspect and report:

- Crash/error monitoring.
- Logs and alert ownership.
- Incident severity model.
- Rollback plan.
- Backup plan.
- Restore test evidence.
- External services and recurring cost drivers.
- Cost/budget risk.

### 15. Official Data, Arabic, Localization, and Accessibility Reality

Inspect and report:

- Official financial-date source model.
- Prayer-time source model.
- News/jobs source model.
- Data freshness/update model.
- Approval status handling.
- Arabic wording quality.
- RTL quality.
- Font/readability quality.
- Contrast/touch target/accessibility risks.

### 16. AI Context and Decision Log Reality

Inspect and report:

- Whether approved project decisions are documented.
- Whether agent context files exist and are current.
- Whether repeated-error prevention exists.
- Whether next tasks can be executed without relying on old chat context.
- Missing decision-log entries.

### 17. Risk Register

Classify risks:

| Severity | Risk | Evidence | Root Cause | Required Owner |
|---|---|---|---|---|
| Critical |  |  |  |  |
| High |  |  |  |  |
| Medium |  |  |  |  |
| Low |  |  |  |  |

Required owners may include:

- CEO.
- CTO.
- Product Director.
- Principal Software Architect.
- Mobile Principal Engineer.
- Backend/API Lead.
- Database/Supabase Architect.
- Design Systems Lead.
- QA Lead.
- Security Lead.
- Privacy/Compliance Lead.
- Legal/App Compliance Lead.
- App Store/ASO Release Lead.
- Customer Support Lead.
- Incident Manager.
- Backup & Disaster Recovery Lead.
- SRE/Observability Engineer.
- Cost/FinOps Lead.
- Data Quality/Official Sources Lead.
- Accessibility QA Lead.
- Arabic Copy/Localization Lead.
- AI Context Librarian.

### 18. First Safe Repair Sequence

List the first five repair tasks only.

Each task must include:

- Role owner.
- Single task.
- Scope.
- Files likely involved.
- Required verification.
- Acceptance criteria.
- Required reviewers.

Do not recommend broad tasks like `fix the whole app`.

### 19. Audit Files Read

List all files read.

### 20. Commands Run

List all commands run and results.

### 21. Final Audit Decision

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
- Claim launch readiness.
- Claim store readiness.
- Open multiple repair tasks.

The audit exists to identify reality before repair.
