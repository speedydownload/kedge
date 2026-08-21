import 'package:drift/drift.dart';

import '../../domain/streak_logic.dart';
import '../db/database.dart';

final class StatsRepository {
  StatsRepository(this._db);

  final KedgeDatabase _db;

  Future<DailyStat?> forDay(String day) => (_db.select(_db.dailyStats)
        ..where((s) => s.day.equals(day)))
      .getSingleOrNull();

  Stream<DailyStat?> watchDay(String day) => (_db.select(_db.dailyStats)
        ..where((s) => s.day.equals(day)))
      .watchSingleOrNull();

  Future<List<DailyStat>> range(List<String> days) => (_db.select(_db.dailyStats)
        ..where((s) => s.day.isIn(days)))
      .get();

  Future<void> recordShieldShown(String day) =>
      _bump(day, (s) => DailyStatsCompanion(
            pickupsBlocked: Value(s.pickupsBlocked + 1),
          ));

  Future<void> recordEarlyUnlock(String day) =>
      _bump(day, (s) => DailyStatsCompanion(
            earlyUnlocks: Value(s.earlyUnlocks + 1),
          ));

  /// Held time is real elapsed shield time, capped at the session's
  /// scheduled length — never an invented number.
  Future<void> recordSessionEnd(
    String day, {
    required int secondsHeld,
    required bool completed,
  }) =>
      _bump(day, (s) => DailyStatsCompanion(
            secondsHeld: Value(s.secondsHeld + secondsHeld),
            sessionsCompleted:
                Value(s.sessionsCompleted + (completed ? 1 : 0)),
          ));

  Future<void> _bump(
    String day,
    DailyStatsCompanion Function(DailyStat current) delta,
  ) async {
    await _db.transaction(() async {
      final existing = await forDay(day);
      if (existing == null) {
        await _db.into(_db.dailyStats).insert(
              DailyStatsCompanion.insert(day: day),
              mode: InsertMode.insertOrIgnore,
            );
      }
      final current = (await forDay(day))!;
      await (_db.update(_db.dailyStats)..where((s) => s.day.equals(day)))
          .write(delta(current));
    });
  }
}

final class StreakRepository {
  StreakRepository(this._db);

  final KedgeDatabase _db;

  Future<Streak> load() =>
      (_db.select(_db.streaks)..where((s) => s.id.equals(0))).getSingle();

  Stream<Streak> watch() =>
      (_db.select(_db.streaks)..where((s) => s.id.equals(0))).watchSingle();

  /// Applies one day-outcome through [StreakLogic] and persists the result.
  Future<StreakUpdate> recordDay({required String day, required bool held}) async {
    final row = await load();
    final update = StreakLogic.apply(
      currentDays: row.currentDays,
      longestDays: row.longestDays,
      lastHeldDay: row.lastHeldDay,
      day: day,
      held: held,
    );
    await (_db.update(_db.streaks)..where((s) => s.id.equals(0))).write(
      StreaksCompanion(
        currentDays: Value(update.currentDays),
        longestDays: Value(update.longestDays),
        lastHeldDay: Value(update.lastHeldDay),
      ),
    );
    return update;
  }
}
