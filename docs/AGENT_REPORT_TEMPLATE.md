# Agent Report Template

Every agent must use this exact structure for final reports.

Do not submit a report that says only `done`, `fixed`, `ready`, or `implemented`.

```text
Verdict:
ACCEPTED / REJECTED / NEEDS FIXES / BLOCKED / READY FOR NEXT STEP

Role:

Single Task:

Branch:

Files Read:
- 

Files Changed:
- 

Commands Run:
- Command:
  Result:
  Notes:

Manual Verification:
- Flow:
  Steps:
  Result:
  Evidence:

What Was Completed:
- 

What Was Not Completed:
- 

Root Cause Found:
- 

Fix Summary:
- 

Security/Privacy Impact:
- 

Data/Persistence Impact:
- 

Risks or Gaps Remaining:
- 

Reviewer Requirements:
- Code Review:
- QA Review:
- Security Review:
- CTO Review:

Next Safe Step:
- 
```

## Report Rules

1. If no files changed, write `None` under `Files Changed`.
2. If a command was not run, state `Not run` and explain why.
3. If manual verification was not possible, state the blocker.
4. If the task was audit-only, do not include a fix summary that implies implementation.
5. If the task touched auth, admin, RLS, secrets, or user data, Security/Privacy Impact cannot be `None` without explanation.
6. If the task touched data writes, Data/Persistence Impact must explain how persistence was verified.
7. The next safe step must be exactly one step.

## Rejection Triggers

Reject the report if it contains any of these without evidence:

- `Everything works`.
- `No issues`.
- `Production ready`.
- `Fully fixed`.
- `Connected successfully`.
- `All buttons work`.

These claims require detailed evidence.

## Minimum Evidence by Task Type

### UI/UX Task

Required evidence:

- Files changed.
- Screen/flow tested.
- RTL/mobile behavior considered.
- Before/after explanation or screenshots if available.
- Build/typecheck when applicable.

### Button/Action Task

Required evidence:

- Handler exists.
- Execution logic exists.
- Success path tested.
- Error path tested.
- UI update verified.
- Persistence verified when data changes.

### Backend/API Task

Required evidence:

- Endpoint or service files changed.
- Validation behavior.
- Success response.
- Failure response.
- Authorization behavior.
- Typecheck/build/test results.

### Database/Supabase Task

Required evidence:

- Tables/policies/migrations affected.
- RLS intent.
- Verification query or smoke check.
- Auth/admin boundary.
- Rollback risk.

### Audit Task

Required evidence:

- Files read.
- Commands run.
- Findings classified by severity.
- No source-code changes unless explicitly approved.
- First safe repair sequence.

### Release Task

Required evidence:

- Build output.
- Environment targeted.
- Deployment result or blocker.
- Rollback plan.
- Release risk summary.
