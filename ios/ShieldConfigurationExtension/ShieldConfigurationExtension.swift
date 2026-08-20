import ManagedSettings
import ManagedSettingsUI
import UIKit

/// The custom blocked screen. Phase 2 ships the static frame; the 40
/// rotating lines and per-friction buttons land in Phase 5.
@available(iOS 16.0, *)
final class ShieldConfigurationExtension: ShieldConfigurationDataSource {
    // Brand tokens (mirror lib/theme/tokens.dart — extensions cannot read Dart).
    private static let ink = UIColor(
        red: 0x0D / 255, green: 0x11 / 255, blue: 0x17 / 255, alpha: 1)
    private static let brass = UIColor(
        red: 0xE8 / 255, green: 0xB0 / 255, blue: 0x4B / 255, alpha: 1)
    private static let textPrimary = UIColor(
        red: 0xF2 / 255, green: 0xF4 / 255, blue: 0xF5 / 255, alpha: 1)
    private static let textSecondary = UIColor(
        red: 0x98 / 255, green: 0xA2 / 255, blue: 0xAE / 255, alpha: 1)

    private func ballastShield() -> ShieldConfiguration {
        DarwinNames.post(DarwinNames.shieldShown)
        let session = SharedStore.loadSession()
        let subtitleText: String
        if let session {
            let ends = Date(
                timeIntervalSince1970: TimeInterval(session.endsAtEpochMs) / 1000)
            let fmt = DateFormatter()
            fmt.timeStyle = .short
            subtitleText = "Blocked until \(fmt.string(from: ends)). You set this."
        } else {
            subtitleText = "Blocked for now. You set this."
        }
        return ShieldConfiguration(
            backgroundBlurStyle: .systemUltraThinMaterialDark,
            backgroundColor: Self.ink,
            icon: UIImage(named: "ShieldMark"),
            title: .init(text: "Blocked.", color: Self.textPrimary),
            subtitle: .init(text: subtitleText, color: Self.textSecondary),
            primaryButtonLabel: .init(text: "Not now", color: Self.ink),
            primaryButtonBackgroundColor: Self.brass,
            secondaryButtonLabel: nil
        )
    }

    override func configuration(shielding application: Application) -> ShieldConfiguration {
        ballastShield()
    }

    override func configuration(
        shielding application: Application, in category: ActivityCategory
    ) -> ShieldConfiguration {
        ballastShield()
    }

    override func configuration(shielding webDomain: WebDomain) -> ShieldConfiguration {
        ballastShield()
    }

    override func configuration(
        shielding webDomain: WebDomain, in category: ActivityCategory
    ) -> ShieldConfiguration {
        ballastShield()
    }
}
