import DeviceActivity
import ManagedSettings
import FamilyControls

/// Runs even while the main app is dead. Activity names:
///   schedule_<profileId>_<weekday>  — recurring schedule windows
///   session_<sessionId>             — end-of-session safety net
@available(iOS 16.0, *)
final class DeviceActivityMonitorExtension: DeviceActivityMonitor {
    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)
        guard let profileId = Self.scheduleProfileId(from: activity),
              let info = SharedStore.schedule(profileId: profileId),
              let selection = SharedStore.loadSelection(id: info.selectionId)
        else { return }
        ShieldApplier.apply(
            selection,
            storeNamed: StoreNames.schedule(profileId),
            denyAppRemoval: info.frictionLevel == "strict"
        )
        DarwinNames.post(DarwinNames.intervalStarted)
    }

    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
        let name = activity.rawValue
        if let profileId = Self.scheduleProfileId(from: activity) {
            ShieldApplier.lift(storeNamed: StoreNames.schedule(profileId))
        } else if name.hasPrefix("session_") {
            let sessionId = String(name.dropFirst("session_".count))
            ShieldApplier.lift(storeNamed: StoreNames.session(sessionId))
            SharedStore.saveSession(nil)
        }
        DarwinNames.post(DarwinNames.intervalEnded)
    }

    override func eventDidReachThreshold(
        _ event: DeviceActivityEvent.Name, activity: DeviceActivityName
    ) {
        super.eventDidReachThreshold(event, activity: activity)
        // App-limit triggers land here in Phase 3+ (DeviceActivityEvent
        // usage thresholds); shield for the rest of the day.
    }

    /// "schedule_<profileId>_<weekday>" → profileId (ids never contain '_';
    /// they are decimal database row ids).
    private static func scheduleProfileId(from activity: DeviceActivityName) -> String? {
        let parts = activity.rawValue.split(separator: "_")
        guard parts.count == 3, parts[0] == "schedule" else { return nil }
        return String(parts[1])
    }
}
