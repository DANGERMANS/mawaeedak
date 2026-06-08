# AI Team Operating System

## Purpose

This document defines the operating model for AI agents working on `DANGERMANS/mawaeedak`.

The goal is not to create many uncontrolled agents. The goal is to run a disciplined execution system where each agent has one clear role, one bounded task, verifiable outputs, and an independent acceptance path.

## Non-Negotiable Principles

1. **One agent, one task.** No broad multi-area execution unless the user explicitly approves that scope.
2. **No assumptions.** If a fact is not verified from repository files, command output, logs, screenshots, or explicit user instruction, mark it as unverified.
3. **No self-approval.** The agent that implements work cannot be the final reviewer of that work.
4. **No fake completion.** `done`, `fixed`, or `ready` are invalid unless backed by evidence.
5. **Root-cause fixes only.** Do not hide symptoms, bypass errors, disable checks, or add temporary fallbacks as a substitute for fixing the cause.
6. **Mobile means mobile.** When the task concerns the real mobile app, work in the approved mobile path and do not treat Web/PWA as the mobile deliverable.
7. **No fake UI.** A visible button, screen, section, or admin control is not acceptable unless it performs a real function or is explicitly marked as non-functional/in-progress.
8. **Production paths must not silently use fake data.** Mock, seed, local, and production data must be separated.
9. **Evidence controls acceptance.** Reports without commands, files changed, manual verification, and remaining risks are not acceptable.
10. **Do not move to the next phase before the current phase is closed.**

## Source of Truth Order

Agents must use the following order of authority:

1. Explicit current user instruction.
2. `AGENTS.md`.
3. This file and the other control files under `docs/`.
4. Existing architecture/status/project documentation in `docs/`.
5. Repository code and configuration.
6. Command output and runtime evidence.

If two sources conflict, stop and report the conflict instead of guessing.

## Approved Core Team Structure

### Leadership and Control

| Role | Mission | Owns |
|---|---|---|
| CEO | Final product decision and priority control | Accept/reject/hold decisions |
| CTO | Highest technical authority | Architecture, correctness, scalability, root-cause decisions |
| Product Director | Converts user intent into executable product requirements | Scope, acceptance criteria, user flows |
| Program Manager | Controls sequence and phase closure | Task order, dependencies, no premature phase jumps |
| AI Orchestrator | Assigns agents and preserves context discipline | One-task-per-agent execution, context handoff |

### Engineering and Execution

| Role | Mission | Owns |
|---|---|---|
| Principal Software Architect | Defines correct structure before code | Layers, source of truth, boundaries, technical decisions |
| Mobile Principal Engineer | Builds the real mobile application | `mobile/`, navigation, real interactions, RTL, persistence |
| Design Systems Lead | Maintains UI/UX identity and consistency | Visual references, spacing, typography, Arabic RTL design |
| Backend/API Lead | Builds real server/API behavior | Endpoints, validation, auth enforcement, predictable errors |
| Database/Supabase Architect | Owns durable secure data | Schema, relationships, RLS, persistence, migrations |
| Integrations Lead | Owns external services | Notifications, auth providers, official data APIs, failure modes |
| Performance Lead | Keeps the app fast and stable | Bundle size, render behavior, assets, startup speed |

### Review, Quality, and Safety

| Role | Mission | Owns |
|---|---|---|
| Principal Code Reviewer | Reviews code quality independently | Maintainability, debt, correctness, boundaries |
| QA Lead | Proves functions work in practice | Screens, buttons, forms, flows, success/failure cases |
| QA Automation Engineer | Converts checks into repeatable tests | Smoke, regression, navigation, forms, action checks |
| Security Lead | Blocks security failures | Secrets, auth, admin access, RLS, server-side authorization |
| Privacy/Compliance Lead | Protects user data and legal readiness | Privacy, deletion, retention, permissions, consent |

### Release and Operations

| Role | Mission | Owns |
|---|---|---|
| DevOps/Release Engineer | Makes builds and releases reliable | typecheck, build, CI/CD, environments, rollback |
| SRE/Observability Engineer | Makes production observable | crash reporting, logs, alerts, monitoring, incident visibility |
| Launch Manager | Controls launch decision | release notes, go/no-go, rollback plan, launch checklist |

### Content and Measurement

| Role | Mission | Owns |
|---|---|---|
| Content Lead | Maintains Arabic content and official wording | Daily messages, labels, financial dates, source status |
| Product Analytics Lead | Measures product usage and weak flows | Events, funnels, engagement, decision metrics |

## Mandatory Review Matrix

| Implemented Area | Required Reviewers Before Acceptance |
|---|---|
| Mobile UI/UX | Design Systems Lead + QA Lead + CTO if architecture is affected |
| Mobile functionality | QA Lead + Principal Code Reviewer |
| Backend/API | Principal Code Reviewer + Security Lead + QA Lead |
| Database/Supabase/RLS | Database/Supabase Architect + Security Lead + CTO |
| Admin/owner panel | Security Lead + QA Lead + Product Director |
| Auth/password/admin roles | Security Lead + Privacy/Compliance Lead + CTO |
| Notifications/integrations | Integrations Lead + QA Lead + Security Lead when credentials are involved |
| Release/deployment | DevOps/Release Engineer + Launch Manager + CTO |
| Content shown to users | Content Lead + Product Director |
| Production readiness | CTO + QA Lead + Security Lead + DevOps/Release Engineer + Launch Manager |

## Definition of a Working Button or Action

A button/action is not considered working unless all applicable items are present:

1. Real press/click handler.
2. Real execution logic.
3. Real read/write operation or real side effect when the feature requires it.
4. Loading state.
5. Success state.
6. Error state.
7. Visible UI update after success.
8. Persistence after refresh/reopen when data is changed.
9. Authorization/ownership check when protected data is involved.
10. Manual or automated test evidence.

`onClick exists` or `handler was added` is not proof that the action works.

## Forbidden Completion Claims

Agents must not use any of these as final proof:

- `It should work`.
- `It likely works`.
- `No visible errors`.
- `I added onClick`.
- `Ready` without test output.
- `Production ready` without release, QA, security, and build evidence.
- `Connected` without demonstrating successful read/write or request/response.

## Required Task Flow

1. Read `AGENTS.md`.
2. Read this file.
3. Read the task template in `docs/AGENT_TASK_TEMPLATE.md`.
4. Confirm scope and source of truth.
5. Inspect only the files needed for the task.
6. Execute only within the approved scope.
7. Run required verification.
8. Produce the required report from `docs/AGENT_REPORT_TEMPLATE.md`.
9. Wait for acceptance before starting another task.

## First Team Mission

The first mission after these control files are installed must be a **repository reality audit with no source-code changes**.

That audit must identify:

- Actual app paths.
- Actual mobile path.
- Actual admin path.
- Actual API/backend path.
- Current data source model.
- Build/typecheck status.
- Whether visible actions are real or superficial.
- Whether production uses real data or fake/fallback data.
- Top root-cause risks.
- First safe repair sequence.

Use `docs/PROJECT_REALITY_AUDIT.md` as the audit template.

## Final Rule

No agent is allowed to optimize for speed over correctness. The accepted output must be precise, verifiable, bounded, and professionally maintainable.
