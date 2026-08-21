# Kedge — Progress

## Phase 0 — Setup ✅ (2026-08-20)

**Done**
- Flutter project created; bundle IDs set to `app.kedge.ios` (all six
  pbxproj build configs) and `app.kedge.android` (namespace,
  applicationId, MainActivity package). Display name "Kedge" on both.
- Theme tokens (`lib/theme/`): full colour palette dark+light, type scale
  (Fraunces/Inter — families referenced, font files land in Phase 1),
  spacing/radius/motion tokens, ThemeData built entirely from tokens.
- Drift schema v1: `block_profiles`, `sessions`, `daily_stats`, `streaks`
  (singleton row seeded in onCreate). Enum columns persist by index —
  append-only rule documented in `lib/domain/enums.dart`.
- Riverpod (codegen) scaffolding: keep-alive providers for database,
  analytics, purchases, blocking engine.
- `BlockingEngine` interface + `MethodChannel('app.kedge/blocking')` /
  `EventChannel('app.kedge/blocking_events')` implementations
  (`IosBlockingEngine`, `AndroidBlockingEngine`). UI talks only to the
  interface.
- RevenueCat wrapper (`pro` entitlement) and PostHog behind
  `AnalyticsService`; both inert without keys (--dart-define, see README).
- go_router with placeholder home screen.
- `docs/entitlement-request.md` — exact text + checklist for the four
  Family Controls distribution requests.
- Tests: DB schema/enum round-trip + app boot smoke test. `flutter analyze`
  clean, all tests pass.

**Stubbed**
- Home screen is a Phase 0 placeholder (real home in Phase 4).
- Native sides of the platform channel don't exist yet (iOS Phase 2,
  Android Phase 7) — engine calls would throw MissingPluginException if
  invoked; nothing invokes them yet.
- Fraunces/Inter font files not yet bundled (Phase 1).

**Blocked / waiting on product owner**
- App Store Connect record + the four entitlement requests must be filed by
  the owner (needs the Apple account). Text ready in
  `docs/entitlement-request.md`. **File these now — review can take weeks.**
- Awaiting: Apple Team ID, RevenueCat public keys, PostHog key. (Support
  email support@kedgefocus.com and privacy domain kedgefocus.com set with
  the 2026-08-21 rename.)

**Deviations / notes**
- `riverpod_lint`/`custom_lint` omitted: current `custom_lint` caps at
  analyzer 8 while `drift_dev`+`riverpod_generator` need analyzer 12 —
  incompatible today. Revisit when custom_lint catches up.
- Pinned: flutter_riverpod 3.3.2 / riverpod_annotation 4.0.3 /
  riverpod_generator 4.0.4 / drift_dev 2.34.0 (newest set that co-resolves
  under Flutter 3.44.6's analyzer pins).
- Dev machine is Windows; iOS builds/validation happen on the owner's Mac.

## Phase 1 — Brand assets ✅ (2026-08-20)

**Done**
- `assets/brand/logo.svg` (plumb bob, squircle ink bg, brass mark, brassDim
  left facet via clip), `logo-mono.svg`, `wordmark.svg` — all geometric, no
  image services.
- `tool/generate_icons.py` (cairosvg + Pillow): writes all seven PNGs per
  spec, prints each with dimensions, fails loudly on missing sources,
  idempotent. Wordmark text drawn with the real Fraunces variable TTF at
  wght 600 (Pillow), so no font-fallback risk.
- Fraunces + Inter variable TTFs bundled (`assets/fonts/`), declared in
  pubspec; typography pins the `wght` axis via FontVariation on every style.
- `flutter_launcher_icons` (iOS 1024 no-alpha; Android adaptive fg/bg +
  legacy) and `flutter_native_splash` (ink bg, mark image, dark variant,
  Android 12) both configured and run. Icons visually verified from the
  generated mipmap and iOS 1024 asset.

**Notes**
- Windows quirk: cairosvg needs the GTK3 runtime
  (`winget install --id tschoonj.GTKForWindows`); the script prepends its
  bin dir to PATH automatically. Documented in the script docstring.
- Icon render on a real iOS simulator home screen still pending — needs the
  owner's Mac (Windows dev box). Android icon verified from generated
  assets; APK builds.
## Phase 2 — iOS blocking core 🔶 authored, awaiting Mac build (2026-08-20)

**Done (authored on Windows, not yet compiled)**
- `ios/Shared/SharedBlocking.swift`: App Group store (selections as
  serialized FamilyActivitySelection, active session, schedules), Darwin
  notification bridge, per-concern ManagedSettingsStore naming, shield
  apply/lift incl. strict-mode denyAppRemoval.
- `ios/Runner/Blocking/`: full platform-channel handler (authorization,
  native FamilyActivityPicker presentation returning opaque id + counts,
  startBlock/stopBlock, syncSchedules with per-weekday repeating
  DeviceActivity schedules incl. overnight windows) and EventChannel fed by
  Darwin notifications from the extensions.
- Three extension targets' sources + Info.plists + entitlements:
  DeviceActivityMonitor (applies/lifts shields while app is dead),
  ShieldConfiguration (branded static shield), ShieldAction ("Not now"
  closes; early-unlock signal stubbed for Phase 5).
- `tool/setup_ios_targets.rb` (xcodeproj gem, idempotent) creates the three
  targets, wires shared sources, entitlements, embed phase, iOS 16 floor.
- `docs/ios-runbook.md`: exact Mac procedure incl. the 2-minute block proof.

**Blocked**
- Compile + on-device verification needs the owner's Mac (see runbook §6–7).
- Known constraint: DeviceActivity intervals must be ≥ 15 min; short
  sessions end via the app itself. Documented in code + runbook.
## Phase 3 — Data + domain ✅ (2026-08-21)

**Done** (41 tests green, analyze clean)
- `SessionMachine`: pure transition rules (scheduled→active→completed /
  endedEarly / cancelled) with guards; completion timestamps use the
  *scheduled* end so late expiry checks (force-quit, reboot) stay honest;
  `held` = ran out with zero early unlocks.
- `FrictionPolicy`: gentle (5-min pause, unlimited), firm (60 s forced
  wait, 3/day), strict (40-char unambiguous passphrase, exact-match verify,
  uninstall protection, cannot disable mid-session). All rules live here —
  widgets only render rulings.
- `StreakLogic`: pure day-key arithmetic; broken day zeroes current but
  preserves longest; same-day holds count once.
- Repositories: profiles (archive-not-delete, free-tier count helper),
  sessions (transition persistence via SessionMachine), daily stats
  (transactional upserts), streaks (single row through StreakLogic).
- `SessionService`: orchestrates start / expire-sweep / two-step early
  unlock (request ruling → execute effect) across DB + BlockingEngine with
  an injected clock; covered end-to-end by tests with a fake engine
  (in-memory Drift), including the 3-per-day firm limit and honest
  held-seconds on early ends.
- Riverpod providers for all repositories + service.

**Stubbed**
- Gentle-pause re-shield timer is native work (Phase 5); the service
  records the pause and lifts the shield.
- App-limit trigger accounting arrives with DeviceActivityEvent wiring.
## Phase 4 — UI
## Phase 5 — Shield + friction
## Phase 6 — Monetization + analytics
## Phase 7 — Android
## Phase 8 — Ship
