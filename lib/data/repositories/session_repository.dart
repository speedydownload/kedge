import 'package:drift/drift.dart';

import '../../domain/session_machine.dart';
import '../db/database.dart';

final class SessionRepository {
  SessionRepository(this._db);

  final BallastDatabase _db;

  Future<Session?> byId(int id) =>
      (_db.select(_db.sessions)..where((s) => s.id.equals(id))).getSingleOrNull();

  Stream<Session?> watchActive() => (_db.select(_db.sessions)
        ..where((s) => s.state.equals(SessionState.active.index))
        ..orderBy([(s) => OrderingTerm.desc(s.startedAt)])
        ..limit(1))
      .watchSingleOrNull();

  Future<List<Session>> activeSessions() => (_db.select(_db.sessions)
        ..where((s) => s.state.equals(SessionState.active.index)))
      .get();

  Future<Session> createActive({
    required int profileId,
    required FrictionLevel frictionLevel,
    required DateTime startedAt,
    required DateTime scheduledEndAt,
  }) async {
    final id = await _db.into(_db.sessions).insert(SessionsCompanion.insert(
          profileId: profileId,
          frictionLevel: frictionLevel,
          state: SessionState.active,
          startedAt: startedAt,
          scheduledEndAt: scheduledEndAt,
        ));
    return (await byId(id))!;
  }

  /// Persists a legal transition computed by [SessionMachine].
  Future<void> applyTransition(int sessionId, SessionTransition t) =>
      (_db.update(_db.sessions)..where((s) => s.id.equals(sessionId))).write(
        SessionsCompanion(
          state: Value(t.state),
          endReason: Value(t.endReason),
          endedAt: Value(t.endedAt),
        ),
      );

  Future<void> incrementEarlyUnlocks(int sessionId) async {
    final session = await byId(sessionId);
    if (session == null) return;
    await (_db.update(_db.sessions)..where((s) => s.id.equals(sessionId)))
        .write(SessionsCompanion(
      earlyUnlockCount: Value(session.earlyUnlockCount + 1),
    ));
  }

  /// Sessions that ended (any terminal state) between [from] and [to].
  Future<List<Session>> endedBetween(DateTime from, DateTime to) =>
      (_db.select(_db.sessions)
            ..where((s) =>
                s.endedAt.isNotNull() &
                s.endedAt.isBiggerOrEqualValue(from) &
                s.endedAt.isSmallerThanValue(to)))
          .get();
}
