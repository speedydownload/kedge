import '../core/blocking/blocking_engine.dart';
import '../data/db/database.dart';
import '../data/repositories/session_repository.dart';
import '../data/repositories/stats_repository.dart';
import 'friction_policy.dart';
import 'session_machine.dart';
import 'streak_logic.dart';

/// Orchestrates one session's life: DB rows via the repositories, shields
/// via [BlockingEngine], rules via [SessionMachine]/[FrictionPolicy].
/// All time flows through the injected clock so tests own the clock.
final class SessionService {
  SessionService({
    required this._sessions,
    required this._stats,
    required this._streaks,
    required this._engine,
    DateTime Function()? now,
  }) : _now = now ?? DateTime.now;

  final SessionRepository _sessions;
  final StatsRepository _stats;
  final StreakRepository _streaks;
  final BlockingEngine _engine;
  final DateTime Function() _now;

  /// Starts an on-demand block and applies the shield natively.
  Future<Session> startOnDemand({
    required BlockProfile profile,
    required Duration duration,
  }) async {
    final now = _now();
    final session = await _sessions.createActive(
      profileId: profile.id,
      frictionLevel: profile.frictionLevel,
      startedAt: now,
      scheduledEndAt: now.add(duration),
    );
    await _engine.startBlock(BlockCommand(
      sessionId: session.id.toString(),
      selectionId: profile.iosSelectionId ?? '',
      endsAt: session.scheduledEndAt,
      frictionLevel: session.frictionLevel,
      strictUninstallProtection:
          FrictionPolicy.uninstallProtection(session.frictionLevel),
    ));
    return session;
  }

  /// Completes every active session whose clock has run out (call on app
  /// resume and on a periodic tick — sessions must survive force-quit).
  Future<List<Session>> completeExpired() async {
    final now = _now();
    final completed = <Session>[];
    for (final session in await _sessions.activeSessions()) {
      if (now.isBefore(session.scheduledEndAt)) continue;
      final t = SessionMachine.expire(
        from: session.state,
        scheduledEndAt: session.scheduledEndAt,
        now: now,
      );
      await _finish(session, t);
      completed.add(session);
    }
    return completed;
  }

  /// Step 1 of an early unlock: what does friction demand?
  Future<UnlockRuling> requestEarlyUnlock(Session session) async {
    final today = StreakLogic.dayKey(_now());
    final stat = await _stats.forDay(today);
    return FrictionPolicy.requestEarlyUnlock(
      level: session.frictionLevel,
      earlyUnlocksToday: stat?.earlyUnlocks ?? 0,
    );
  }

  /// Step 2: the user satisfied the friction (waited, typed the
  /// passphrase). Applies the granted effect.
  Future<void> executeEarlyUnlock(Session session, UnlockRuling ruling) async {
    assert(ruling.allowed && ruling.effect != null);
    final now = _now();
    final today = StreakLogic.dayKey(now);
    await _sessions.incrementEarlyUnlocks(session.id);
    await _stats.recordEarlyUnlock(today);

    switch (ruling.effect!) {
      case UnlockEffect.pauseShield:
        // Gentle: lift the shield now; the native side re-applies it after
        // FrictionPolicy.gentlePause (Phase 5 wiring). Session stays active.
        await _engine.stopBlock(session.id.toString());
      case UnlockEffect.endSession:
        final t = SessionMachine.endEarly(from: session.state, now: now);
        await _finish(session, t);
    }
  }

  Future<void> _finish(Session session, SessionTransition t) async {
    await _sessions.applyTransition(session.id, t);
    await _engine.stopBlock(session.id.toString());

    final endedAt = t.endedAt ?? _now();
    final secondsHeld = endedAt
        .difference(session.startedAt)
        .inSeconds
        .clamp(0, session.scheduledEndAt.difference(session.startedAt).inSeconds);
    final day = StreakLogic.dayKey(endedAt);
    final completed = t.state == SessionState.completed;
    await _stats.recordSessionEnd(
      day,
      secondsHeld: secondsHeld,
      completed: completed,
    );
    await _streaks.recordDay(
      day: day,
      held: SessionMachine.held(
        state: t.state,
        earlyUnlockCount: (await _sessions.byId(session.id))!.earlyUnlockCount,
      ),
    );
  }
}
