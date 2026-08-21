import 'dart:convert';

import 'package:drift/drift.dart';

import '../db/database.dart';

final class ProfileRepository {
  ProfileRepository(this._db, {DateTime Function()? now})
      : _now = now ?? DateTime.now;

  final BallastDatabase _db;
  final DateTime Function() _now;

  Stream<List<BlockProfile>> watchAll() => (_db.select(_db.blockProfiles)
        ..where((p) => p.isArchived.equals(false))
        ..orderBy([(p) => OrderingTerm.asc(p.createdAt)]))
      .watch();

  Future<BlockProfile?> byId(int id) => (_db.select(_db.blockProfiles)
        ..where((p) => p.id.equals(id)))
      .getSingleOrNull();

  Future<int> activeCount() async {
    final count = _db.blockProfiles.id.count();
    final query = _db.selectOnly(_db.blockProfiles)
      ..addColumns([count])
      ..where(_db.blockProfiles.isArchived.equals(false));
    final row = await query.getSingle();
    return row.read(count) ?? 0;
  }

  Future<int> create({
    required String name,
    required TriggerType triggerType,
    required FrictionLevel frictionLevel,
    String? iosSelectionId,
    List<String>? androidPackages,
    int appCount = 0,
    int categoryCount = 0,
    int? scheduleDaysMask,
    int? scheduleStartMinutes,
    int? scheduleEndMinutes,
    int? appLimitMinutes,
  }) {
    final now = _now();
    return _db.into(_db.blockProfiles).insert(BlockProfilesCompanion.insert(
          name: name,
          triggerType: triggerType,
          frictionLevel: frictionLevel,
          iosSelectionId: Value(iosSelectionId),
          androidPackagesJson:
              Value(androidPackages == null ? null : jsonEncode(androidPackages)),
          appCount: Value(appCount),
          categoryCount: Value(categoryCount),
          scheduleDaysMask: Value(scheduleDaysMask),
          scheduleStartMinutes: Value(scheduleStartMinutes),
          scheduleEndMinutes: Value(scheduleEndMinutes),
          appLimitMinutes: Value(appLimitMinutes),
          createdAt: now,
          updatedAt: now,
        ));
  }

  Future<void> update(BlockProfile profile) =>
      _db.update(_db.blockProfiles).replace(
            profile.copyWith(updatedAt: _now()),
          );

  /// Profiles are archived, never deleted — sessions keep their history.
  Future<void> archive(int id) => (_db.update(_db.blockProfiles)
        ..where((p) => p.id.equals(id)))
      .write(BlockProfilesCompanion(
        isArchived: const Value(true),
        updatedAt: Value(_now()),
      ));

  static List<String> decodePackages(BlockProfile profile) =>
      profile.androidPackagesJson == null
          ? const []
          : (jsonDecode(profile.androidPackagesJson!) as List).cast<String>();
}
