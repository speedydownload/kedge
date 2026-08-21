import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../../domain/enums.dart';
import 'tables.dart';

export '../../domain/enums.dart';

part 'database.g.dart';

@DriftDatabase(tables: [BlockProfiles, Sessions, DailyStats, Streaks])
class KedgeDatabase extends _$KedgeDatabase {
  KedgeDatabase() : super(driftDatabase(name: 'kedge'));

  /// In-memory database for tests.
  KedgeDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await into(streaks).insert(
            StreaksCompanion.insert(id: const Value(0)),
            mode: InsertMode.insertOrIgnore,
          );
        },
      );
}
