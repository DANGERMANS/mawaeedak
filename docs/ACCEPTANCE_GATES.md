# Acceptance Gates

This document defines the required gates before any agent work in `DANGERMANS/mawaeedak` can be accepted.

## Gate 0 — Authority Check

Before execution, the agent must confirm:

- The repository is `DANGERMANS/mawaeedak`.
- The branch is the approved branch for the task.
- `AGENTS.md` was read.
- `docs/AI_TEAM_OPERATING_SYSTEM.md` was read.
- The task has one clear role and one clear objective.

Fail condition: the agent starts changing files without confirming scope.

## Gate 1 — Scope Lock

The task must define:

- In scope.
- Out of scope.
- Files/folders allowed to read.
- Files/folders allowed to modify.
- Prohibited actions.
- Expected evidence.

Fail condition: the agent modifies unrelated files, expands scope, or combines audit and implementation without approval.

## Gate 2 — Reality Inspection

The agent must inspect the real repository state before proposing or implementing changes.

Required checks depend on task type, but may include:

- Relevant file paths exist.
- Current implementation is understood.
- Current data source is identified.
- Current navigation/action wiring is verified.
- Current tests/scripts are identified from `package.json` files.
- Current legal/store/support/observability/backup/cost readiness is identified when relevant.

Fail condition: the agent acts from memory, assumption, or generic advice rather than repository evidence.

## Gate 3 — Root-Cause Decision

Before implementation, the agent must identify the root cause or state that the task is only an audit.

For implementation tasks, the report must distinguish:

- Root cause.
- Files affected.
- Why the selected fix is correct.
- What risks remain.

Fail condition: the agent patches symptoms, disables checks, suppresses errors, or adds fake fallbacks.

## Gate 4 — Implementation Discipline

Implementation must follow these rules:

- Change only approved files.
- Keep changes minimal but complete.
- Preserve existing working behavior.
- Do not introduce duplicate data sources.
- Do not add fake UI actions.
- Do not expose secrets.
- Do not downgrade security.
- Do not add operational cost without reporting the impact.
- Do not add store/legal/support claims without evidence.

Fail condition: broad unrelated rewrites, unapproved deletion, fake data, fake buttons, weakened auth/RLS, or unsupported launch/store/legal readiness claims.

## Gate 5 — Functional Verification

Verification must match the task.

Required when applicable:

```bash
npm run typecheck
npm run build
npm run lint
npm test
```

If a command is unavailable, the agent must report that honestly and cite the relevant `package.json` or command output.

Fail condition: claiming verification without running it, or omitting why it was not run.

## Gate 6 — Manual Product Verification

For UI, mobile, admin, or user-flow tasks, command checks are not enough.

The agent must verify relevant user flows such as:

- Open screen.
- Trigger action.
- Enter data.
- Save.
- Confirm UI update.
- Refresh/reopen when persistence is required.
- Test failure/error state.
- Test authorization boundary when applicable.
- Test Arabic/RTL readability and touch usability when user-facing.

Fail condition: claiming a button works only because a handler exists.

## Gate 7 — Security, Privacy, Legal, and Data Review

Required for any task touching:

- Auth.
- Admin routes.
- User data.
- Supabase policies.
- Backend authorization.
- Environment variables.
- Notifications or external credentials.
- Account deletion or privacy settings.
- Store/legal user-facing claims.
- Official financial/prayer/news/job data.
- Analytics or tracking.

Fail condition: sensitive changes without the required Security Lead, Privacy/Compliance Lead, Legal/App Compliance Lead, or Data Quality/Official Sources Lead review.

## Gate 8 — Independent Review

No implementer can accept their own implementation.

Minimum review expectations:

- Code changes: Principal Code Reviewer.
- User-facing functionality: QA Lead.
- UI readability/accessibility: Accessibility QA Lead.
- Security-sensitive work: Security Lead.
- Privacy/user-data work: Privacy/Compliance Lead.
- Legal/store-policy-sensitive work: Legal/App Compliance Lead.
- Official data work: Data Quality/Official Sources Lead.
- Architecture changes: CTO.
- Release changes: DevOps/Release Engineer + Launch Manager.
- Store release changes: App Store/ASO Release Lead + Launch Manager.
- Support flow changes: Customer Support Lead.
- Cost-affecting infrastructure changes: Cost/FinOps Lead.

Fail condition: final acceptance by the same agent that implemented the work or missing required independent owner.

## Gate 9 — Final Report Quality

Every final report must include:

- Verdict.
- Files read.
- Files changed.
- Commands run.
- Command results.
- Manual verification.
- Evidence summary.
- Risks/gaps.
- Next safe step.

Fail condition: vague report, missing evidence, no risks, or unsupported `ready` claim.

## Gate 10 — Phase Closure

A phase is closed only when:

- Required implementation is complete.
- Required verification passed or failures are documented.
- QA accepted relevant flows.
- Security accepted sensitive changes.
- Privacy/legal/store/data/support/operations owners accepted relevant areas.
- Remaining risks are known and assigned.
- The next safe step is exactly one step.

Fail condition: moving to a new phase with unresolved critical defects or unresolved launch/company-readiness blockers.

## Gate 11 — Company Readiness Gate

Required before any production-readiness or launch claim.

The report must cover:

- Business value and launch scope.
- App Store/Google Play readiness.
- Legal pages and user-facing policy links.
- Privacy and account deletion readiness.
- Customer support and complaint escalation readiness.
- Incident response owner and severity model.
- Backup and recovery plan for durable data.
- Crash/error monitoring and alerting plan.
- Official data quality and freshness model.
- Accessibility blockers.
- Arabic copy/localization quality.
- Cost and external-service risk.
- AI context/decision log update.

Fail condition: claiming launch/production readiness while any item is missing, unverified, or unassigned.

## Severity Rules

### Critical — must block acceptance

- Build failure in touched workspace.
- Typecheck failure caused or left unresolved by task.
- Data loss risk.
- Exposed secrets.
- User/admin authorization bypass.
- Fake UI presented as working.
- Production path silently using fake data.
- Broken login/admin access.
- No account deletion/privacy path for launch-sensitive user data.
- No rollback/recovery plan for launch.
- Store/legal blocker likely to reject app submission.

### High — usually blocks acceptance

- Missing persistence for saved data.
- Missing error state for important actions.
- Incomplete mobile navigation for required flows.
- RLS or backend authorization ambiguity.
- Major RTL/layout break.
- Missing customer support escalation path.
- Missing crash/error monitoring plan.
- Official data freshness/source ambiguity.
- Unbounded recurring external-service cost risk.

### Medium — may be accepted with documented follow-up

- Non-critical visual inconsistency.
- Missing analytics.
- Minor performance concern.
- Documentation gap that does not affect operation.
- Non-blocking accessibility issue.
- Store metadata improvement not required for current phase.

### Low — does not block acceptance

- Small copy/style issue.
- Non-critical cleanup.
- Optional enhancement.

## Final Acceptance Language

Use only these final statuses unless the user specifies another format:

- `ACCEPTED`
- `REJECTED`
- `NEEDS FIXES`
- `BLOCKED`
- `READY FOR NEXT STEP`

Do not use `production ready` unless launch gates, QA, security, privacy, legal/store, build, deployment, observability, support, recovery, cost, and rollback requirements are all satisfied.
