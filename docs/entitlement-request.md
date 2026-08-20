# Family Controls Distribution Entitlement — Filing Guide

Ballast cannot ship to TestFlight or the App Store until Apple approves the
`com.apple.developer.family-controls` **distribution** entitlement for the
main app **and each extension separately**. Approval does not cascade from
the main app. Review is manual and has taken anywhere from a few business
days to several weeks — file all four requests **now**, before any code
ships.

The *development* entitlement needs no approval, so local builds and testing
continue in parallel while these are pending.

## Where to file

1. Sign in at <https://developer.apple.com/account> with the team account
   that owns the Ballast bundle IDs.
2. Go to the request form:
   <https://developer.apple.com/contact/request/family-controls-distribution>
3. Submit the form **four times**, once per bundle ID below. Register each
   bundle ID under Certificates, Identifiers & Profiles first, and create
   the App Store Connect record for the main app before filing.

## The four requests

| # | Bundle ID | Role |
|---|-----------|------|
| 1 | `app.ballast.ios` | Main app |
| 2 | `app.ballast.ios.DeviceActivityMonitor` | Schedule start/end monitor extension |
| 3 | `app.ballast.ios.ShieldConfiguration` | Custom blocked-screen UI extension |
| 4 | `app.ballast.ios.ShieldAction` | Shield button handler extension |

## Justification text — paste into each request

Adjust the first sentence per bundle ID as noted below.

> Ballast is a personal digital-wellbeing app that lets adults block
> distracting apps on their own device, on their own schedule. This request
> is for **[see per-target sentence below]**.
>
> How the entitlement is used: the user selects the apps they want to limit
> via FamilyActivityPicker. Ballast applies ManagedSettings shields to those
> selections on demand, on a user-defined schedule, or after a user-defined
> daily usage threshold, using DeviceActivity schedules and events. All
> selections and settings are configured by the device owner for themselves.
>
> Privacy: all user data stays on-device. Ballast has no server and no
> accounts. Opaque app selection tokens never leave the device. No usage
> data is collected for advertising, profiling, or resale. The only network
> traffic is subscription processing (RevenueCat) and anonymous product
> analytics that never include app tokens or usage content.
>
> Ballast is not a parental-control product; it manages only the device it
> is installed on, for the person who installed it.

Per-target first-sentence insert:

1. **Main app** — "the main Ballast app (`app.ballast.ios`), which requests
   FamilyControls authorization, presents FamilyActivityPicker, and applies
   and removes ManagedSettingsStore shields."
2. **DeviceActivityMonitor** — "Ballast's DeviceActivityMonitor extension
   (`app.ballast.ios.DeviceActivityMonitor`), which applies and lifts
   shields at the start and end of user-defined schedule intervals so
   blocking works while the app is closed."
3. **ShieldConfiguration** — "Ballast's ShieldConfiguration extension
   (`app.ballast.ios.ShieldConfiguration`), which renders the custom
   blocked-screen UI shown over a shielded app."
4. **ShieldAction** — "Ballast's ShieldAction extension
   (`app.ballast.ios.ShieldAction`), which handles taps on the blocked
   screen's buttons (dismiss, or route into the app's early-unlock flow)."

## Checklist

- [ ] All four bundle IDs registered under the team
- [ ] App Store Connect record created for `app.ballast.ios`
- [ ] Request filed: main app
- [ ] Request filed: DeviceActivityMonitor
- [ ] Request filed: ShieldConfiguration
- [ ] Request filed: ShieldAction
- [ ] Approval emails received (record dates in PROGRESS.md)
