# CLAUDE.md — Ballast

Read this first; it assumes zero context. Longer-form status lives in
`PROGRESS.md` (per-phase, kept current), and the original full product spec
is the "Master Build Prompt" the product owner holds — ask them for it if
you need feature details not covered here or in code comments.

## What this is

**Ballast** is an offline-first Flutter app (iOS primary, Android second)
that blocks distracting apps on demand, on a schedule, or after a daily
usage limit, and makes early unlocking deliberately annoying via three
friction tiers (Gentle / Firm / Strict). No accounts, no backend; the only
network calls are RevenueCat (subscriptions, entitlement id `pro`) and
PostHog analytics. Brand voice: calm, dry, no exclamation marks, no emoji,
no dark patterns. Dark theme is primary; the mark is a brass plumb bob.

Bundle IDs: `app.ballast.ios` (+ `.DeviceActivityMonitor`,
`.ShieldConfiguration`, `.ShieldAction` extensions) and
`app.ballast.android`. App Group: `group.app.ballast`.

## Toolchain & pinned versions

- Flutter 3.44.6 stable / Dart 3.12 (see `pubspec.lock` for exact set).
- **Do not blindly upgrade these** — they are the newest set that
  co-resolves under Flutter 3.44.6's analyzer pins:
  `flutter_riverpod 3.3.2` + `riverpod_annotation 4.0.3` +
  `riverpod_generator >=4.0.4 <4.0.6` + `drift_dev ^2.34.0`.
- `riverpod_lint`/`custom_lint` are deliberately absent (custom_lint capped
  at analyzer 8; the toolchain needs 12). Revisit occasionally.
- Android `compileSdk = 37` is hardcoded in `android/app/build.gradle.kts`
  (flutter_secure_storage requires it).
- iOS deployment target is 16.0 (FamilyControls async authorization).

## Everyday commands

```sh
flutter pub get
dart run build_runner build        # Riverpod + Drift codegen (*.g.dart committed)
flutter analyze                    # must stay at zero issues
flutter test                       # 41 tests as of Phase 3 — keep green
flutter run                        # runs fine with no keys (services no-op)
```

Secrets are `--dart-define` only (see README table): `REVENUECAT_IOS_API_KEY`,
`REVENUECAT_ANDROID_API_KEY`, `POSTHOG_API_KEY`, `POSTHOG_HOST`. Empty key
⇒ that service initialises inert. Never commit keys.

Brand asset regeneration (only when the SVGs change):

```sh
pip install cairosvg pillow        # macOS: brew install cairo first
python tool/generate_icons.py      # writes 7 PNGs into assets/brand/
dart run flutter_launcher_icons
dart run flutter_native_splash:create
```

iOS project setup and device verification: follow **`docs/ios-runbook.md`**
top to bottom (portal setup, `ruby tool/setup_ios_targets.rb` to create the
three extension targets, Podfile platform 16.0, signing, and the 2-minute
block proof on a physical device — FamilyControls does not work on the
simulator).

## Repo map

```
lib/theme/        tokens.dart is the single source of visual truth —
                  widgets NEVER hardcode colours/sizes/durations
lib/domain/       enums.dart (persisted by index — APPEND ONLY, never
                  reorder), session_machine.dart (pure lifecycle rules),
                  friction_policy.dart (ALL friction rules; widgets only
                  render its rulings), streak_logic.dart, session_service.dart
lib/core/blocking/   BlockingEngine interface; UI talks ONLY to this, never
                     to MethodChannel directly. Channel names/payloads must
                     stay in lock-step with ios/Runner/Blocking/*.swift
lib/core/analytics/  AnalyticsService + event-name constants (never inline
                     event strings; never log blocked-app names/usage)
lib/core/purchases/  RevenueCat wrapper, entitlement `pro`
lib/data/db/         Drift schema v1 + database.dart
lib/data/repositories/  repos + riverpod providers
lib/features/     one folder per screen area (home is a placeholder)
ios/Shared/       SharedBlocking.swift — member of ALL FOUR iOS targets
ios/Runner/Blocking/  platform-channel handler + native picker presenter
ios/<Extension>/  three Screen Time extensions (sources/plists/entitlements)
tool/             generate_icons.py, setup_ios_targets.rb
docs/             entitlement-request.md (Apple filing text), ios-runbook.md
```

## Status (details in PROGRESS.md)

- **Phase 0 Setup** ✅  **Phase 1 Brand assets** ✅  **Phase 3 Data+domain** ✅
  (all verified: analyze clean, tests green, debug APK builds)
- **Phase 2 iOS blocking core** 🔶 fully authored but **never compiled** —
  written on Windows. First job on the Mac: run the runbook, fix whatever
  Swift/build issues surface, prove the 2-minute block on a device.
- **Phase 4 UI** not started (was intentionally held until Phase 2 verifies,
  since screens wire onto the channel contract).
- Then: 5 shield+friction, 6 monetization+analytics, 7 Android, 8 ship.

## Outstanding / owner-side

- The four `com.apple.developer.family-controls` **distribution**
  entitlement requests (main app + each extension separately — approval
  does not cascade) must be filed by the owner; exact text in
  `docs/entitlement-request.md`. Gates TestFlight; review can take weeks.
- Awaited from owner: Apple Team ID, RevenueCat public keys, PostHog key,
  support email, privacy-policy domain.

## Ground rules from the product owner

1. Work phase by phase; confirm each phase builds and runs before the next.
2. Commit per phase; update `PROGRESS.md` (done / stubbed / blocked) after each.
3. Ask before assuming on ambiguous spec details.
4. No dark patterns anywhere; paywall shows price/period/trial plainly.
5. Real tests for blocking logic and the session state machine are mandatory.
6. Free tier must always keep one working Gentle profile — never brick the app.
7. Never show a stat you can't compute honestly; "held" = session ran out
   with zero early unlocks (even a Gentle pause breaks the day).

## Known sharp edges

- DeviceActivity rejects intervals < 15 minutes: short on-demand sessions
  end via the app (`SessionService.completeExpired` on resume/tick); the
  monitor extension is the safety net for longer ones.
- iOS never exposes selected app names — only opaque tokens. UI must say
  "12 apps blocked", never list names (Android may list names).
- Strict-mode `denyAppRemoval` must always lapse when the session ends.
- One `ManagedSettingsStore` per session/schedule (see `StoreNames`) so
  overlapping profiles never clobber each other's shields.
- `SessionMachine.expire` stamps `endedAt` with the *scheduled* end, not
  the check time — keeps "minutes saved" honest after force-quit/reboot.
