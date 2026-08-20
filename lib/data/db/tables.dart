import 'package:drift/drift.dart';

import '../../domain/enums.dart';

/// A Block Profile = name + app selection + trigger + friction level.
class BlockProfiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 60)();
  IntColumn get triggerType => intEnum<TriggerType>()();
  IntColumn get frictionLevel => intEnum<FrictionLevel>()();

  /// Opaque id referencing a serialized FamilyActivitySelection in the iOS
  /// App Group (iOS never exposes app names to us).
  TextColumn get iosSelectionId => text().nullable()();

  /// JSON-encoded list of Android package names.
  TextColumn get androidPackagesJson => text().nullable()();

  /// Display-only count of selected apps ("12 apps blocked").
  IntColumn get appCount => integer().withDefault(const Constant(0))();
  IntColumn get categoryCount => integer().withDefault(const Constant(0))();

  // Schedule trigger: bit 0 = Monday … bit 6 = Sunday; minutes since
  // midnight local time. End may be past midnight (end < start = overnight).
  IntColumn get scheduleDaysMask => integer().nullable()();
  IntColumn get scheduleStartMinutes => integer().nullable()();
  IntColumn get scheduleEndMinutes => integer().nullable()();

  /// App-limit trigger: shield after this many minutes of use in a day.
  IntColumn get appLimitMinutes => integer().nullable()();

  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

class Sessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get profileId => integer().references(BlockProfiles, #id)();

  /// Snapshot of the profile's friction at start; editing the profile must
  /// not change a running session's rules.
  IntColumn get frictionLevel => intEnum<FrictionLevel>()();
  IntColumn get state => intEnum<SessionState>()();
  IntColumn get endReason => intEnum<SessionEndReason>().nullable()();

  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get scheduledEndAt => dateTime()();
  DateTimeColumn get endedAt => dateTime().nullable()();

  IntColumn get earlyUnlockCount => integer().withDefault(const Constant(0))();
}

/// One row per local calendar day, keyed "yyyy-MM-dd".
class DailyStats extends Table {
  TextColumn get day => text()();
  IntColumn get pickupsBlocked => integer().withDefault(const Constant(0))();

  /// Held time in seconds. "Minutes saved" is derived; never invented.
  IntColumn get secondsHeld => integer().withDefault(const Constant(0))();
  IntColumn get sessionsCompleted => integer().withDefault(const Constant(0))();
  IntColumn get earlyUnlocks => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {day};
}

/// Single-row table (id = 0).
class Streaks extends Table {
  IntColumn get id => integer()();
  IntColumn get currentDays => integer().withDefault(const Constant(0))();
  IntColumn get longestDays => integer().withDefault(const Constant(0))();

  /// Last day ("yyyy-MM-dd") that counted toward the streak.
  TextColumn get lastHeldDay => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
