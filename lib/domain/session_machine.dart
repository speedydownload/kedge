import 'enums.dart';

/// Pure transition rules for a session's lifecycle. The database row is the
/// state; this class only answers "is this transition legal and what does
/// the row look like afterwards" so every rule is unit-testable without IO.
///
///   scheduled ──start──▶ active ──expire──▶ completed   (ranOut)
///       │                  │
///     cancel            earlyEnd
///       ▼                  ▼
///   cancelled          endedEarly                        (earlyUnlock)
final class SessionTransition {
  const SessionTransition({
    required this.state,
    required this.endReason,
    required this.endedAt,
  });

  final SessionState state;
  final SessionEndReason? endReason;
  final DateTime? endedAt;
}

final class InvalidSessionTransition implements Exception {
  InvalidSessionTransition(this.from, this.attempted);

  final SessionState from;
  final String attempted;

  @override
  String toString() => 'InvalidSessionTransition: cannot $attempted from $from';
}

abstract final class SessionMachine {
  /// scheduled → active. Schedule-armed sessions become active when their
  /// window opens; on-demand sessions are created directly in [SessionState.active].
  static SessionTransition start({required SessionState from}) {
    _require(from == SessionState.scheduled, from, 'start');
    return SessionTransition(
      state: SessionState.active,
      endReason: null,
      endedAt: null,
    );
  }

  /// active → completed, only once the clock has actually run out.
  /// Never invent a completion: callers pass the real `now`.
  static SessionTransition expire({
    required SessionState from,
    required DateTime scheduledEndAt,
    required DateTime now,
  }) {
    _require(from == SessionState.active, from, 'expire');
    if (now.isBefore(scheduledEndAt)) {
      throw InvalidSessionTransition(from, 'expire before scheduledEndAt');
    }
    return SessionTransition(
      state: SessionState.completed,
      endReason: SessionEndReason.ranOut,
      // The session held until its scheduled end, not until whenever the
      // expiry check happened to run (app relaunch can be much later).
      endedAt: scheduledEndAt,
    );
  }

  /// active → endedEarly. Friction has already been satisfied by the caller
  /// (FrictionPolicy decides *whether*; this only records the outcome).
  static SessionTransition endEarly({
    required SessionState from,
    required DateTime now,
  }) {
    _require(from == SessionState.active, from, 'endEarly');
    return SessionTransition(
      state: SessionState.endedEarly,
      endReason: SessionEndReason.earlyUnlock,
      endedAt: now,
    );
  }

  /// scheduled → cancelled. A block that never started carries no shame.
  static SessionTransition cancel({
    required SessionState from,
    required DateTime now,
  }) {
    _require(from == SessionState.scheduled, from, 'cancel');
    return SessionTransition(
      state: SessionState.cancelled,
      endReason: SessionEndReason.cancelledBeforeStart,
      endedAt: now,
    );
  }

  static bool isTerminal(SessionState state) => switch (state) {
        SessionState.scheduled || SessionState.active => false,
        SessionState.completed ||
        SessionState.endedEarly ||
        SessionState.cancelled =>
          true,
      };

  /// A session counts as held only if it ran out on its own with zero
  /// early unlocks — the honest definition behind every streak and stat.
  static bool held({
    required SessionState state,
    required int earlyUnlockCount,
  }) =>
      state == SessionState.completed && earlyUnlockCount == 0;

  static void _require(bool ok, SessionState from, String attempted) {
    if (!ok) throw InvalidSessionTransition(from, attempted);
  }
}
