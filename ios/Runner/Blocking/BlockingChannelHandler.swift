import Flutter
import Foundation
import FamilyControls
import ManagedSettings
import DeviceActivity
import SwiftUI

/// Dart side: MethodChannel('app.kedge/blocking') and
/// EventChannel('app.kedge/blocking_events'). Method names and payload
/// keys must stay in lock-step with lib/core/blocking/.
@available(iOS 16.0, *)
public final class BlockingChannelHandler: NSObject, FlutterPlugin, FlutterStreamHandler {
    private var eventSink: FlutterEventSink?

    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = BlockingChannelHandler()
        let methods = FlutterMethodChannel(
            name: "app.kedge/blocking", binaryMessenger: registrar.messenger()
        )
        registrar.addMethodCallDelegate(instance, channel: methods)
        FlutterEventChannel(
            name: "app.kedge/blocking_events", binaryMessenger: registrar.messenger()
        ).setStreamHandler(instance)
        instance.observeDarwinNotifications()
    }

    // MARK: - Method channel

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "authorizationStatus":
            result(Self.statusString(AuthorizationCenter.shared.authorizationStatus))

        case "requestAuthorization":
            Task { @MainActor in
                do {
                    try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
                } catch {
                    // Denial surfaces via authorizationStatus below.
                }
                result(Self.statusString(AuthorizationCenter.shared.authorizationStatus))
            }

        case "pickApps":
            let args = call.arguments as? [String: Any]
            let existingId = args?["existingSelectionId"] as? String
            ActivityPickerPresenter.present(existingSelectionId: existingId) { outcome in
                switch outcome {
                case .cancelled:
                    result(nil)
                case .picked(let selectionId, let selection):
                    result([
                        "selectionId": selectionId,
                        "appCount": selection.applicationTokens.count,
                        "categoryCount": selection.categoryTokens.count,
                    ])
                case .failed(let message):
                    result(FlutterError(code: "picker_failed", message: message, details: nil))
                }
            }

        case "startBlock":
            guard
                let args = call.arguments as? [String: Any],
                let sessionId = args["sessionId"] as? String,
                let selectionId = args["selectionId"] as? String,
                let endsAtEpochMs = args["endsAtEpochMs"] as? Int64
                    ?? (args["endsAtEpochMs"] as? Int).map(Int64.init),
                let frictionLevel = args["frictionLevel"] as? String
            else {
                result(FlutterError(code: "bad_args", message: "startBlock", details: nil))
                return
            }
            let strict = args["strictUninstallProtection"] as? Bool ?? false
            guard let selection = SharedStore.loadSelection(id: selectionId) else {
                result(FlutterError(
                    code: "unknown_selection", message: selectionId, details: nil))
                return
            }
            ShieldApplier.apply(
                selection,
                storeNamed: StoreNames.session(sessionId),
                denyAppRemoval: strict
            )
            SharedStore.saveSession(SessionInfo(
                sessionId: sessionId,
                selectionId: selectionId,
                endsAtEpochMs: endsAtEpochMs,
                frictionLevel: frictionLevel,
                strictUninstallProtection: strict
            ))
            startSessionEndMonitor(sessionId: sessionId, endsAtEpochMs: endsAtEpochMs)
            result(nil)

        case "stopBlock":
            guard
                let args = call.arguments as? [String: Any],
                let sessionId = args["sessionId"] as? String
            else {
                result(FlutterError(code: "bad_args", message: "stopBlock", details: nil))
                return
            }
            ShieldApplier.lift(storeNamed: StoreNames.session(sessionId))
            DeviceActivityCenter().stopMonitoring([sessionActivityName(sessionId)])
            SharedStore.saveSession(nil)
            result(nil)

        case "syncSchedules":
            guard
                let args = call.arguments as? [String: Any],
                let raw = args["schedules"] as? [[String: Any]]
            else {
                result(FlutterError(code: "bad_args", message: "syncSchedules", details: nil))
                return
            }
            do {
                try syncSchedules(raw)
                result(nil)
            } catch {
                result(FlutterError(
                    code: "schedule_failed",
                    message: error.localizedDescription, details: nil))
            }

        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private static func statusString(_ status: AuthorizationStatus) -> String {
        switch status {
        case .approved: return "approved"
        case .denied: return "denied"
        default: return "notDetermined"
        }
    }

    // MARK: - DeviceActivity

    private func sessionActivityName(_ sessionId: String) -> DeviceActivityName {
        .init("session_\(sessionId)")
    }

    /// Registers a one-shot DeviceActivity interval whose end lifts the
    /// session shield from the monitor extension even if this app is dead.
    /// DeviceActivity rejects intervals under 15 minutes — for shorter
    /// sessions (like the 2-minute dev proof) the Flutter side must call
    /// stopBlock itself; the shield also stays up harmlessly until then.
    private func startSessionEndMonitor(sessionId: String, endsAtEpochMs: Int64) {
        let end = Date(timeIntervalSince1970: TimeInterval(endsAtEpochMs) / 1000)
        guard end.timeIntervalSinceNow >= 15 * 60 else { return }
        let cal = Calendar.current
        let schedule = DeviceActivitySchedule(
            intervalStart: cal.dateComponents([.year, .month, .day, .hour, .minute], from: Date()),
            intervalEnd: cal.dateComponents([.year, .month, .day, .hour, .minute], from: end),
            repeats: false
        )
        try? DeviceActivityCenter().startMonitoring(
            sessionActivityName(sessionId), during: schedule)
    }

    private func syncSchedules(_ raw: [[String: Any]]) throws {
        let center = DeviceActivityCenter()
        // Drop every schedule_* activity, keep any running session monitor.
        let stale = center.activities.filter { $0.rawValue.hasPrefix("schedule_") }
        center.stopMonitoring(stale)
        for old in SharedStore.loadSchedules() {
            ShieldApplier.lift(storeNamed: StoreNames.schedule(old.profileId))
        }

        var infos: [ScheduleInfo] = []
        for entry in raw {
            guard
                let profileId = entry["profileId"] as? String,
                let selectionId = entry["selectionId"] as? String,
                let daysMask = entry["daysMask"] as? Int,
                let startMinutes = entry["startMinutes"] as? Int,
                let endMinutes = entry["endMinutes"] as? Int,
                let frictionLevel = entry["frictionLevel"] as? String
            else { continue }
            infos.append(ScheduleInfo(
                profileId: profileId, selectionId: selectionId, daysMask: daysMask,
                startMinutes: startMinutes, endMinutes: endMinutes,
                frictionLevel: frictionLevel))
        }
        SharedStore.saveSchedules(infos)

        for info in infos {
            // DeviceActivitySchedule has no day-of-week filter on a single
            // daily schedule; register one weekly-repeating activity per
            // selected day: schedule_<profileId>_<weekday 1=Sun…7=Sat>.
            for bit in 0..<7 where info.daysMask & (1 << bit) != 0 {
                let weekday = (bit + 2) > 7 ? 1 : bit + 2 // bit0=Mon → weekday 2
                var start = DateComponents()
                start.weekday = weekday
                start.hour = info.startMinutes / 60
                start.minute = info.startMinutes % 60
                var end = DateComponents()
                // Overnight windows (end <= start) end on the following day.
                let overnight = info.endMinutes <= info.startMinutes
                end.weekday = overnight ? (weekday % 7) + 1 : weekday
                end.hour = info.endMinutes / 60
                end.minute = info.endMinutes % 60
                try DeviceActivityCenter().startMonitoring(
                    DeviceActivityName("schedule_\(info.profileId)_\(weekday)"),
                    during: DeviceActivitySchedule(
                        intervalStart: start, intervalEnd: end, repeats: true)
                )
            }
        }
    }

    // MARK: - Event channel

    public func onListen(
        withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink
    ) -> FlutterError? {
        eventSink = events
        return nil
    }

    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }

    private func emit(type: String) {
        let session = SharedStore.loadSession()
        DispatchQueue.main.async { [weak self] in
            self?.eventSink?([
                "type": type,
                "sessionId": session?.sessionId as Any,
                "profileId": NSNull(),
            ])
        }
    }

    /// Extensions signal the app via payload-free Darwin notifications.
    private func observeDarwinNotifications() {
        let pairs: [(String, String)] = [
            (DarwinNames.shieldShown, "shieldShown"),
            (DarwinNames.intervalStarted, "scheduleIntervalStarted"),
            (DarwinNames.intervalEnded, "scheduleIntervalEnded"),
            (DarwinNames.earlyUnlockRequested, "earlyUnlockRequested"),
        ]
        let center = CFNotificationCenterGetDarwinNotifyCenter()
        let observer = UnsafeRawPointer(Unmanaged.passUnretained(self).toOpaque())
        for (darwinName, eventType) in pairs {
            NotificationForwarder.mapping[darwinName] = { [weak self] in
                self?.emit(type: eventType)
            }
            CFNotificationCenterAddObserver(
                center, observer,
                { _, _, name, _, _ in
                    guard let raw = name?.rawValue as String? else { return }
                    NotificationForwarder.mapping[raw]?()
                },
                darwinName as CFString, nil, .deliverImmediately
            )
        }
    }
}

/// CFNotification C callbacks cannot capture context; route through a table.
@available(iOS 16.0, *)
enum NotificationForwarder {
    static var mapping: [String: () -> Void] = [:]
}
