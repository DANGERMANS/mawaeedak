# AI Context Memory - Mawaeedak

This file is the current operational memory for AI agents working on `DANGERMANS/mawaeedak`.

## Current Verified State

As of commit `fbbea503da852fd2524363ee872c62371451c970` on branch `codex/mobile-web-to-mobile-controlled-migration`, the mobile path is no longer blocked by the old environment issue.

Current mobile shell verdict:

```text
READY FOR NEXT STEP - limited to mobile shell verification only
```

This is not launch ready.
This is not production ready.
This is not store ready.

## Branches

- Base/control branch: `codex/setup-control-files`
- Mobile work branch: `codex/mobile-web-to-mobile-controlled-migration`
- PR: `#31`
- PR state: Draft
- Last known mergeability from PR creation: `mergeable=false`

Do not touch `main` unless the user explicitly asks.

## Verified Mobile Evidence

The following checks were run inside `mobile/` after the mobile fixes:

- `npm install`: passed using `npm.cmd install` on Windows.
- `npm run typecheck`: passed.
- `npm run doctor`: passed with `18/18 checks passed`.
- `npx expo start --clear`: Metro/Expo started locally.
- `http://127.0.0.1:8081/status`: returned `packager-status:running`.

## Accepted Scope

The accepted scope is limited to the mobile shell only.

The accepted changes are inside `mobile/` plus mobile-status documentation. They do not prove complete app readiness.

## Explicit Non-Readiness

Do not claim any of the following:

- Launch ready.
- Production ready.
- Store ready.
- Full app ready.
- Mobile feature-complete.

Still not done:

- Expo Go was not tested on a physical device.
- Simulator/device interaction was not fully tested.
- Sentry is not practically initialized or tested.
- Auth is not implemented or verified for mobile.
- Supabase is not connected or verified for mobile.
- Notifications are not implemented or verified for mobile.
- Calendar CRUD is not implemented or verified for mobile.
- EAS Build was not run.
- EAS Submit was not run.

## Remaining Risks

- `npm audit` still reports `14 moderate severity vulnerabilities`.
- The npm suggested fix requires `npm audit fix --force` and would upgrade to `expo@56.0.9`, a breaking change; do not run it without an explicit user decision.
- Vercel failures are outside the mobile shell scope and should not be treated as proof that mobile failed, but they may block final merge if branch protection requires them.
- PR `#31` must remain Draft until the user explicitly approves changing it.
- `mergeable=false` must be investigated before any Ready-for-review or merge decision.

## Forbidden Areas For This Mobile PR

Do not modify:

- `main`
- `artifacts/mawaeedak`
- web/admin/API/Supabase/RLS
- deployment configuration outside mobile scope

Do not:

- Add features.
- Run EAS Build.
- Deploy.
- Convert PR `#31` to Ready.

## Next Safe Step

Investigate why PR `#31` reports `mergeable=false`, without changing PR readiness and without modifying code outside the allowed scope.
