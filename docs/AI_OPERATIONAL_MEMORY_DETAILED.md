# AI Operational Memory Detailed — Mawaeedak

This is the detailed operational memory for `DANGERMANS/mawaeedak`.

Purpose: preserve exactly what happened, what was accepted, what was rejected, where the work stopped, what must not be repeated, and what the next safe step is.

Agents must read this file with `AGENTS.md` and `docs/AI_CONTEXT_MEMORY.md` before any task.

---

## 1. Current High-Level Status

Current verdict:

```text
BLOCKED BY ENVIRONMENT
```

Meaning:

- The mobile migration has started.
- A first mobile shell exists on the migration branch.
- The work is not accepted as complete.
- The blocker is not design, product, or scope.
- The blocker is that the agent environment could not access GitHub and therefore could not run verification commands.

Current required next step:

```text
Run mobile verification in a valid environment with repository access.
```

Do not start a new feature, new phase, redesign, API work, Supabase work, or admin work before this verification is done.

---

## 2. Repository and Branch Reality

Repository:

```text
DANGERMANS/mawaeedak
```

Important branches:

```text
main
codex/setup-control-files
codex/mobile-web-to-mobile-controlled-migration
```

Branch roles:

| Branch | Current Role | Rule |
|---|---|---|
| `main` | Protected / not for uncontrolled work | Do not touch unless user explicitly commands it |
| `codex/setup-control-files` | Control and governance base | Contains AGENTS/control/memory files |
| `codex/mobile-web-to-mobile-controlled-migration` | Current mobile migration work branch | Verify and fix mobile here |

Do not confuse branches. If branch is unclear, stop and report.

---

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

---

## 4. What Was Built Before This Point

### 4.1 Team and Governance System

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

Agents must read these before execution.

### 4.2 Repository Reality Audit

A static repository audit was performed.

Findings:

- The project was Web-first.
- The web app lives mainly under `artifacts/mawaeedak/`.
- The real mobile app target is `mobile/`.
- The mobile path was missing/empty/incomplete depending on branch state.
- `mobile/app/index.tsx` was originally empty or returning `null` before initial mobile migration work.
- API/backend/admin/Supabase areas exist but are not the immediate next safe task.
- The audit was static inspection only, not runtime verification.

Audit limitations:

- No successful mobile typecheck.
- No successful Expo start.
- No simulator/device verification.
- No Supabase/RLS runtime verification.
- No production readiness proof.

### 4.3 First Mobile Migration Work

A migration branch was used/created:

```text
codex/mobile-web-to-mobile-controlled-migration
```

Reported mobile files added/changed:

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

### 4.4 Mobile Shell Result

What the first migration work reportedly achieved:

- `mobile/app/index.tsx` no longer returns `null`.
- It renders `MobileApp`.
- `MobileApp` contains a first mobile shell.
- The bottom navigation exists in the approved order:
  1. `الرئيسية`
  2. `الرواتب`
  3. `الخدمات`
  4. `التقويم`
  5. `المزيد`
- Initial screens exist for:
  - Home.
  - Salaries.
  - Services.
  - Calendar.
  - More.
- Safe waiting states were used instead of fake official data:
  - `بانتظار ربط المصدر الرسمي`
  - `بانتظار ربط البيانات الرسمية`
- Visible actions were reported as `Pressable` / alert-based where complete functionality does not exist.

This is accepted only as a partial implementation start.

It is not accepted as a completed migration or verified app.

---

## 5. What Was Rejected or Not Accepted

Rejected as final closure:

- Any claim that mobile migration is complete.
- Any claim that the app works without typecheck/runtime evidence.
- Any claim that Phase 1 is closed without running verification.
- Any claim that production/store/launch readiness is achieved.

Rejected reasons:

- `npm run typecheck` was not successfully run.
- `npm run doctor` was not successfully run.
- `npx expo start --clear` was not successfully run.
- Expo runtime was not verified.
- The work was only statically inspected.
- The agent environment could not clone/fetch from GitHub.

Accepted only as status/update:

- The report that the environment is blocked.
- The documentation of the blocker.
- The statement `BLOCKED BY ENVIRONMENT`.

---

## 6. Current Environment Blocker

The exact blocker reported:

```text
fatal: unable to access 'https://github.com/DANGERMANS/mawaeedak.git/': Could not resolve host: github.com
```

Attempted command reported:

```bash
rm -rf /mnt/data/mawaeedak_mobile_verify
git clone --branch codex/mobile-web-to-mobile-controlled-migration --depth 1 https://github.com/DANGERMANS/mawaeedak.git /mnt/data/mawaeedak_mobile_verify
```

Result:

```text
Command failed with status 128.
```

Meaning:

- The environment cannot resolve `github.com`.
- The environment cannot clone the repository.
- It cannot fetch branches.
- It cannot install or run checks from the correct branch.
- It cannot prove TypeScript or Expo correctness.

Required behavior when this happens:

```text
Report BLOCKED BY ENVIRONMENT and stop.
```

Do not keep adding docs or features instead of verification.

---

## 7. The Only Safe Next Step Now

Run these in an environment that already has repo access or working GitHub connectivity:

```bash
git fetch origin
git checkout codex/mobile-web-to-mobile-controlled-migration
cd mobile
npm install
npm run typecheck
npm run doctor
npx expo start --clear
```

Allowed if errors occur:

- Fix TypeScript/Expo errors inside `mobile/` only.
- Update mobile migration status docs with exact results.

Not allowed:

- Do not touch `main`.
- Do not edit `artifacts/mawaeedak`.
- Do not edit web/admin/API/Supabase/RLS.
- Do not add features.
- Do not start Phase 2 or later.
- Do not deploy.
- Do not run EAS Build.
- Do not claim success without command output.

Required report after running:

```text
- Result of npm install.
- Result of npm run typecheck.
- Result of npm run doctor.
- Result of npx expo start --clear.
- Whether Expo opened actually.
- Files changed.
- Remaining errors.
- Next Safe Step: exactly one step.
```

---

## 8. What Is Still Not Done

Do not claim any of the following are done:

### Mobile Runtime

- Mobile runtime is not verified.
- Expo has not been proven to open.
- Simulator/device testing has not been completed.
- Bottom navigation has not been runtime tested.
- Pressable actions have not been runtime tested.

### Mobile Code Quality

- `npm run typecheck` has not passed.
- `npm run doctor` has not passed.
- TypeScript correctness is unknown.
- Expo config correctness is unknown.

### Product Features

- Home is not fully migrated from web.
- Salaries are not connected to real official data.
- Services are not implemented as complete flows.
- Calendar CRUD is not implemented.
- More/account/legal/support flows are not complete.
- Auth is not implemented or verified in mobile.
- Supabase is not connected or verified in mobile.
- Notifications/reminders are not implemented or verified.

### Release/Operations

- EAS Build has not been run.
- EAS Submit has not been run.
- App Store readiness is not complete.
- Google Play readiness is not complete.
- Crash monitoring is not initialized/verified.
- Backup/restore is not verified.
- Incident response is not operational.
- Cost monitoring is not operational.

---

## 9. Fixed Product Rules

### App Identity

```text
Name: مواعيدك
Slogan: كل موعد له وقته
```

### Bottom Navigation Order

Must be exactly:

```text
الرئيسية - الرواتب - الخدمات - التقويم - المزيد
```

### Services Order

Must be exactly:

```text
1. احسب هدفك
2. حساب التكاليف
3. ذكرني
4. السفر
5. الدراسة والإجازات
6. الوظائف والأخبار
7. بطاقة اليوم
8. صوتك مسموع
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

---

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

---

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
- Reports must say `placeholder / قيد النقل` when feature logic is not complete.

---

## 12. Review Verdict Rules For The Current Situation

If a report says verification is not run because of DNS/GitHub access:

```text
الحكم: BLOCKED
القرار: أقبله كتحديث حالة فقط، وأرفضه كإغلاق.
```

If a report says mobile is ready without typecheck/Expo:

```text
الحكم: REJECTED / NEEDS FIXES
السبب: لا يوجد دليل تشغيل.
```

If typecheck fails:

```text
الحكم: NEEDS FIXES
القرار: أصلح فقط داخل mobile/.
```

If typecheck, doctor, and Expo start pass:

```text
الحكم: READY FOR NEXT STEP
الخطوة التالية: مراجعة كود mobile shell أو بدء المرحلة التالية حسب التقرير.
```

---

## 13. Correct Prompt For The Next Agent

Use this exact short prompt for the next agent:

```text
اقرأ أولاً:
AGENTS.md
docs/AI_CONTEXT_MEMORY.md
docs/AI_OPERATIONAL_MEMORY_DETAILED.md

المهمة الوحيدة:
تحقق من فرع تحويل الجوال.

Repository:
DANGERMANS/mawaeedak

Branch:
codex/mobile-web-to-mobile-controlled-migration

نفذ:
git fetch origin
git checkout codex/mobile-web-to-mobile-controlled-migration
cd mobile
npm install
npm run typecheck
npm run doctor
npx expo start --clear

ممنوع:
- لا تلمس main.
- لا تعدل artifacts/mawaeedak.
- لا تعدل web/admin/API/Supabase/RLS.
- لا تضف ميزات.
- لا تبدأ مرحلة جديدة.
- لا تعمل deploy.
- لا تعمل EAS Build.

إذا تعذر الوصول إلى GitHub أو تشغيل الأوامر:
اكتب BLOCKED BY ENVIRONMENT وتوقف.

إذا ظهرت أخطاء:
أصلح فقط داخل mobile/ وأرسل الخطأ الكامل وما عدلته.

إذا نجحت:
أرسل النتائج الدقيقة وهل فتح Expo فعلياً، ثم Next Safe Step واحد فقط.
```

---

## 14. Do Not Repeat These Mistakes

- Do not send very long prompts from mobile chat if the UI visually cuts or scrambles the text.
- Use document/TXT files for long prompts.
- Do not ask the same blocked environment to retry GitHub clone repeatedly.
- Do not accept documentation updates as proof of runtime verification.
- Do not let agents move from verification to feature development.
- Do not let agents touch web/admin/API/Supabase while the current blocker is mobile verification.
- Do not let agents claim completion based on static code inspection.

---

## 15. Arabic Review Format Preference

When reviewing reports, respond with:

```text
الحكم:
القرار:
النواقص:
هل أقبله أو أرفضه:
الرد الجاهز:
```

When diagnosing logs/errors/screenshots, respond with:

```text
السبب:
مكان الخلل:
الحل:
الأمر الصحيح:
النتيجة المتوقعة:
```

---

## 16. Memory Maintenance Rule

Update this file only when a stable decision changes or when the current safe next step changes.

Do not update this file for:

- Speculation.
- Unverified claims.
- Temporary guesses.
- A failed attempt that does not change the actual next safe step.

Every update must preserve:

- Branch reality.
- What was done.
- What was not done.
- Current blocker.
- Current next safe step.
- Standing prohibitions.

---

## 17. Final Operational Rule

If an agent cannot read `docs/AI_OPERATIONAL_MEMORY_DETAILED.md`, it must not modify code.

If a future prompt conflicts with this memory, the agent must stop and ask whether the new prompt explicitly overrides this memory.
