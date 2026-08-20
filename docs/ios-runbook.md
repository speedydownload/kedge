# iOS Build Runbook (run on the Mac)

The repo is developed on Windows; everything iOS-specific is authored here
but compiled and verified on a Mac. Follow this top to bottom the first
time; later builds only need steps 5–7.

## 1. Prerequisites

- Xcode 16+ with an Apple Developer account signed in.
- Flutter (same major as `pubspec.lock`; `flutter --version` here is 3.44.x).
- `gem install xcodeproj` (for the target setup script).
- The four Family Controls **distribution** entitlement requests filed
  (see `docs/entitlement-request.md`). Development builds work while they
  are pending — distribution/TestFlight does not.

## 2. One-time Apple portal setup

1. Register bundle IDs: `app.ballast.ios`,
   `app.ballast.ios.DeviceActivityMonitor`,
   `app.ballast.ios.ShieldConfiguration`, `app.ballast.ios.ShieldAction`.
2. Create App Group `group.app.ballast` and attach it to all four IDs.
3. Enable the Family Controls (development) capability on all four IDs.

## 3. Generate the workspace and add the extension targets

```sh
flutter pub get
flutter build ios --config-only     # writes Generated.xcconfig, Podfile
ruby tool/setup_ios_targets.rb      # adds the 3 extension targets (idempotent)
```

Then in `ios/Podfile` set the platform line to:

```ruby
platform :ios, '16.0'
```

and run `pod install --project-directory=ios` (or just build; Flutter runs it).

## 4. Xcode signing

Open `ios/Runner.xcworkspace`. For **each of the four targets** under
Signing & Capabilities: select your Team, confirm the App Group
`group.app.ballast` and Family Controls capabilities are present (they come
from the committed `.entitlements` files).

## 5. Build to a physical device

```sh
flutter run --release   # or debug; pick your device
```

FamilyControls authorization prompts do not work on the simulator —
**use a real device** for anything involving blocking.

## 6. Phase 2 verification — the hardcoded 2-minute block

1. Launch the app, trigger `requestAuthorization` (Phase 4 UI, or the dev
   button on the home screen if present) and approve Screen Time access.
2. Pick 1–2 apps via the native picker.
3. Start a 2-minute on-demand block.
4. Expected: selected apps show the Ballast shield ("Blocked."), "Not now"
   closes the shielded app. After the Flutter side calls stopBlock at the
   2-minute mark, apps open normally.
5. Note: DeviceActivity end-callbacks require intervals ≥ 15 minutes, so
   the 2-minute proof relies on the app itself calling stopBlock. Test a
   ≥ 15-minute session with the app force-quit to verify the monitor
   extension lifts the shield on its own.

## 7. Reporting results back

Paste build errors (full `flutter run` / Xcode output) and any behavioural
notes into the Windows-side session so the Swift can be fixed there. Do not
hand-edit the generated pbxproj sections; prefer fixes in
`tool/setup_ios_targets.rb` so the setup stays reproducible.

## Known sharp edges

- `ShieldConfigurationExtension` references a `ShieldMark` image: add
  `assets/brand/logo_mono_512.png` to the extension target's asset catalog
  as `ShieldMark` (or it silently shows no icon — acceptable for Phase 2).
- If the picker sheet appears but selections don't persist, the App Group
  is misconfigured — `SharedStore` fatals with a clear message in debug.
- Strict-mode `denyAppRemoval` prevents app deletion only while a strict
  session store is active; it must always lapse when the session ends.
