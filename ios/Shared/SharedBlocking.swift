// Shared between the Runner app and all three extensions via the App Group.
// This file is a member of ALL FOUR targets (see tool/setup_ios_targets.rb).

import Foundation
import FamilyControls
import ManagedSettings

enum AppGroup {
    static let id = "group.app.ballast"

    static var defaults: UserDefaults {
        guard let d = UserDefaults(suiteName: id) else {
            fatalError("App Group \(id) is not configured for this target")
        }
        return d
    }
}

/// Darwin notification names used by extensions to poke the main app.
/// Darwin notifications carry no payload — details go through the App Group.
enum DarwinNames {
    static let shieldShown = "app.ballast.shieldShown"
    static let intervalStarted = "app.ballast.intervalStarted"
    static let intervalEnded = "app.ballast.intervalEnded"
    static let earlyUnlockRequested = "app.ballast.earlyUnlockRequested"

    static func post(_ name: String) {
        CFNotificationCenterPostNotification(
            CFNotificationCenterGetDarwinNotifyCenter(),
            CFNotificationName(name as CFString),
            nil, nil, true
        )
    }
}

/// The active on-demand session, mirrored into the App Group so extensions
/// can see it while the Flutter app is dead.
struct SessionInfo: Codable {
    let sessionId: String
    let selectionId: String
    let endsAtEpochMs: Int64
    let frictionLevel: String // gentle | firm | strict
    let strictUninstallProtection: Bool
}

/// A recurring schedule registered with DeviceActivity.
struct ScheduleInfo: Codable {
    let profileId: String
    let selectionId: String
    let daysMask: Int // bit 0 = Monday … bit 6 = Sunday
    let startMinutes: Int
    let endMinutes: Int
    let frictionLevel: String
}

@available(iOS 16.0, *)
enum SharedStore {
    private static let sessionKey = "activeSession"
    private static let schedulesKey = "schedules"
    private static let lastEventKey = "lastShieldEvent"

    private static func selectionKey(_ id: String) -> String { "selection.\(id)" }

    // MARK: selections (opaque FamilyActivitySelection blobs)

    static func saveSelection(_ selection: FamilyActivitySelection, id: String) throws {
        AppGroup.defaults.set(try JSONEncoder().encode(selection), forKey: selectionKey(id))
    }

    static func loadSelection(id: String) -> FamilyActivitySelection? {
        guard let data = AppGroup.defaults.data(forKey: selectionKey(id)) else { return nil }
        return try? JSONDecoder().decode(FamilyActivitySelection.self, from: data)
    }

    // MARK: active session

    static func saveSession(_ session: SessionInfo?) {
        if let session, let data = try? JSONEncoder().encode(session) {
            AppGroup.defaults.set(data, forKey: sessionKey)
        } else {
            AppGroup.defaults.removeObject(forKey: sessionKey)
        }
    }

    static func loadSession() -> SessionInfo? {
        guard let data = AppGroup.defaults.data(forKey: sessionKey) else { return nil }
        return try? JSONDecoder().decode(SessionInfo.self, from: data)
    }

    // MARK: schedules

    static func saveSchedules(_ schedules: [ScheduleInfo]) {
        if let data = try? JSONEncoder().encode(schedules) {
            AppGroup.defaults.set(data, forKey: schedulesKey)
        }
    }

    static func loadSchedules() -> [ScheduleInfo] {
        guard let data = AppGroup.defaults.data(forKey: schedulesKey) else { return [] }
        return (try? JSONDecoder().decode([ScheduleInfo].self, from: data)) ?? []
    }

    static func schedule(profileId: String) -> ScheduleInfo? {
        loadSchedules().first { $0.profileId == profileId }
    }
}

/// One ManagedSettingsStore per concern so lifting one block never disturbs
/// another (three overlapping profiles is a v1 soak requirement).
@available(iOS 16.0, *)
enum StoreNames {
    static func session(_ sessionId: String) -> ManagedSettingsStore.Name {
        .init("session_\(sessionId)")
    }
    static func schedule(_ profileId: String) -> ManagedSettingsStore.Name {
        .init("schedule_\(profileId)")
    }
}

@available(iOS 16.0, *)
enum ShieldApplier {
    /// Applies shields for `selection` in the store named `name`.
    static func apply(
        _ selection: FamilyActivitySelection,
        storeNamed name: ManagedSettingsStore.Name,
        denyAppRemoval: Bool = false
    ) {
        let store = ManagedSettingsStore(named: name)
        store.shield.applications =
            selection.applicationTokens.isEmpty ? nil : selection.applicationTokens
        store.shield.applicationCategories =
            selection.categoryTokens.isEmpty ? nil : .specific(selection.categoryTokens)
        store.shield.webDomains =
            selection.webDomainTokens.isEmpty ? nil : selection.webDomainTokens
        // Uninstall protection: Strict Mode only, always lapses with the session.
        store.application.denyAppRemoval = denyAppRemoval ? true : nil
    }

    static func lift(storeNamed name: ManagedSettingsStore.Name) {
        ManagedSettingsStore(named: name).clearAllSettings()
    }
}
