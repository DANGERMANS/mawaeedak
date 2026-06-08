# MOBILE_QA_CHECKLIST

## Current QA Verdict

```text
PARTIAL PASS - mobile shell verification only
```

This checklist reflects the verification completed after commit `fbbea503da852fd2524363ee872c62371451c970`.

It does not claim launch ready or production ready.

## Automated / Local Checks

| Check | Status | Evidence |
|---|---|---|
| `npm run typecheck` | PASS | TypeScript completed with no errors |
| `npm run doctor` | PASS | Expo doctor reported `18/18 checks passed` |
| `npx expo start --clear` | PASS LOCAL | Metro started locally |
| Metro `/status` | PASS | Returned `packager-status:running` |
| `npm audit` | NEEDS DECISION | Still reports `14 moderate severity vulnerabilities` |

## Device QA

| Check | Status | Note |
|---|---|---|
| Expo Go on physical device | NOT RUN | Required before broader mobile acceptance |
| iOS simulator | NOT RUN | Not verified |
| Android emulator | NOT RUN | Not verified |
| Real navigation interaction | NOT RUN | Needs device/simulator QA |
| Accessibility on device | NOT RUN | Needs device/simulator QA |

## Scope Confirmation

The completed QA only proves:

- The mobile shell compiles.
- Expo doctor accepts the project setup.
- Metro can start locally.

The completed QA does not prove:

- Production readiness.
- Store readiness.
- Full app feature readiness.
- Real device behavior.
- Sentry runtime reporting.
- Auth/Supabase/notifications/calendar functionality.

## PR State

- PR: `#31`
- State: Draft
- Last known mergeable value: `false`

The PR must remain Draft until the user explicitly approves changing it.

## External Checks

Vercel failures are outside the mobile shell scope and should not be used as proof that mobile failed. If branch protection requires Vercel success, those failures still need a separate decision before final merge.

## Next Safe Step

Investigate why PR `#31` is `mergeable=false` without converting it to Ready.
