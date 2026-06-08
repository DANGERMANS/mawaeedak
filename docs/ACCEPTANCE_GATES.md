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

Fail condition: broad unrelated rewrites, unapproved deletion, fake data, fake buttons, or weakened auth/RLS.

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

Fail condition: claiming a button works only because a handler exists.

## Gate 7 — Security and Privacy Review

Required for any task touching:

- Auth.
- Admin routes.
- User data.
- Supabase policies.
- Backend authorization.
- Environment variables.
- Notifications or external credentials.
- Account deletion or privacy settings.

Fail condition: security-sensitive changes without Security Lead or Privacy/Compliance review.

## Gate 8 — Independent Review

No implementer can accept their own implementation.

Minimum review expectations:

- Code changes: Principal Code Reviewer.
- User-facing functionality: QA Lead.
- Security-sensitive work: Security Lead.
- Architecture changes: CTO.
- Release changes: DevOps/Release Engineer + Launch Manager.

Fail condition: final acceptance by the same agent that implemented the work.

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
- Remaining risks are known and assigned.
- The next safe step is exactly one step.

Fail condition: moving to a new phase with unresolved critical defects.

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

### High — usually blocks acceptance

- Missing persistence for saved data.
- Missing error state for important actions.
- Incomplete mobile navigation for required flows.
- RLS or backend authorization ambiguity.
- Major RTL/layout break.

### Medium — may be accepted with documented follow-up

- Non-critical visual inconsistency.
- Missing analytics.
- Minor performance concern.
- Documentation gap that does not affect operation.

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

Do not use `production ready` unless launch gates, QA, security, build, deployment, and rollback requirements are all satisfied.
