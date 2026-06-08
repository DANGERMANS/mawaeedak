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

Business/Product Impact:
- 

Security Impact:
- 

Privacy/Compliance Impact:
- 

Legal/App Store Impact:
- 

Data/Persistence Impact:
- 

Official Data/Source Quality Impact:
- 

Arabic/Localization Impact:
- 

Accessibility Impact:
- 

Support/Customer Impact:
- 

Operations/Observability Impact:
- 

Backup/Disaster Recovery Impact:
- 

Cost/FinOps Impact:
- 

AI Context/Decision Log Impact:
- 

Risks or Gaps Remaining:
- 

Reviewer Requirements:
- Code Review:
- QA Review:
- Accessibility QA Review:
- Security Review:
- Privacy/Compliance Review:
- Legal/App Compliance Review:
- Product Review:
- CTO Review:
- Release/Launch Review:
- Other Required Owner:

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
7. If the task touched official dates, prayer data, news/jobs, or public factual content, Official Data/Source Quality Impact cannot be `None` without explanation.
8. If the task touched user-facing Arabic, Arabic/Localization Impact cannot be `None` without explanation.
9. If the task touched UI, Accessibility Impact must mention font size/readability/contrast/touch target risk, even if no issue is found.
10. If the task touched launch/store/legal pages, Legal/App Store Impact cannot be `None` without explanation.
11. If the task added or changed external services, analytics, notifications, storage, hosting, or AI usage, Cost/FinOps Impact cannot be `None` without explanation.
12. The next safe step must be exactly one step.

## Rejection Triggers

Reject the report if it contains any of these without evidence:

- `Everything works`.
- `No issues`.
- `Production ready`.
- `Fully fixed`.
- `Connected successfully`.
- `All buttons work`.
- `Store ready`.
- `Official data verified`.
- `Secure`.
- `No privacy risk`.

These claims require detailed evidence.

## Minimum Evidence by Task Type

### UI/UX Task

Required evidence:

- Files changed.
- Screen/flow tested.
- RTL/mobile behavior considered.
- Accessibility risk considered.
- Arabic copy/localization considered.
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
- Authorization verified when protected data is involved.

### Backend/API Task

Required evidence:

- Endpoint or service files changed.
- Validation behavior.
- Success response.
- Failure response.
- Authorization behavior.
- Typecheck/build/test results.
- Security/privacy impact.

### Database/Supabase Task

Required evidence:

- Tables/policies/migrations affected.
- RLS intent.
- Verification query or smoke check.
- Auth/admin boundary.
- Rollback risk.
- Backup/recovery risk when durable data is affected.

### Audit Task

Required evidence:

- Files read.
- Commands run.
- Findings classified by severity.
- No source-code changes unless explicitly approved.
- Company-readiness gaps classified when relevant.
- First safe repair sequence.

### Release/Store Task

Required evidence:

- Build output.
- Environment targeted.
- Deployment result or blocker.
- App Store/Google Play metadata status when relevant.
- Legal/privacy/support links status when relevant.
- Rollback plan.
- Release risk summary.

### Support/Operations Task

Required evidence:

- Support/contact path.
- Escalation model.
- Incident owner.
- Monitoring/logging status.
- User-impact handling.
- Remaining gaps.

### Official Data Task

Required evidence:

- Owning official source.
- Freshness/update model.
- Approval status.
- Fallback behavior.
- User-facing display rules.

### Cost/FinOps Task

Required evidence:

- Services affected.
- Cost driver.
- Usage risk.
- Budget/alert recommendation.
- Owner for follow-up.
