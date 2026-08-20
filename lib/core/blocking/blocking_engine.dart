import '../../domain/enums.dart';

/// Whether the platform has granted Ballast the ability to block apps.
/// iOS: FamilyControls authorization. Android: Usage Access + overlay.
enum BlockingAuthorizationStatus { notDetermined, denied, approved }

/// Result of the platform app picker.
///
/// iOS never exposes app names — only an opaque selection stored natively in
/// the App Group under [selectionId], plus counts. Android additionally fills
/// [packageNames] because its picker is Dart-side and names are available.
final class AppSelection {
  const AppSelection({
    required this.selectionId,
    required this.appCount,
    this.categoryCount = 0,
    this.packageNames = const [],
  });

  final String selectionId;
  final int appCount;
  final int categoryCount;
  final List<String> packageNames;
}

/// Instruction to shield a selection until [endsAt].
final class BlockCommand {
  const BlockCommand({
    required this.sessionId,
    required this.selectionId,
    required this.endsAt,
    required this.frictionLevel,
    this.strictUninstallProtection = false,
  });

  final String sessionId;
  final String selectionId;
  final DateTime endsAt;
  final FrictionLevel frictionLevel;

  /// Only ever true when the user explicitly enabled Strict Mode.
  final bool strictUninstallProtection;
}

/// A recurring schedule the native side must enforce even when the Flutter
/// app is dead (iOS: DeviceActivitySchedule; Android: alarms + service).
final class ScheduleCommand {
  const ScheduleCommand({
    required this.profileId,
    required this.selectionId,
    required this.daysMask, // bit 0 = Monday … bit 6 = Sunday
    required this.startMinutes, // minutes since midnight, local time
    required this.endMinutes,
    required this.frictionLevel,
  });

  final String profileId;
  final String selectionId;
  final int daysMask;
  final int startMinutes;
  final int endMinutes;
  final FrictionLevel frictionLevel;
}

/// Events pushed up from the native layer.
enum BlockingEventType {
  shieldShown,
  scheduleIntervalStarted,
  scheduleIntervalEnded,
  earlyUnlockRequested,
  authorizationRevoked,
}

final class BlockingEvent {
  const BlockingEvent({required this.type, this.sessionId, this.profileId});

  final BlockingEventType type;
  final String? sessionId;
  final String? profileId;
}

/// The single seam between Flutter and the native blocking layers.
/// All UI and domain code talks to this interface only — never to a
/// platform channel directly.
abstract interface class BlockingEngine {
  Future<BlockingAuthorizationStatus> authorizationStatus();

  Future<BlockingAuthorizationStatus> requestAuthorization();

  /// iOS presents the native FamilyActivityPicker and returns opaque counts.
  /// Android returns null here; its picker is built in Flutter (Phase 7) and
  /// selections are registered via [startBlock]/[syncSchedules] directly.
  Future<AppSelection?> pickApps({String? existingSelectionId});

  Future<void> startBlock(BlockCommand command);

  Future<void> stopBlock(String sessionId);

  /// Replaces the full set of native schedules with [schedules].
  Future<void> syncSchedules(List<ScheduleCommand> schedules);

  Stream<BlockingEvent> events();
}
