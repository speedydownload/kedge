import 'package:flutter/services.dart';

import 'blocking_engine.dart';

/// Shared platform-channel plumbing. The channel contract is identical on
/// both platforms; the native implementations differ (Screen Time APIs vs
/// UsageStats + overlay). Platform-specific Dart behaviour lives in the
/// subclasses below.
base class MethodChannelBlockingEngine implements BlockingEngine {
  MethodChannelBlockingEngine();

  static const _methods = MethodChannel('app.ballast/blocking');
  static const _events = EventChannel('app.ballast/blocking_events');

  Stream<BlockingEvent>? _eventStream;

  @override
  Future<BlockingAuthorizationStatus> authorizationStatus() async {
    final result = await _methods.invokeMethod<String>('authorizationStatus');
    return _parseAuthStatus(result);
  }

  @override
  Future<BlockingAuthorizationStatus> requestAuthorization() async {
    final result = await _methods.invokeMethod<String>('requestAuthorization');
    return _parseAuthStatus(result);
  }

  @override
  Future<AppSelection?> pickApps({String? existingSelectionId}) async {
    final result = await _methods.invokeMapMethod<String, Object?>(
      'pickApps',
      {'existingSelectionId': existingSelectionId},
    );
    if (result == null) return null;
    return AppSelection(
      selectionId: result['selectionId']! as String,
      appCount: result['appCount']! as int,
      categoryCount: (result['categoryCount'] as int?) ?? 0,
      packageNames:
          (result['packageNames'] as List?)?.cast<String>() ?? const [],
    );
  }

  @override
  Future<void> startBlock(BlockCommand command) => _methods.invokeMethod(
        'startBlock',
        {
          'sessionId': command.sessionId,
          'selectionId': command.selectionId,
          'endsAtEpochMs': command.endsAt.millisecondsSinceEpoch,
          'frictionLevel': command.frictionLevel.name,
          'strictUninstallProtection': command.strictUninstallProtection,
        },
      );

  @override
  Future<void> stopBlock(String sessionId) =>
      _methods.invokeMethod('stopBlock', {'sessionId': sessionId});

  @override
  Future<void> syncSchedules(List<ScheduleCommand> schedules) =>
      _methods.invokeMethod('syncSchedules', {
        'schedules': [
          for (final s in schedules)
            {
              'profileId': s.profileId,
              'selectionId': s.selectionId,
              'daysMask': s.daysMask,
              'startMinutes': s.startMinutes,
              'endMinutes': s.endMinutes,
              'frictionLevel': s.frictionLevel.name,
            },
        ],
      });

  @override
  Stream<BlockingEvent> events() => _eventStream ??= _events
      .receiveBroadcastStream()
      .map((raw) => _parseEvent((raw as Map).cast<String, Object?>()))
      .asBroadcastStream();

  BlockingAuthorizationStatus _parseAuthStatus(String? raw) =>
      switch (raw) {
        'approved' => BlockingAuthorizationStatus.approved,
        'denied' => BlockingAuthorizationStatus.denied,
        _ => BlockingAuthorizationStatus.notDetermined,
      };

  BlockingEvent _parseEvent(Map<String, Object?> raw) => BlockingEvent(
        type: BlockingEventType.values.byName(raw['type']! as String),
        sessionId: raw['sessionId'] as String?,
        profileId: raw['profileId'] as String?,
      );
}

/// iOS: FamilyControls / ManagedSettings / DeviceActivity (native, Phase 2).
final class IosBlockingEngine extends MethodChannelBlockingEngine {}

/// Android: UsageStats polling + overlay shield (native, Phase 7).
final class AndroidBlockingEngine extends MethodChannelBlockingEngine {}
