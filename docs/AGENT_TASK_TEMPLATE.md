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
- docs/ACCEPTANCE_GATES.md
- This task
- Relevant repository files discovered during inspection

Business/Product Impact:
- State whether this affects launch scope, user value, roadmap, monetization, or product positioning.
- If not applicable, write: Not applicable.

Security/Privacy/Legal/Store Impact:
- State whether this touches auth, admin, user data, privacy, terms, app-store policy, or legal claims.
- If not applicable, write: Not applicable.

Support/Operations/Cost Impact:
- State whether this touches support flow, monitoring, incidents, backups, external services, or recurring costs.
- If not applicable, write: Not applicable.

Official Data/Arabic/Accessibility Impact:
- State whether this touches official dates/sources, Arabic copy, localization, RTL, readability, contrast, or touch targets.
- If not applicable, write: Not applicable.

Files/Folders Allowed to Read:

Files/Folders Allowed to Modify:

Hard Prohibitions:
- Do not work outside the approved scope.
- Do not modify files outside the allowed list unless you stop and request approval.
- Do not claim completion without evidence.
- Do not hide, bypass, or suppress errors.
- Do not add fake data or fake UI behavior.
- Do not treat Web/PWA as the real mobile app when the task concerns mobile.
- Do not expose secrets, tokens, service keys, JWTs, refresh tokens, reset tokens, or admin credentials.
- Do not make legal, store, official-source, launch, or production-readiness claims without evidence.
- Do not add recurring cost, external dependency, analytics, tracking, or notifications without reporting impact.
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
- Security/privacy/legal/store/support/operations/data/accessibility verification when applicable.

Acceptance Criteria:
1.
2.
3.
4.
5.

Required Reviewers:
- Code Review:
- QA Review:
- Security Review:
- Privacy/Compliance Review:
- Legal/App Compliance Review:
- CTO Review:
- Product Review:
- Release/Launch Review:
- Other Required Owner:

Evidence Required in Final Report:
- Files read.
- Files changed.
- Exact commands run.
- Exact command results.
- Manual verification performed.
- Screens/flows tested when relevant.
- Security/privacy/legal/store/support/operations/data/accessibility impact when relevant.
- Risks or gaps remaining.
- Final verdict.
- Next safe step.

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
6. What business/product/security/privacy/legal/support/operations/data/accessibility impact exists?
7. What is the next safe step only after acceptance?

If any answer is missing, the agent must stop and request clarification.

## Task Size Limits

A single task must not combine unrelated work such as:

- UI redesign + database migration.
- Auth changes + visual polish.
- Backend deployment + mobile navigation.
- Admin panel rebuild + production readiness claim.
- Store release + backend repair.
- Legal policy + feature implementation.
- Observability + UI redesign.
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
Required Reviewers: QA Lead + Security Lead for admin-protected actions.
```

### Good

```text
Role: App Store/ASO Release Lead
Single Task: Audit App Store and Google Play readiness materials without modifying application code.
Scope: Store metadata, screenshots, legal links, review-risk checklist.
Files Allowed to Modify: Documentation only, if explicitly approved.
Required Verification: Evidence of required metadata and blockers.
```

### Bad

```text
Fix the whole app and make everything work.
```

The bad example is rejected because it has no boundary, no reviewer, no acceptance criteria, no impact analysis, and no proof model.
