import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ballast/data/db/database.dart';

void main() {
  late BallastDatabase db;

  setUp(() => db = BallastDatabase.forTesting(NativeDatabase.memory()));
  tearDown(() => db.close());

  test('creates schema and seeds the singleton streak row', () async {
    final streak = await (db.select(db.streaks)
          ..where((s) => s.id.equals(0)))
        .getSingle();
    expect(streak.currentDays, 0);
    expect(streak.longestDays, 0);
    expect(streak.lastHeldDay, isNull);
  });

  test('round-trips a block profile with enum columns', () async {
    final id = await db.into(db.blockProfiles).insert(
          BlockProfilesCompanion.insert(
            name: 'Evenings',
            triggerType: TriggerType.schedule,
            frictionLevel: FrictionLevel.firm,
            scheduleDaysMask: const Value(0x7F),
            scheduleStartMinutes: const Value(21 * 60),
            scheduleEndMinutes: const Value(6 * 60),
            createdAt: DateTime(2026, 8, 20),
            updatedAt: DateTime(2026, 8, 20),
          ),
        );

    final profile = await (db.select(db.blockProfiles)
          ..where((p) => p.id.equals(id)))
        .getSingle();
    expect(profile.triggerType, TriggerType.schedule);
    expect(profile.frictionLevel, FrictionLevel.firm);
    expect(profile.scheduleDaysMask, 0x7F);
    expect(profile.isArchived, false);
  });
}
