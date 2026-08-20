import ManagedSettings

/// Handles taps on the shield's buttons. Phase 2: primary ("Not now")
/// closes the shielded app. The friction flows (5-minute unlock, forced
/// wait, strict passphrase) route through the main app in Phase 5.
@available(iOS 16.0, *)
final class ShieldActionExtension: ShieldActionDelegate {
    override func handle(
        action: ShieldAction,
        for application: ApplicationToken,
        completionHandler: @escaping (ShieldActionResponse) -> Void
    ) {
        respond(to: action, completionHandler: completionHandler)
    }

    override func handle(
        action: ShieldAction,
        for webDomain: WebDomainToken,
        completionHandler: @escaping (ShieldActionResponse) -> Void
    ) {
        respond(to: action, completionHandler: completionHandler)
    }

    override func handle(
        action: ShieldAction,
        for category: ActivityCategoryToken,
        completionHandler: @escaping (ShieldActionResponse) -> Void
    ) {
        respond(to: action, completionHandler: completionHandler)
    }

    private func respond(
        to action: ShieldAction,
        completionHandler: @escaping (ShieldActionResponse) -> Void
    ) {
        switch action {
        case .primaryButtonPressed:
            completionHandler(.close)
        case .secondaryButtonPressed:
            // "Unlock early" (Phase 5): signal the app, keep the shield up.
            DarwinNames.post(DarwinNames.earlyUnlockRequested)
            completionHandler(.defer)
        @unknown default:
            completionHandler(.close)
        }
    }
}
