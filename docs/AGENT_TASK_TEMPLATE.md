# Agent Task Template

Use this template for every agent assignment.

Do not give agents broad informal instructions. Every task must be bounded, testable, and assigned to one primary role.

```text
Role:

Single Task:

Objective:

Repository:
DANGERMANS/mawaeedak

Required Branch:

Scope:

Out of Scope:

Source of Truth:
- AGENTS.md
- docs/AI_TEAM_OPERATING_SYSTEM.md
- This task
- Relevant repository files discovered during inspection

Files/Folders Allowed to Read:

Files/Folders Allowed to Modify:

Hard Prohibitions:
- Do not work outside the approved scope.
- Do not modify files outside the allowed list unless you stop and request approval.
- Do not claim completion without evidence.
- Do not hide, bypass, or suppress errors.
- Do not add fake data or fake UI behavior.
- Do not treat Web/PWA as the real mobile app when the task concerns mobile.
- Do not expose secrets, tokens, service keys, or admin credentials.
- Do not move to a second task.

Execution Steps:
1.
2.
3.
4.
5.

Required Verification:
- npm run typecheck, if applicable to the touched workspace.
- npm run build, if applicable to the touched workspace.
- npm run lint, if available and applicable.
- npm test, if available and applicable.
- Manual verification steps specific to the feature.

Acceptance Criteria:
1.
2.
3.
4.
5.

Evidence Required in Final Report:
- Files read.
- Files changed.
- Exact commands run.
- Exact command results.
- Manual verification performed.
- Screens/flows tested when relevant.
- Risks or gaps remaining.
- Final verdict.

Final Report Format:
Use docs/AGENT_REPORT_TEMPLATE.md exactly.
```

## Task Quality Rules

A valid task must answer all of these before execution starts:

1. What is the one thing being done?
2. Where is it being done?
3. What must not be touched?
4. What proves it works?
5. Who reviews it?
6. What is the next safe step only after acceptance?

If any answer is missing, the agent must stop and request clarification.

## Task Size Limits

A single task must not combine unrelated work such as:

- UI redesign + database migration.
- Auth changes + visual polish.
- Backend deployment + mobile navigation.
- Admin panel rebuild + production readiness claim.
- Audit + implementation.

Split those into separate tasks with separate acceptance gates.

## Correct Task Examples

### Good

```text
Role: QA Lead
Single Task: Audit all owner-panel buttons and classify each as working, partial, fake, or broken without modifying code.
Scope: Owner/admin panel only.
Files Allowed to Modify: None.
Required Verification: Manual flow evidence and command checks where applicable.
```

### Bad

```text
Fix the whole app and make everything work.
```

The bad example is rejected because it has no boundary, no reviewer, no acceptance criteria, and no proof model.
