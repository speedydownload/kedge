# Ballast

Ballast makes your phone boring for a while. That's the whole trick.

An offline-first Flutter app (iOS primary, Android second) that blocks
selected apps on a schedule or on demand, and makes it deliberately annoying
to unblock early. No accounts, no server — all user data lives on-device.
The only network calls are RevenueCat (purchases) and PostHog (analytics).

## Repo layout

```
lib/
  theme/        design tokens, typography, ThemeData — never hardcode colours in widgets
  domain/       shared enums and (later) the session state machine
  core/
    config/     build-time env (--dart-define)
    analytics/  AnalyticsService interface + PostHog impl + event names
    purchases/  RevenueCat wrapper (entitlement id: pro)
    blocking/   BlockingEngine interface + platform-channel implementations
    routing/    go_router
  data/db/      Drift schema: block_profiles, sessions, daily_stats, streaks
  features/     one folder per screen area
docs/           entitlement-request.md and other ship docs
tool/           asset generation scripts (Phase 1)
```

## Development

```sh
flutter pub get
dart run build_runner build          # Drift + Riverpod codegen
flutter analyze
flutter test
flutter run                          # runs with placeholder (inert) keys
```

Dev machine note: this repo is developed on Windows; **iOS builds run on a
Mac**. The Swift code and Xcode configuration are authored here and
compiled/tested on the Mac.

## Configuration (secrets via --dart-define)

No secrets are committed. Services with empty keys initialise as no-ops, so
the app always runs.

| Define | Purpose |
|---|---|
| `REVENUECAT_IOS_API_KEY` | RevenueCat public SDK key (Apple) |
| `REVENUECAT_ANDROID_API_KEY` | RevenueCat public SDK key (Google) |
| `POSTHOG_API_KEY` | PostHog project API key |
| `POSTHOG_HOST` | Optional; defaults to `https://us.i.posthog.com` |

```sh
flutter run \
  --dart-define=REVENUECAT_IOS_API_KEY=appl_xxx \
  --dart-define=POSTHOG_API_KEY=phc_xxx
```

### RevenueCat setup (from scratch)

1. Create a RevenueCat project with an iOS app (`app.ballast.ios`) and an
   Android app (`app.ballast.android`).
2. Products: `ballast_monthly` ($6.99/mo), `ballast_annual` ($34.99/yr,
   3-day trial), `ballast_lifetime` ($79.99, win-back only).
3. Entitlement `pro` attached to all three products.
4. Use Offerings for paywall configuration; the paywall widget (Phase 6)
   reads offering metadata so copy/pricing changes need no app release.

## Icons & splash

Rebuilt from SVG sources (Phase 1):

```sh
python tool/generate_icons.py
dart run flutter_launcher_icons
dart run flutter_native_splash:create
```

## Metrics

North star: **7-day retained subscribers per $100 ad spend.**
Secondary: install → trial start rate; trial → paid rate.

## Status

See `PROGRESS.md` for per-phase status and `docs/entitlement-request.md`
for the Apple Family Controls filing that gates any TestFlight build.
