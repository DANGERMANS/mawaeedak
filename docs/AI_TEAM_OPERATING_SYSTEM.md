# AI Team Operating System

## Purpose

This document defines the operating model for AI agents working on `DANGERMANS/mawaeedak`.

The goal is not to create many uncontrolled agents. The goal is to run a disciplined execution system where each agent has one clear role, one bounded task, verifiable outputs, and an independent acceptance path.

This model must operate like a complete technology company, not a loose group of coding agents. It includes leadership, product, engineering, QA, security, release, operations, legal/compliance, customer support, business strategy, data quality, cost control, and AI context governance.

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
11. **Company readiness is broader than code.** Store readiness, legal readiness, support readiness, observability, incident handling, backups, data quality, and costs must be considered before launch.
12. **Project context must be preserved.** Agents must not lose established decisions, repeat old mistakes, or overwrite approved product rules.

## Source of Truth Order

Agents must use the following order of authority:

1. Explicit current user instruction.
2. `AGENTS.md`.
3. This file and the other control files under `docs/`.
4. Existing architecture/status/project documentation in `docs/`.
5. Repository code and configuration.
6. Command output and runtime evidence.

If two sources conflict, stop and report the conflict instead of guessing.

## Approved Complete Company Team Structure

### Leadership and Control

| Role | Mission | Owns |
|---|---|---|
| CEO | Final product decision and priority control | Accept/reject/hold decisions |
| CTO | Highest technical authority | Architecture, correctness, scalability, root-cause decisions |
| Product Director | Converts user intent into executable product requirements | Scope, acceptance criteria, user flows |
| Program Manager | Controls sequence and phase closure | Task order, dependencies, no premature phase jumps |
| AI Orchestrator | Assigns agents and preserves context discipline | One-task-per-agent execution, context handoff |
| Business Strategy Lead | Protects business direction and value | Priorities, launch value, monetization assumptions, roadmap tradeoffs |
| AI Context Librarian | Preserves project memory and decisions | Decision log, approved constraints, repeated-error prevention, context packs |

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
| Accessibility QA Lead | Ensures usability for all users | Contrast, font sizes, touch targets, screen sizes, readability, accessibility defects |
| Security Lead | Blocks security failures | Secrets, auth, admin access, RLS, server-side authorization |
| Privacy/Compliance Lead | Protects user data and legal readiness | Privacy, deletion, retention, permissions, consent |
| Legal/App Compliance Lead | Protects legal and platform compliance | Terms, privacy, disclaimers, App Store/Google Play policy risks, user rights |

### Release, Store, and Operations

| Role | Mission | Owns |
|---|---|---|
| DevOps/Release Engineer | Makes builds and releases reliable | typecheck, build, CI/CD, environments, rollback |
| SRE/Observability Engineer | Makes production observable | crash reporting, logs, alerts, monitoring, incident visibility |
| Launch Manager | Controls launch decision | release notes, go/no-go, rollback plan, launch checklist |
| App Store/ASO Release Lead | Prepares store release quality | App Store/Google Play metadata, screenshots, descriptions, keywords, review-risk checks |
| Incident Manager | Controls production incidents | Severity, triage, owner assignment, incident timeline, user impact, postmortem |
| Backup & Disaster Recovery Lead | Protects recovery capability | Backups, restore tests, data-loss plan, disaster recovery runbook |
| Cost/FinOps Lead | Controls operational cost | Supabase, hosting, APIs, notifications, AI usage, budget alerts, cost-risk reporting |

### Content, Data, Support, and Measurement

| Role | Mission | Owns |
|---|---|---|
| Content Lead | Maintains Arabic content and official wording | Daily messages, labels, financial dates, source status |
| Arabic Copy/Localization Lead | Polishes Arabic product language | Saudi Arabic clarity, formal/user-facing tone, labels, errors, notifications |
| Data Quality/Official Sources Lead | Verifies official data integrity | Financial dates, prayer-time source status, news/jobs source quality, data freshness |
| Customer Support Lead | Prepares user support operations | Complaint flows, support categories, escalation, response templates, SLA model |
| Product Analytics Lead | Measures product usage and weak flows | Events, funnels, engagement, decision metrics |

## Team Layer Rule

Do not add more engineering roles before using the existing ones. If the team feels incomplete, first determine which layer is missing:

1. Leadership and decision.
2. Product and business.
3. Engineering and execution.
4. Review, QA, security, privacy, legal.
5. Release, store, operations, incident response.
6. Content, official data, support, analytics.
7. AI context preservation.

New roles are allowed only if they close a real governance gap and do not duplicate an existing owner.

## Mandatory Review Matrix

| Implemented Area | Required Reviewers Before Acceptance |
|---|---|
| Mobile UI/UX | Design Systems Lead + Accessibility QA Lead + QA Lead + CTO if architecture is affected |
| Mobile functionality | QA Lead + Principal Code Reviewer |
| Backend/API | Principal Code Reviewer + Security Lead + QA Lead |
| Database/Supabase/RLS | Database/Supabase Architect + Security Lead + CTO |
| Admin/owner panel | Security Lead + QA Lead + Product Director |
| Auth/password/admin roles | Security Lead + Privacy/Compliance Lead + Legal/App Compliance Lead + CTO |
| Notifications/integrations | Integrations Lead + QA Lead + Security Lead when credentials are involved |
| Release/deployment | DevOps/Release Engineer + Launch Manager + CTO |
| App Store/Google Play release | App Store/ASO Release Lead + Legal/App Compliance Lead + Launch Manager |
| Content shown to users | Content Lead + Arabic Copy/Localization Lead + Product Director |
| Official financial/prayer/news data | Data Quality/Official Sources Lead + Content Lead + Product Director |
| Customer support/contact/complaints | Customer Support Lead + Privacy/Compliance Lead + Product Director |
| Analytics/tracking | Product Analytics Lead + Privacy/Compliance Lead + Product Director |
| Backups/recovery | Backup & Disaster Recovery Lead + DevOps/Release Engineer + CTO |
| Incident response | Incident Manager + SRE/Observability Engineer + CTO + Customer Support Lead when users are affected |
| Cost-affecting infrastructure | Cost/FinOps Lead + DevOps/Release Engineer + CTO |
| Production readiness | CTO + QA Lead + Security Lead + Privacy/Compliance Lead + Legal/App Compliance Lead + DevOps/Release Engineer + SRE/Observability Engineer + Launch Manager |

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

## Company Readiness Gates

Before any launch or production-readiness claim, the following must be reviewed:

1. Product scope is closed by Product Director.
2. Architecture is accepted by CTO.
3. Critical flows pass QA.
4. Accessibility blockers are resolved or explicitly accepted.
5. Security and privacy risks are reviewed.
6. Store/legal compliance blockers are reviewed.
7. Official data quality and source status are reviewed.
8. Build and release pipeline are verified.
9. Crash/error monitoring and incident ownership are defined.
10. Backup and recovery plan exists for durable data.
11. Support escalation path is defined.
12. Operating costs and external-service risks are understood.
13. Context/decision log is updated.

## Forbidden Completion Claims

Agents must not use any of these as final proof:

- `It should work`.
- `It likely works`.
- `No visible errors`.
- `I added onClick`.
- `Ready` without test output.
- `Production ready` without release, QA, security, legal/compliance, observability, recovery, support, and build evidence.
- `Connected` without demonstrating successful read/write or request/response.
- `Store ready` without metadata, screenshots, legal links, policy risk review, and build evidence.
- `Official data verified` without source, freshness, owner, and fallback-status evidence.

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
- Security, privacy, legal/store, and support readiness gaps.
- Official data/source quality gaps.
- Observability, backup, incident, and cost-control gaps.
- Top root-cause risks.
- First safe repair sequence.

Use `docs/PROJECT_REALITY_AUDIT.md` as the audit template.

## Final Rule

No agent is allowed to optimize for speed over correctness. The accepted output must be precise, verifiable, bounded, professionally maintainable, and operationally launch-aware.
