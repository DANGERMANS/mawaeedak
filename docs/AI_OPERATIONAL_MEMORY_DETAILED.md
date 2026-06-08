# AI Operational Memory Detailed - Mawaeedak

This is the detailed operational memory for `DANGERMANS/mawaeedak`.

Purpose: preserve exactly what happened, what was accepted, what was rejected, where the work stopped, what must not be repeated, and what the next safe step is.

Agents must read this file with `AGENTS.md` and `docs/AI_CONTEXT_MEMORY.md` before any task.

## 1. Current High-Level Status

Current verdict:

```text
READY FOR NEXT STEP - mobile shell only
```

Meaning:

- The mobile migration has started.
- A first mobile shell exists on the migration branch.
- The old environment-blocked verdict is resolved for mobile shell verification.
- The work is accepted only as limited mobile shell verification.
- The work is not accepted as completed migration, launch ready, production ready, store ready, or final merge ready.

## 2. Repository And Branch Reality

Repository:

```text
DANGERMANS/mawaeedak
```

Important branches:

- `main`
- `codex/setup-control-files`
- `codex/mobile-web-to-mobile-controlled-migration`

Branch roles:

| Branch | Current Role | Rule |
|---|---|---|
| `main` | Protected / not for uncontrolled work | Do not touch unless user explicitly commands it |
| `codex/setup-control-files` | Control and governance base | PR #31 base |
| `codex/mobile-web-to-mobile-controlled-migration` | Current mobile migration work branch | Current PR #31 head |

Current PR:

- PR number: `#31`
- State: open Draft
- Base: `codex/setup-control-files`
- Head: `codex/mobile-web-to-mobile-controlled-migration`
- PR must remain Draft until the user explicitly approves changing it.

## 3. Fixed Executive Decisions

These are fixed unless the user explicitly overrides them:

1. `mobile/` is the real mobile app target.
2. `artifacts/mawaeedak/` is the current web app and a reference only.
3. The web app must not be deleted during mobile migration.
4. The active web design is frozen.
5. Do not modify web design, web CSS, web components, web colors, web cards, web typography, or web layout during mobile migration tasks.
6. Do not use WebView.
7. Do not copy HTML/CSS/DOM/Vite-specific code into React Native.
8. Do not treat Web/PWA as the real mobile app.
9. Mobile migration must be gradual, phase-gated, and verified.
10. No phase is closed without evidence.
11. No `ready`, `done`, `production ready`, `launch ready`, or `store ready` without actual command/runtime evidence.

## 4. Verification Completed

The following verification was completed inside `mobile/`:

```text
npm run typecheck
```

Result: passed.

```text
npm run doctor
```

Result: passed, `18/18 checks passed`.

```text
npx expo start --clear
```

Result: Metro/Expo started locally. The local status endpoint returned:

```text
packager-status:running
```

## 5. Commits Already Established

Mobile verification fix:

```text
fbbea503da852fd2524363ee872c62371451c970
fix(mobile): verify Expo shell
```

Documentation status update:

```text
5ba8eaa6d6c1908b5b7a4cc9b97f8731147555b2
docs(mobile): update verification status
```

Both were pushed to:

```text
codex/mobile-web-to-mobile-controlled-migration
```

## 6. What Was Built Before This Point

### 6.1 Governance And Team System

The following were established inside the repository:

- AI team operating system.
- Complete company-style role model.
- Task template.
- Report template.
- Acceptance gates.
- Project reality audit template.
- Operational memory.

Known control files:

```text
AGENTS.md
docs/AI_CONTEXT_MEMORY.md
docs/AI_OPERATIONAL_MEMORY_DETAILED.md
docs/AI_TEAM_OPERATING_SYSTEM.md
docs/AGENT_TASK_TEMPLATE.md
docs/ACCEPTANCE_GATES.md
docs/AGENT_REPORT_TEMPLATE.md
docs/PROJECT_REALITY_AUDIT.md
```

### 6.2 Repository Reality Audit

Findings:

- The project was Web-first.
- The web app lives mainly under `artifacts/mawaeedak/`.
- The real mobile app target is `mobile/`.
- API/backend/admin/Supabase areas exist but are not the immediate mobile shell task.
- Static inspection alone is not enough for readiness claims.

### 6.3 First Mobile Migration Work

A migration branch was used:

```text
codex/mobile-web-to-mobile-controlled-migration
```

Reported mobile files added/changed include:

```text
mobile/package.json
mobile/app.json
mobile/eas.json
mobile/tsconfig.json
mobile/expo-env.d.ts
mobile/app/_layout.tsx
mobile/app/index.tsx
mobile/src/theme.ts
mobile/src/MobileApp.tsx
mobile/src/components/AppText.tsx
mobile/src/components/AppCard.tsx
mobile/src/components/AppScreen.tsx
mobile/src/components/AppButton.tsx
mobile/src/components/SectionHeader.tsx
```

Reported docs added/changed during mobile migration:

```text
docs/MOBILE_MIGRATION_PLAN.md
docs/MOBILE_MIGRATION_STATUS.md
docs/MOBILE_QA_CHECKLIST.md
docs/MOBILE_RELEASE_READINESS.md
```

Important: documentation does not equal runtime verification.

## 7. Accepted Scope

Accepted only as initial mobile shell verification:

- Mobile shell exists.
- TypeScript passes.
- Expo doctor passes.
- Metro starts locally.
- Runtime status endpoint reports running.

Not accepted as:

- Complete mobile migration.
- Launch ready.
- Production ready.
- Store ready.
- Final merge ready.

## 8. Remaining Gaps

### Mobile Runtime

- Expo Go was not tested on a physical device.
- No simulator/device QA was completed.
- Bottom navigation has not been fully device-tested.
- Pressable actions have not been fully device-tested.

### Mobile Code Quality And Dependencies

- `npm audit` still reports `14 moderate severity vulnerabilities`.
- The suggested audit force-fix would upgrade Expo to a breaking version and must not be run without explicit approval.
- Sentry dependency alignment exists, but Sentry is not practically initialized or tested.

### Product Features

- Home is not fully migrated from web.
- Salaries are not connected to real official data.
- Services are not implemented as complete flows.
- Calendar CRUD is not implemented.
- More/account/legal/support flows are not complete.
- Auth is not implemented or verified in mobile.
- Supabase is not connected or verified in mobile.
- Notifications/reminders are not implemented or verified.

### Release / Operations

- EAS Build has not been run.
- EAS Submit has not been run.
- App Store readiness is not complete.
- Google Play readiness is not complete.
- Vercel failures are outside mobile scope, but may block final merge if required by branch protection.

## 9. Fixed Product Rules

### App Identity

```text
Name: Mawaeedak / مواعيدك
```

### Time Rules

- Timezone: `Asia/Riyadh`.
- Day changes after `12:00 AM`, not `12:00 PM`.
- Internal calculations should use canonical 24-hour Riyadh time.
- User display may support 12-hour and 24-hour formats.

### Official Data Rules

- Each financial date source is the official Saudi government authority that owns that program.
- Do not show source names/URLs inside user-facing cards.
- Source explanation belongs in app/about information.
- Do not show official data as real until source approval and runtime wiring are verified.
- Use waiting/unapproved states when data is not wired.

## 10. Fixed Mobile Migration Rules

- `mobile/` is the real app.
- `artifacts/mawaeedak/` is reference only.
- Do not modify web design.
- Do not modify web CSS/components/layout/colors/cards/fonts.
- Do not use WebView.
- Do not copy HTML/CSS/DOM into React Native.
- Build with React Native primitives/components.
- Keep Arabic RTL first-class.
- Do not copy phone-frame/status-bar/notch/screenshot artifacts from visual references.
- Do not present placeholder screens as complete features.
- Placeholder statuses must be explicit and honest.

## 11. Fixed Quality Rules

A visible button/action is not considered working unless it has:

1. Real press handler.
2. Real execution behavior.
3. User-visible result.
4. Loading/success/error state when relevant.
5. Persistence when data changes.
6. Authorization boundary when protected data is involved.
7. Test evidence.

For current mobile shell placeholders:

- Alert-only actions are acceptable only as placeholder feedback.
- Alert-only actions are not complete features.
- Reports must say `placeholder / pending migration` when feature logic is not complete.

## 12. Review Verdict Rules For The Current Situation

Correct current judgment:

```text
READY FOR NEXT STEP - limited mobile shell verification only.
PR remains Draft.
Not launch ready.
Not production ready.
Not store ready.
```

Incorrect current judgment:

```text
The old environment-blocked verdict is still current for mobile shell verification.
```

## 13. Do Not Repeat These Mistakes

- Do not ask the same blocked environment to retry GitHub clone repeatedly.
- Do not accept documentation updates as proof of runtime verification.
- Do not let agents move from verification to feature development.
- Do not let agents touch web/admin/API/Supabase while the current scope is mobile shell verification.
- Do not let agents claim completion based on static code inspection.

## 14. Forbidden Actions

Do not:

- Touch `main`.
- Modify `artifacts/mawaeedak`.
- Modify web/admin/API/Supabase/RLS.
- Add features.
- Run EAS Build.
- Deploy.
- Convert PR `#31` to Ready.

## 15. Current Only Safe Next Step

Check PR `#31` mergeability and Vercel status after this conflict-resolution commit while keeping the PR Draft and without changing code outside the allowed scope.

## 16. Memory Maintenance Rule

Update this file only when a stable decision changes or when the current safe next step changes.

Do not update this file for:

- Speculation.
- Unverified claims.
- Temporary guesses.
- A failed attempt that does not change the actual next safe step.

## 17. Final Operational Rule

If an agent cannot read `docs/AI_OPERATIONAL_MEMORY_DETAILED.md`, it must not modify code.

If a future prompt conflicts with this memory, the agent must stop and ask whether the new prompt explicitly overrides this memory.
