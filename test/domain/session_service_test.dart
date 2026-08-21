import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:kedge/core/blocking/blocking_engine.dart';
import 'package:kedge/data/db/database.dart';
import 'package:kedge/data/repositories/profile_repository.dart';
import 'package:kedge/data/repositories/session_repository.dart';
import 'package:kedge/data/repositories/stats_repository.dart';
import 'package:kedge/domain/friction_policy.dart';
import 'package:kedge/domain/session_service.dart';

final class FakeEngine implements BlockingEngine {
  final startedSessions = <String>[];
  final stoppedSessions = <String>[];
  BlockCommand? lastCommand;

  @override
  Future<void> startBlock(BlockCommand command) async {
    startedSessions.add(command.sessionId);
    lastCommand = command;
  }

  @override
  Future<void> stopBlock(String sessionId) async =>
      stoppedSessions.add(sessionId);

  @override
  Future<BlockingAuthorizationStatus> authorizationStatus() async =>
      BlockingAuthorizationStatus.approved;

  @override
  Future<BlockingAuthorizationStatus> requestAuthorization() async =>
      BlockingAuthorizationStatus.approved;

  @override
  Future<AppSelection?> pickApps({String? existingSelectionId}) async => null;

  @override
  Future<void> syncSchedules(List<ScheduleCommand> schedules) async {}

  @override
  Stream<BlockingEvent> events() => const Stream.empty();
}

void main() {
  late KedgeDatabase db;
  late FakeEngine engine;
  late SessionRepository sessions;
  late StatsRepository stats;
  late StreakRepository streaks;
  late DateTime now;
  late SessionService service;
  late BlockProfile profile;

  Future<BlockProfile> makeProfile({
    FrictionLevel friction = FrictionLevel.gentle,
  }) async {
    final repo = ProfileRepository(db, now: () => now);
    final id = await repo.create(
      name: 'Deep work',
      triggerType: TriggerType.onDemand,
      frictionLevel: friction,
      iosSelectionId: 'sel-1',
      appCount: 4,
    );
    return (await repo.byId(id))!;
  }

  setUp(() async {
    db = KedgeDatabase.forTesting(NativeDatabase.memory());
    engine = FakeEngine();
    sessions = SessionRepository(db);
    stats = StatsRepository(db);
    streaks = StreakRepository(db);
    now = DateTime(2026, 8, 21, 9);
    service = SessionService(
      sessions: sessions,
      stats: stats,
      streaks: streaks,
      engine: engine,
      now: () => now,
    );
    profile = await makeProfile();
  });

  tearDown(() => db.close());

  test('startOnDemand persists an active session and shields natively', () async {
    final session =
        await service.startOnDemand(profile: profile, duration: const Duration(hours: 1));

    expect(session.state, SessionState.active);
    expect(session.scheduledEndAt, DateTime(2026, 8, 21, 10));
    expect(engine.startedSessions, [session.id.toString()]);
    expect(engine.lastCommand!.selectionId, 'sel-1');
    expect(engine.lastCommand!.strictUninstallProtection, isFalse);
  });

  test('strict profiles request uninstall protection', () async {
    final strict = await makeProfile(friction: FrictionLevel.strict);
    await service.startOnDemand(profile: strict, duration: const Duration(hours: 1));
    expect(engine.lastCommand!.strictUninstallProtection, isTrue);
  });

  test('completeExpired is a no-op while time remains', () async {
    await service.startOnDemand(profile: profile, duration: const Duration(hours: 1));
    now = DateTime(2026, 8, 21, 9, 59);
    expect(await service.completeExpired(), isEmpty);
    expect(engine.stoppedSessions, isEmpty);
  });

  test('a held session completes: stats, streak, native stop', () async {
    final session =
        await service.startOnDemand(profile: profile, duration: const Duration(hours: 1));
    now = DateTime(2026, 8, 21, 11); // an hour late — app was force-quit
    final done = await service.completeExpired();

    expect(done.single.id, session.id);
    final row = (await sessions.byId(session.id))!;
    expect(row.state, SessionState.completed);
    expect(row.endReason, SessionEndReason.ranOut);
    expect(row.endedAt, DateTime(2026, 8, 21, 10)); // scheduled end, not 11:00
    expect(engine.stoppedSessions, [session.id.toString()]);

    final day = (await stats.forDay('2026-08-21'))!;
    expect(day.secondsHeld, 3600); // capped at the scheduled hour
    expect(day.sessionsCompleted, 1);

    final streak = await streaks.load();
    expect(streak.currentDays, 1);
    expect(streak.lastHeldDay, '2026-08-21');
  });

  test('gentle early unlock pauses the shield but keeps the session', () async {
    final session =
        await service.startOnDemand(profile: profile, duration: const Duration(hours: 1));
    now = DateTime(2026, 8, 21, 9, 20);

    final ruling = await service.requestEarlyUnlock(session);
    expect(ruling.allowed, isTrue);
    expect(ruling.effect, UnlockEffect.pauseShield);

    await service.executeEarlyUnlock(session, ruling);
    final row = (await sessions.byId(session.id))!;
    expect(row.state, SessionState.active); // survives
    expect(row.earlyUnlockCount, 1);
    expect(engine.stoppedSessions, [session.id.toString()]);
    expect((await stats.forDay('2026-08-21'))!.earlyUnlocks, 1);
  });

  test('a paused-then-completed session is not held', () async {
    final session =
        await service.startOnDemand(profile: profile, duration: const Duration(hours: 1));
    now = DateTime(2026, 8, 21, 9, 20);
    await service.executeEarlyUnlock(
        session, await service.requestEarlyUnlock(session));

    now = DateTime(2026, 8, 21, 10, 1);
    await service.completeExpired();
    expect((await streaks.load()).currentDays, 0);
  });

  test('firm unlock ends the session and is limited to three per day', () async {
    final firm = await makeProfile(friction: FrictionLevel.firm);

    for (var i = 0; i < 3; i++) {
      final session = await service.startOnDemand(
          profile: firm, duration: const Duration(hours: 1));
      final ruling = await service.requestEarlyUnlock(session);
      expect(ruling.allowed, isTrue, reason: 'unlock ${i + 1} of 3');
      expect(ruling.wait, const Duration(seconds: 60));
      await service.executeEarlyUnlock(session, ruling);
      final row = (await sessions.byId(session.id))!;
      expect(row.state, SessionState.endedEarly);
    }

    final fourth = await service.startOnDemand(
        profile: firm, duration: const Duration(hours: 1));
    final denied = await service.requestEarlyUnlock(fourth);
    expect(denied.allowed, isFalse);
  });

  test('endedEarly still accrues honest held seconds', () async {
    final firm = await makeProfile(friction: FrictionLevel.firm);
    final session = await service.startOnDemand(
        profile: firm, duration: const Duration(hours: 1));
    now = DateTime(2026, 8, 21, 9, 30);
    await service.executeEarlyUnlock(
        session, await service.requestEarlyUnlock(session));

    final day = (await stats.forDay('2026-08-21'))!;
    expect(day.secondsHeld, 1800); // held 30 real minutes before bailing
    expect(day.sessionsCompleted, 0);
  });
}
