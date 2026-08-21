// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $BlockProfilesTable extends BlockProfiles
    with TableInfo<$BlockProfilesTable, BlockProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BlockProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 60,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<TriggerType, int> triggerType =
      GeneratedColumn<int>(
        'trigger_type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<TriggerType>($BlockProfilesTable.$convertertriggerType);
  @override
  late final GeneratedColumnWithTypeConverter<FrictionLevel, int>
  frictionLevel = GeneratedColumn<int>(
    'friction_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  ).withConverter<FrictionLevel>($BlockProfilesTable.$converterfrictionLevel);
  static const VerificationMeta _iosSelectionIdMeta = const VerificationMeta(
    'iosSelectionId',
  );
  @override
  late final GeneratedColumn<String> iosSelectionId = GeneratedColumn<String>(
    'ios_selection_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _androidPackagesJsonMeta =
      const VerificationMeta('androidPackagesJson');
  @override
  late final GeneratedColumn<String> androidPackagesJson =
      GeneratedColumn<String>(
        'android_packages_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _appCountMeta = const VerificationMeta(
    'appCount',
  );
  @override
  late final GeneratedColumn<int> appCount = GeneratedColumn<int>(
    'app_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _categoryCountMeta = const VerificationMeta(
    'categoryCount',
  );
  @override
  late final GeneratedColumn<int> categoryCount = GeneratedColumn<int>(
    'category_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _scheduleDaysMaskMeta = const VerificationMeta(
    'scheduleDaysMask',
  );
  @override
  late final GeneratedColumn<int> scheduleDaysMask = GeneratedColumn<int>(
    'schedule_days_mask',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _scheduleStartMinutesMeta =
      const VerificationMeta('scheduleStartMinutes');
  @override
  late final GeneratedColumn<int> scheduleStartMinutes = GeneratedColumn<int>(
    'schedule_start_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _scheduleEndMinutesMeta =
      const VerificationMeta('scheduleEndMinutes');
  @override
  late final GeneratedColumn<int> scheduleEndMinutes = GeneratedColumn<int>(
    'schedule_end_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _appLimitMinutesMeta = const VerificationMeta(
    'appLimitMinutes',
  );
  @override
  late final GeneratedColumn<int> appLimitMinutes = GeneratedColumn<int>(
    'app_limit_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    triggerType,
    frictionLevel,
    iosSelectionId,
    androidPackagesJson,
    appCount,
    categoryCount,
    scheduleDaysMask,
    scheduleStartMinutes,
    scheduleEndMinutes,
    appLimitMinutes,
    isArchived,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'block_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<BlockProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('ios_selection_id')) {
      context.handle(
        _iosSelectionIdMeta,
        iosSelectionId.isAcceptableOrUnknown(
          data['ios_selection_id']!,
          _iosSelectionIdMeta,
        ),
      );
    }
    if (data.containsKey('android_packages_json')) {
      context.handle(
        _androidPackagesJsonMeta,
        androidPackagesJson.isAcceptableOrUnknown(
          data['android_packages_json']!,
          _androidPackagesJsonMeta,
        ),
      );
    }
    if (data.containsKey('app_count')) {
      context.handle(
        _appCountMeta,
        appCount.isAcceptableOrUnknown(data['app_count']!, _appCountMeta),
      );
    }
    if (data.containsKey('category_count')) {
      context.handle(
        _categoryCountMeta,
        categoryCount.isAcceptableOrUnknown(
          data['category_count']!,
          _categoryCountMeta,
        ),
      );
    }
    if (data.containsKey('schedule_days_mask')) {
      context.handle(
        _scheduleDaysMaskMeta,
        scheduleDaysMask.isAcceptableOrUnknown(
          data['schedule_days_mask']!,
          _scheduleDaysMaskMeta,
        ),
      );
    }
    if (data.containsKey('schedule_start_minutes')) {
      context.handle(
        _scheduleStartMinutesMeta,
        scheduleStartMinutes.isAcceptableOrUnknown(
          data['schedule_start_minutes']!,
          _scheduleStartMinutesMeta,
        ),
      );
    }
    if (data.containsKey('schedule_end_minutes')) {
      context.handle(
        _scheduleEndMinutesMeta,
        scheduleEndMinutes.isAcceptableOrUnknown(
          data['schedule_end_minutes']!,
          _scheduleEndMinutesMeta,
        ),
      );
    }
    if (data.containsKey('app_limit_minutes')) {
      context.handle(
        _appLimitMinutesMeta,
        appLimitMinutes.isAcceptableOrUnknown(
          data['app_limit_minutes']!,
          _appLimitMinutesMeta,
        ),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BlockProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BlockProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      triggerType: $BlockProfilesTable.$convertertriggerType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}trigger_type'],
        )!,
      ),
      frictionLevel: $BlockProfilesTable.$converterfrictionLevel.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}friction_level'],
        )!,
      ),
      iosSelectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ios_selection_id'],
      ),
      androidPackagesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}android_packages_json'],
      ),
      appCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}app_count'],
      )!,
      categoryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_count'],
      )!,
      scheduleDaysMask: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}schedule_days_mask'],
      ),
      scheduleStartMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}schedule_start_minutes'],
      ),
      scheduleEndMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}schedule_end_minutes'],
      ),
      appLimitMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}app_limit_minutes'],
      ),
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $BlockProfilesTable createAlias(String alias) {
    return $BlockProfilesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TriggerType, int, int> $convertertriggerType =
      const EnumIndexConverter<TriggerType>(TriggerType.values);
  static JsonTypeConverter2<FrictionLevel, int, int> $converterfrictionLevel =
      const EnumIndexConverter<FrictionLevel>(FrictionLevel.values);
}

class BlockProfile extends DataClass implements Insertable<BlockProfile> {
  final int id;
  final String name;
  final TriggerType triggerType;
  final FrictionLevel frictionLevel;

  /// Opaque id referencing a serialized FamilyActivitySelection in the iOS
  /// App Group (iOS never exposes app names to us).
  final String? iosSelectionId;

  /// JSON-encoded list of Android package names.
  final String? androidPackagesJson;

  /// Display-only count of selected apps ("12 apps blocked").
  final int appCount;
  final int categoryCount;
  final int? scheduleDaysMask;
  final int? scheduleStartMinutes;
  final int? scheduleEndMinutes;

  /// App-limit trigger: shield after this many minutes of use in a day.
  final int? appLimitMinutes;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime updatedAt;
  const BlockProfile({
    required this.id,
    required this.name,
    required this.triggerType,
    required this.frictionLevel,
    this.iosSelectionId,
    this.androidPackagesJson,
    required this.appCount,
    required this.categoryCount,
    this.scheduleDaysMask,
    this.scheduleStartMinutes,
    this.scheduleEndMinutes,
    this.appLimitMinutes,
    required this.isArchived,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    {
      map['trigger_type'] = Variable<int>(
        $BlockProfilesTable.$convertertriggerType.toSql(triggerType),
      );
    }
    {
      map['friction_level'] = Variable<int>(
        $BlockProfilesTable.$converterfrictionLevel.toSql(frictionLevel),
      );
    }
    if (!nullToAbsent || iosSelectionId != null) {
      map['ios_selection_id'] = Variable<String>(iosSelectionId);
    }
    if (!nullToAbsent || androidPackagesJson != null) {
      map['android_packages_json'] = Variable<String>(androidPackagesJson);
    }
    map['app_count'] = Variable<int>(appCount);
    map['category_count'] = Variable<int>(categoryCount);
    if (!nullToAbsent || scheduleDaysMask != null) {
      map['schedule_days_mask'] = Variable<int>(scheduleDaysMask);
    }
    if (!nullToAbsent || scheduleStartMinutes != null) {
      map['schedule_start_minutes'] = Variable<int>(scheduleStartMinutes);
    }
    if (!nullToAbsent || scheduleEndMinutes != null) {
      map['schedule_end_minutes'] = Variable<int>(scheduleEndMinutes);
    }
    if (!nullToAbsent || appLimitMinutes != null) {
      map['app_limit_minutes'] = Variable<int>(appLimitMinutes);
    }
    map['is_archived'] = Variable<bool>(isArchived);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BlockProfilesCompanion toCompanion(bool nullToAbsent) {
    return BlockProfilesCompanion(
      id: Value(id),
      name: Value(name),
      triggerType: Value(triggerType),
      frictionLevel: Value(frictionLevel),
      iosSelectionId: iosSelectionId == null && nullToAbsent
          ? const Value.absent()
          : Value(iosSelectionId),
      androidPackagesJson: androidPackagesJson == null && nullToAbsent
          ? const Value.absent()
          : Value(androidPackagesJson),
      appCount: Value(appCount),
      categoryCount: Value(categoryCount),
      scheduleDaysMask: scheduleDaysMask == null && nullToAbsent
          ? const Value.absent()
          : Value(scheduleDaysMask),
      scheduleStartMinutes: scheduleStartMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(scheduleStartMinutes),
      scheduleEndMinutes: scheduleEndMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(scheduleEndMinutes),
      appLimitMinutes: appLimitMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(appLimitMinutes),
      isArchived: Value(isArchived),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory BlockProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BlockProfile(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      triggerType: $BlockProfilesTable.$convertertriggerType.fromJson(
        serializer.fromJson<int>(json['triggerType']),
      ),
      frictionLevel: $BlockProfilesTable.$converterfrictionLevel.fromJson(
        serializer.fromJson<int>(json['frictionLevel']),
      ),
      iosSelectionId: serializer.fromJson<String?>(json['iosSelectionId']),
      androidPackagesJson: serializer.fromJson<String?>(
        json['androidPackagesJson'],
      ),
      appCount: serializer.fromJson<int>(json['appCount']),
      categoryCount: serializer.fromJson<int>(json['categoryCount']),
      scheduleDaysMask: serializer.fromJson<int?>(json['scheduleDaysMask']),
      scheduleStartMinutes: serializer.fromJson<int?>(
        json['scheduleStartMinutes'],
      ),
      scheduleEndMinutes: serializer.fromJson<int?>(json['scheduleEndMinutes']),
      appLimitMinutes: serializer.fromJson<int?>(json['appLimitMinutes']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'triggerType': serializer.toJson<int>(
        $BlockProfilesTable.$convertertriggerType.toJson(triggerType),
      ),
      'frictionLevel': serializer.toJson<int>(
        $BlockProfilesTable.$converterfrictionLevel.toJson(frictionLevel),
      ),
      'iosSelectionId': serializer.toJson<String?>(iosSelectionId),
      'androidPackagesJson': serializer.toJson<String?>(androidPackagesJson),
      'appCount': serializer.toJson<int>(appCount),
      'categoryCount': serializer.toJson<int>(categoryCount),
      'scheduleDaysMask': serializer.toJson<int?>(scheduleDaysMask),
      'scheduleStartMinutes': serializer.toJson<int?>(scheduleStartMinutes),
      'scheduleEndMinutes': serializer.toJson<int?>(scheduleEndMinutes),
      'appLimitMinutes': serializer.toJson<int?>(appLimitMinutes),
      'isArchived': serializer.toJson<bool>(isArchived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  BlockProfile copyWith({
    int? id,
    String? name,
    TriggerType? triggerType,
    FrictionLevel? frictionLevel,
    Value<String?> iosSelectionId = const Value.absent(),
    Value<String?> androidPackagesJson = const Value.absent(),
    int? appCount,
    int? categoryCount,
    Value<int?> scheduleDaysMask = const Value.absent(),
    Value<int?> scheduleStartMinutes = const Value.absent(),
    Value<int?> scheduleEndMinutes = const Value.absent(),
    Value<int?> appLimitMinutes = const Value.absent(),
    bool? isArchived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => BlockProfile(
    id: id ?? this.id,
    name: name ?? this.name,
    triggerType: triggerType ?? this.triggerType,
    frictionLevel: frictionLevel ?? this.frictionLevel,
    iosSelectionId: iosSelectionId.present
        ? iosSelectionId.value
        : this.iosSelectionId,
    androidPackagesJson: androidPackagesJson.present
        ? androidPackagesJson.value
        : this.androidPackagesJson,
    appCount: appCount ?? this.appCount,
    categoryCount: categoryCount ?? this.categoryCount,
    scheduleDaysMask: scheduleDaysMask.present
        ? scheduleDaysMask.value
        : this.scheduleDaysMask,
    scheduleStartMinutes: scheduleStartMinutes.present
        ? scheduleStartMinutes.value
        : this.scheduleStartMinutes,
    scheduleEndMinutes: scheduleEndMinutes.present
        ? scheduleEndMinutes.value
        : this.scheduleEndMinutes,
    appLimitMinutes: appLimitMinutes.present
        ? appLimitMinutes.value
        : this.appLimitMinutes,
    isArchived: isArchived ?? this.isArchived,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  BlockProfile copyWithCompanion(BlockProfilesCompanion data) {
    return BlockProfile(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      triggerType: data.triggerType.present
          ? data.triggerType.value
          : this.triggerType,
      frictionLevel: data.frictionLevel.present
          ? data.frictionLevel.value
          : this.frictionLevel,
      iosSelectionId: data.iosSelectionId.present
          ? data.iosSelectionId.value
          : this.iosSelectionId,
      androidPackagesJson: data.androidPackagesJson.present
          ? data.androidPackagesJson.value
          : this.androidPackagesJson,
      appCount: data.appCount.present ? data.appCount.value : this.appCount,
      categoryCount: data.categoryCount.present
          ? data.categoryCount.value
          : this.categoryCount,
      scheduleDaysMask: data.scheduleDaysMask.present
          ? data.scheduleDaysMask.value
          : this.scheduleDaysMask,
      scheduleStartMinutes: data.scheduleStartMinutes.present
          ? data.scheduleStartMinutes.value
          : this.scheduleStartMinutes,
      scheduleEndMinutes: data.scheduleEndMinutes.present
          ? data.scheduleEndMinutes.value
          : this.scheduleEndMinutes,
      appLimitMinutes: data.appLimitMinutes.present
          ? data.appLimitMinutes.value
          : this.appLimitMinutes,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BlockProfile(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('triggerType: $triggerType, ')
          ..write('frictionLevel: $frictionLevel, ')
          ..write('iosSelectionId: $iosSelectionId, ')
          ..write('androidPackagesJson: $androidPackagesJson, ')
          ..write('appCount: $appCount, ')
          ..write('categoryCount: $categoryCount, ')
          ..write('scheduleDaysMask: $scheduleDaysMask, ')
          ..write('scheduleStartMinutes: $scheduleStartMinutes, ')
          ..write('scheduleEndMinutes: $scheduleEndMinutes, ')
          ..write('appLimitMinutes: $appLimitMinutes, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    triggerType,
    frictionLevel,
    iosSelectionId,
    androidPackagesJson,
    appCount,
    categoryCount,
    scheduleDaysMask,
    scheduleStartMinutes,
    scheduleEndMinutes,
    appLimitMinutes,
    isArchived,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BlockProfile &&
          other.id == this.id &&
          other.name == this.name &&
          other.triggerType == this.triggerType &&
          other.frictionLevel == this.frictionLevel &&
          other.iosSelectionId == this.iosSelectionId &&
          other.androidPackagesJson == this.androidPackagesJson &&
          other.appCount == this.appCount &&
          other.categoryCount == this.categoryCount &&
          other.scheduleDaysMask == this.scheduleDaysMask &&
          other.scheduleStartMinutes == this.scheduleStartMinutes &&
          other.scheduleEndMinutes == this.scheduleEndMinutes &&
          other.appLimitMinutes == this.appLimitMinutes &&
          other.isArchived == this.isArchived &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BlockProfilesCompanion extends UpdateCompanion<BlockProfile> {
  final Value<int> id;
  final Value<String> name;
  final Value<TriggerType> triggerType;
  final Value<FrictionLevel> frictionLevel;
  final Value<String?> iosSelectionId;
  final Value<String?> androidPackagesJson;
  final Value<int> appCount;
  final Value<int> categoryCount;
  final Value<int?> scheduleDaysMask;
  final Value<int?> scheduleStartMinutes;
  final Value<int?> scheduleEndMinutes;
  final Value<int?> appLimitMinutes;
  final Value<bool> isArchived;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const BlockProfilesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.triggerType = const Value.absent(),
    this.frictionLevel = const Value.absent(),
    this.iosSelectionId = const Value.absent(),
    this.androidPackagesJson = const Value.absent(),
    this.appCount = const Value.absent(),
    this.categoryCount = const Value.absent(),
    this.scheduleDaysMask = const Value.absent(),
    this.scheduleStartMinutes = const Value.absent(),
    this.scheduleEndMinutes = const Value.absent(),
    this.appLimitMinutes = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  BlockProfilesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required TriggerType triggerType,
    required FrictionLevel frictionLevel,
    this.iosSelectionId = const Value.absent(),
    this.androidPackagesJson = const Value.absent(),
    this.appCount = const Value.absent(),
    this.categoryCount = const Value.absent(),
    this.scheduleDaysMask = const Value.absent(),
    this.scheduleStartMinutes = const Value.absent(),
    this.scheduleEndMinutes = const Value.absent(),
    this.appLimitMinutes = const Value.absent(),
    this.isArchived = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : name = Value(name),
       triggerType = Value(triggerType),
       frictionLevel = Value(frictionLevel),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<BlockProfile> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? triggerType,
    Expression<int>? frictionLevel,
    Expression<String>? iosSelectionId,
    Expression<String>? androidPackagesJson,
    Expression<int>? appCount,
    Expression<int>? categoryCount,
    Expression<int>? scheduleDaysMask,
    Expression<int>? scheduleStartMinutes,
    Expression<int>? scheduleEndMinutes,
    Expression<int>? appLimitMinutes,
    Expression<bool>? isArchived,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (triggerType != null) 'trigger_type': triggerType,
      if (frictionLevel != null) 'friction_level': frictionLevel,
      if (iosSelectionId != null) 'ios_selection_id': iosSelectionId,
      if (androidPackagesJson != null)
        'android_packages_json': androidPackagesJson,
      if (appCount != null) 'app_count': appCount,
      if (categoryCount != null) 'category_count': categoryCount,
      if (scheduleDaysMask != null) 'schedule_days_mask': scheduleDaysMask,
      if (scheduleStartMinutes != null)
        'schedule_start_minutes': scheduleStartMinutes,
      if (scheduleEndMinutes != null)
        'schedule_end_minutes': scheduleEndMinutes,
      if (appLimitMinutes != null) 'app_limit_minutes': appLimitMinutes,
      if (isArchived != null) 'is_archived': isArchived,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  BlockProfilesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<TriggerType>? triggerType,
    Value<FrictionLevel>? frictionLevel,
    Value<String?>? iosSelectionId,
    Value<String?>? androidPackagesJson,
    Value<int>? appCount,
    Value<int>? categoryCount,
    Value<int?>? scheduleDaysMask,
    Value<int?>? scheduleStartMinutes,
    Value<int?>? scheduleEndMinutes,
    Value<int?>? appLimitMinutes,
    Value<bool>? isArchived,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return BlockProfilesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      triggerType: triggerType ?? this.triggerType,
      frictionLevel: frictionLevel ?? this.frictionLevel,
      iosSelectionId: iosSelectionId ?? this.iosSelectionId,
      androidPackagesJson: androidPackagesJson ?? this.androidPackagesJson,
      appCount: appCount ?? this.appCount,
      categoryCount: categoryCount ?? this.categoryCount,
      scheduleDaysMask: scheduleDaysMask ?? this.scheduleDaysMask,
      scheduleStartMinutes: scheduleStartMinutes ?? this.scheduleStartMinutes,
      scheduleEndMinutes: scheduleEndMinutes ?? this.scheduleEndMinutes,
      appLimitMinutes: appLimitMinutes ?? this.appLimitMinutes,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (triggerType.present) {
      map['trigger_type'] = Variable<int>(
        $BlockProfilesTable.$convertertriggerType.toSql(triggerType.value),
      );
    }
    if (frictionLevel.present) {
      map['friction_level'] = Variable<int>(
        $BlockProfilesTable.$converterfrictionLevel.toSql(frictionLevel.value),
      );
    }
    if (iosSelectionId.present) {
      map['ios_selection_id'] = Variable<String>(iosSelectionId.value);
    }
    if (androidPackagesJson.present) {
      map['android_packages_json'] = Variable<String>(
        androidPackagesJson.value,
      );
    }
    if (appCount.present) {
      map['app_count'] = Variable<int>(appCount.value);
    }
    if (categoryCount.present) {
      map['category_count'] = Variable<int>(categoryCount.value);
    }
    if (scheduleDaysMask.present) {
      map['schedule_days_mask'] = Variable<int>(scheduleDaysMask.value);
    }
    if (scheduleStartMinutes.present) {
      map['schedule_start_minutes'] = Variable<int>(scheduleStartMinutes.value);
    }
    if (scheduleEndMinutes.present) {
      map['schedule_end_minutes'] = Variable<int>(scheduleEndMinutes.value);
    }
    if (appLimitMinutes.present) {
      map['app_limit_minutes'] = Variable<int>(appLimitMinutes.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BlockProfilesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('triggerType: $triggerType, ')
          ..write('frictionLevel: $frictionLevel, ')
          ..write('iosSelectionId: $iosSelectionId, ')
          ..write('androidPackagesJson: $androidPackagesJson, ')
          ..write('appCount: $appCount, ')
          ..write('categoryCount: $categoryCount, ')
          ..write('scheduleDaysMask: $scheduleDaysMask, ')
          ..write('scheduleStartMinutes: $scheduleStartMinutes, ')
          ..write('scheduleEndMinutes: $scheduleEndMinutes, ')
          ..write('appLimitMinutes: $appLimitMinutes, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SessionsTable extends Sessions with TableInfo<$SessionsTable, Session> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<int> profileId = GeneratedColumn<int>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES block_profiles (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<FrictionLevel, int>
  frictionLevel = GeneratedColumn<int>(
    'friction_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  ).withConverter<FrictionLevel>($SessionsTable.$converterfrictionLevel);
  @override
  late final GeneratedColumnWithTypeConverter<SessionState, int> state =
      GeneratedColumn<int>(
        'state',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<SessionState>($SessionsTable.$converterstate);
  @override
  late final GeneratedColumnWithTypeConverter<SessionEndReason?, int>
  endReason = GeneratedColumn<int>(
    'end_reason',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  ).withConverter<SessionEndReason?>($SessionsTable.$converterendReasonn);
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scheduledEndAtMeta = const VerificationMeta(
    'scheduledEndAt',
  );
  @override
  late final GeneratedColumn<DateTime> scheduledEndAt =
      GeneratedColumn<DateTime>(
        'scheduled_end_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _earlyUnlockCountMeta = const VerificationMeta(
    'earlyUnlockCount',
  );
  @override
  late final GeneratedColumn<int> earlyUnlockCount = GeneratedColumn<int>(
    'early_unlock_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    frictionLevel,
    state,
    endReason,
    startedAt,
    scheduledEndAt,
    endedAt,
    earlyUnlockCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Session> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('scheduled_end_at')) {
      context.handle(
        _scheduledEndAtMeta,
        scheduledEndAt.isAcceptableOrUnknown(
          data['scheduled_end_at']!,
          _scheduledEndAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduledEndAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    if (data.containsKey('early_unlock_count')) {
      context.handle(
        _earlyUnlockCountMeta,
        earlyUnlockCount.isAcceptableOrUnknown(
          data['early_unlock_count']!,
          _earlyUnlockCountMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Session map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Session(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}profile_id'],
      )!,
      frictionLevel: $SessionsTable.$converterfrictionLevel.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}friction_level'],
        )!,
      ),
      state: $SessionsTable.$converterstate.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}state'],
        )!,
      ),
      endReason: $SessionsTable.$converterendReasonn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}end_reason'],
        ),
      ),
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      scheduledEndAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scheduled_end_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
      earlyUnlockCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}early_unlock_count'],
      )!,
    );
  }

  @override
  $SessionsTable createAlias(String alias) {
    return $SessionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<FrictionLevel, int, int> $converterfrictionLevel =
      const EnumIndexConverter<FrictionLevel>(FrictionLevel.values);
  static JsonTypeConverter2<SessionState, int, int> $converterstate =
      const EnumIndexConverter<SessionState>(SessionState.values);
  static JsonTypeConverter2<SessionEndReason, int, int> $converterendReason =
      const EnumIndexConverter<SessionEndReason>(SessionEndReason.values);
  static JsonTypeConverter2<SessionEndReason?, int?, int?>
  $converterendReasonn = JsonTypeConverter2.asNullable($converterendReason);
}

class Session extends DataClass implements Insertable<Session> {
  final int id;
  final int profileId;

  /// Snapshot of the profile's friction at start; editing the profile must
  /// not change a running session's rules.
  final FrictionLevel frictionLevel;
  final SessionState state;
  final SessionEndReason? endReason;
  final DateTime startedAt;
  final DateTime scheduledEndAt;
  final DateTime? endedAt;
  final int earlyUnlockCount;
  const Session({
    required this.id,
    required this.profileId,
    required this.frictionLevel,
    required this.state,
    this.endReason,
    required this.startedAt,
    required this.scheduledEndAt,
    this.endedAt,
    required this.earlyUnlockCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['profile_id'] = Variable<int>(profileId);
    {
      map['friction_level'] = Variable<int>(
        $SessionsTable.$converterfrictionLevel.toSql(frictionLevel),
      );
    }
    {
      map['state'] = Variable<int>($SessionsTable.$converterstate.toSql(state));
    }
    if (!nullToAbsent || endReason != null) {
      map['end_reason'] = Variable<int>(
        $SessionsTable.$converterendReasonn.toSql(endReason),
      );
    }
    map['started_at'] = Variable<DateTime>(startedAt);
    map['scheduled_end_at'] = Variable<DateTime>(scheduledEndAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    map['early_unlock_count'] = Variable<int>(earlyUnlockCount);
    return map;
  }

  SessionsCompanion toCompanion(bool nullToAbsent) {
    return SessionsCompanion(
      id: Value(id),
      profileId: Value(profileId),
      frictionLevel: Value(frictionLevel),
      state: Value(state),
      endReason: endReason == null && nullToAbsent
          ? const Value.absent()
          : Value(endReason),
      startedAt: Value(startedAt),
      scheduledEndAt: Value(scheduledEndAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      earlyUnlockCount: Value(earlyUnlockCount),
    );
  }

  factory Session.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Session(
      id: serializer.fromJson<int>(json['id']),
      profileId: serializer.fromJson<int>(json['profileId']),
      frictionLevel: $SessionsTable.$converterfrictionLevel.fromJson(
        serializer.fromJson<int>(json['frictionLevel']),
      ),
      state: $SessionsTable.$converterstate.fromJson(
        serializer.fromJson<int>(json['state']),
      ),
      endReason: $SessionsTable.$converterendReasonn.fromJson(
        serializer.fromJson<int?>(json['endReason']),
      ),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      scheduledEndAt: serializer.fromJson<DateTime>(json['scheduledEndAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
      earlyUnlockCount: serializer.fromJson<int>(json['earlyUnlockCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'profileId': serializer.toJson<int>(profileId),
      'frictionLevel': serializer.toJson<int>(
        $SessionsTable.$converterfrictionLevel.toJson(frictionLevel),
      ),
      'state': serializer.toJson<int>(
        $SessionsTable.$converterstate.toJson(state),
      ),
      'endReason': serializer.toJson<int?>(
        $SessionsTable.$converterendReasonn.toJson(endReason),
      ),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'scheduledEndAt': serializer.toJson<DateTime>(scheduledEndAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
      'earlyUnlockCount': serializer.toJson<int>(earlyUnlockCount),
    };
  }

  Session copyWith({
    int? id,
    int? profileId,
    FrictionLevel? frictionLevel,
    SessionState? state,
    Value<SessionEndReason?> endReason = const Value.absent(),
    DateTime? startedAt,
    DateTime? scheduledEndAt,
    Value<DateTime?> endedAt = const Value.absent(),
    int? earlyUnlockCount,
  }) => Session(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    frictionLevel: frictionLevel ?? this.frictionLevel,
    state: state ?? this.state,
    endReason: endReason.present ? endReason.value : this.endReason,
    startedAt: startedAt ?? this.startedAt,
    scheduledEndAt: scheduledEndAt ?? this.scheduledEndAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
    earlyUnlockCount: earlyUnlockCount ?? this.earlyUnlockCount,
  );
  Session copyWithCompanion(SessionsCompanion data) {
    return Session(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      frictionLevel: data.frictionLevel.present
          ? data.frictionLevel.value
          : this.frictionLevel,
      state: data.state.present ? data.state.value : this.state,
      endReason: data.endReason.present ? data.endReason.value : this.endReason,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      scheduledEndAt: data.scheduledEndAt.present
          ? data.scheduledEndAt.value
          : this.scheduledEndAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      earlyUnlockCount: data.earlyUnlockCount.present
          ? data.earlyUnlockCount.value
          : this.earlyUnlockCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Session(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('frictionLevel: $frictionLevel, ')
          ..write('state: $state, ')
          ..write('endReason: $endReason, ')
          ..write('startedAt: $startedAt, ')
          ..write('scheduledEndAt: $scheduledEndAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('earlyUnlockCount: $earlyUnlockCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    profileId,
    frictionLevel,
    state,
    endReason,
    startedAt,
    scheduledEndAt,
    endedAt,
    earlyUnlockCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Session &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.frictionLevel == this.frictionLevel &&
          other.state == this.state &&
          other.endReason == this.endReason &&
          other.startedAt == this.startedAt &&
          other.scheduledEndAt == this.scheduledEndAt &&
          other.endedAt == this.endedAt &&
          other.earlyUnlockCount == this.earlyUnlockCount);
}

class SessionsCompanion extends UpdateCompanion<Session> {
  final Value<int> id;
  final Value<int> profileId;
  final Value<FrictionLevel> frictionLevel;
  final Value<SessionState> state;
  final Value<SessionEndReason?> endReason;
  final Value<DateTime> startedAt;
  final Value<DateTime> scheduledEndAt;
  final Value<DateTime?> endedAt;
  final Value<int> earlyUnlockCount;
  const SessionsCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.frictionLevel = const Value.absent(),
    this.state = const Value.absent(),
    this.endReason = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.scheduledEndAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.earlyUnlockCount = const Value.absent(),
  });
  SessionsCompanion.insert({
    this.id = const Value.absent(),
    required int profileId,
    required FrictionLevel frictionLevel,
    required SessionState state,
    this.endReason = const Value.absent(),
    required DateTime startedAt,
    required DateTime scheduledEndAt,
    this.endedAt = const Value.absent(),
    this.earlyUnlockCount = const Value.absent(),
  }) : profileId = Value(profileId),
       frictionLevel = Value(frictionLevel),
       state = Value(state),
       startedAt = Value(startedAt),
       scheduledEndAt = Value(scheduledEndAt);
  static Insertable<Session> custom({
    Expression<int>? id,
    Expression<int>? profileId,
    Expression<int>? frictionLevel,
    Expression<int>? state,
    Expression<int>? endReason,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? scheduledEndAt,
    Expression<DateTime>? endedAt,
    Expression<int>? earlyUnlockCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (frictionLevel != null) 'friction_level': frictionLevel,
      if (state != null) 'state': state,
      if (endReason != null) 'end_reason': endReason,
      if (startedAt != null) 'started_at': startedAt,
      if (scheduledEndAt != null) 'scheduled_end_at': scheduledEndAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (earlyUnlockCount != null) 'early_unlock_count': earlyUnlockCount,
    });
  }

  SessionsCompanion copyWith({
    Value<int>? id,
    Value<int>? profileId,
    Value<FrictionLevel>? frictionLevel,
    Value<SessionState>? state,
    Value<SessionEndReason?>? endReason,
    Value<DateTime>? startedAt,
    Value<DateTime>? scheduledEndAt,
    Value<DateTime?>? endedAt,
    Value<int>? earlyUnlockCount,
  }) {
    return SessionsCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      frictionLevel: frictionLevel ?? this.frictionLevel,
      state: state ?? this.state,
      endReason: endReason ?? this.endReason,
      startedAt: startedAt ?? this.startedAt,
      scheduledEndAt: scheduledEndAt ?? this.scheduledEndAt,
      endedAt: endedAt ?? this.endedAt,
      earlyUnlockCount: earlyUnlockCount ?? this.earlyUnlockCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<int>(profileId.value);
    }
    if (frictionLevel.present) {
      map['friction_level'] = Variable<int>(
        $SessionsTable.$converterfrictionLevel.toSql(frictionLevel.value),
      );
    }
    if (state.present) {
      map['state'] = Variable<int>(
        $SessionsTable.$converterstate.toSql(state.value),
      );
    }
    if (endReason.present) {
      map['end_reason'] = Variable<int>(
        $SessionsTable.$converterendReasonn.toSql(endReason.value),
      );
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (scheduledEndAt.present) {
      map['scheduled_end_at'] = Variable<DateTime>(scheduledEndAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (earlyUnlockCount.present) {
      map['early_unlock_count'] = Variable<int>(earlyUnlockCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionsCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('frictionLevel: $frictionLevel, ')
          ..write('state: $state, ')
          ..write('endReason: $endReason, ')
          ..write('startedAt: $startedAt, ')
          ..write('scheduledEndAt: $scheduledEndAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('earlyUnlockCount: $earlyUnlockCount')
          ..write(')'))
        .toString();
  }
}

class $DailyStatsTable extends DailyStats
    with TableInfo<$DailyStatsTable, DailyStat> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyStatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dayMeta = const VerificationMeta('day');
  @override
  late final GeneratedColumn<String> day = GeneratedColumn<String>(
    'day',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pickupsBlockedMeta = const VerificationMeta(
    'pickupsBlocked',
  );
  @override
  late final GeneratedColumn<int> pickupsBlocked = GeneratedColumn<int>(
    'pickups_blocked',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _secondsHeldMeta = const VerificationMeta(
    'secondsHeld',
  );
  @override
  late final GeneratedColumn<int> secondsHeld = GeneratedColumn<int>(
    'seconds_held',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _sessionsCompletedMeta = const VerificationMeta(
    'sessionsCompleted',
  );
  @override
  late final GeneratedColumn<int> sessionsCompleted = GeneratedColumn<int>(
    'sessions_completed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _earlyUnlocksMeta = const VerificationMeta(
    'earlyUnlocks',
  );
  @override
  late final GeneratedColumn<int> earlyUnlocks = GeneratedColumn<int>(
    'early_unlocks',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    day,
    pickupsBlocked,
    secondsHeld,
    sessionsCompleted,
    earlyUnlocks,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_stats';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyStat> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('day')) {
      context.handle(
        _dayMeta,
        day.isAcceptableOrUnknown(data['day']!, _dayMeta),
      );
    } else if (isInserting) {
      context.missing(_dayMeta);
    }
    if (data.containsKey('pickups_blocked')) {
      context.handle(
        _pickupsBlockedMeta,
        pickupsBlocked.isAcceptableOrUnknown(
          data['pickups_blocked']!,
          _pickupsBlockedMeta,
        ),
      );
    }
    if (data.containsKey('seconds_held')) {
      context.handle(
        _secondsHeldMeta,
        secondsHeld.isAcceptableOrUnknown(
          data['seconds_held']!,
          _secondsHeldMeta,
        ),
      );
    }
    if (data.containsKey('sessions_completed')) {
      context.handle(
        _sessionsCompletedMeta,
        sessionsCompleted.isAcceptableOrUnknown(
          data['sessions_completed']!,
          _sessionsCompletedMeta,
        ),
      );
    }
    if (data.containsKey('early_unlocks')) {
      context.handle(
        _earlyUnlocksMeta,
        earlyUnlocks.isAcceptableOrUnknown(
          data['early_unlocks']!,
          _earlyUnlocksMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {day};
  @override
  DailyStat map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyStat(
      day: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}day'],
      )!,
      pickupsBlocked: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pickups_blocked'],
      )!,
      secondsHeld: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}seconds_held'],
      )!,
      sessionsCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sessions_completed'],
      )!,
      earlyUnlocks: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}early_unlocks'],
      )!,
    );
  }

  @override
  $DailyStatsTable createAlias(String alias) {
    return $DailyStatsTable(attachedDatabase, alias);
  }
}

class DailyStat extends DataClass implements Insertable<DailyStat> {
  final String day;
  final int pickupsBlocked;

  /// Held time in seconds. "Minutes saved" is derived; never invented.
  final int secondsHeld;
  final int sessionsCompleted;
  final int earlyUnlocks;
  const DailyStat({
    required this.day,
    required this.pickupsBlocked,
    required this.secondsHeld,
    required this.sessionsCompleted,
    required this.earlyUnlocks,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['day'] = Variable<String>(day);
    map['pickups_blocked'] = Variable<int>(pickupsBlocked);
    map['seconds_held'] = Variable<int>(secondsHeld);
    map['sessions_completed'] = Variable<int>(sessionsCompleted);
    map['early_unlocks'] = Variable<int>(earlyUnlocks);
    return map;
  }

  DailyStatsCompanion toCompanion(bool nullToAbsent) {
    return DailyStatsCompanion(
      day: Value(day),
      pickupsBlocked: Value(pickupsBlocked),
      secondsHeld: Value(secondsHeld),
      sessionsCompleted: Value(sessionsCompleted),
      earlyUnlocks: Value(earlyUnlocks),
    );
  }

  factory DailyStat.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyStat(
      day: serializer.fromJson<String>(json['day']),
      pickupsBlocked: serializer.fromJson<int>(json['pickupsBlocked']),
      secondsHeld: serializer.fromJson<int>(json['secondsHeld']),
      sessionsCompleted: serializer.fromJson<int>(json['sessionsCompleted']),
      earlyUnlocks: serializer.fromJson<int>(json['earlyUnlocks']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'day': serializer.toJson<String>(day),
      'pickupsBlocked': serializer.toJson<int>(pickupsBlocked),
      'secondsHeld': serializer.toJson<int>(secondsHeld),
      'sessionsCompleted': serializer.toJson<int>(sessionsCompleted),
      'earlyUnlocks': serializer.toJson<int>(earlyUnlocks),
    };
  }

  DailyStat copyWith({
    String? day,
    int? pickupsBlocked,
    int? secondsHeld,
    int? sessionsCompleted,
    int? earlyUnlocks,
  }) => DailyStat(
    day: day ?? this.day,
    pickupsBlocked: pickupsBlocked ?? this.pickupsBlocked,
    secondsHeld: secondsHeld ?? this.secondsHeld,
    sessionsCompleted: sessionsCompleted ?? this.sessionsCompleted,
    earlyUnlocks: earlyUnlocks ?? this.earlyUnlocks,
  );
  DailyStat copyWithCompanion(DailyStatsCompanion data) {
    return DailyStat(
      day: data.day.present ? data.day.value : this.day,
      pickupsBlocked: data.pickupsBlocked.present
          ? data.pickupsBlocked.value
          : this.pickupsBlocked,
      secondsHeld: data.secondsHeld.present
          ? data.secondsHeld.value
          : this.secondsHeld,
      sessionsCompleted: data.sessionsCompleted.present
          ? data.sessionsCompleted.value
          : this.sessionsCompleted,
      earlyUnlocks: data.earlyUnlocks.present
          ? data.earlyUnlocks.value
          : this.earlyUnlocks,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyStat(')
          ..write('day: $day, ')
          ..write('pickupsBlocked: $pickupsBlocked, ')
          ..write('secondsHeld: $secondsHeld, ')
          ..write('sessionsCompleted: $sessionsCompleted, ')
          ..write('earlyUnlocks: $earlyUnlocks')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    day,
    pickupsBlocked,
    secondsHeld,
    sessionsCompleted,
    earlyUnlocks,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyStat &&
          other.day == this.day &&
          other.pickupsBlocked == this.pickupsBlocked &&
          other.secondsHeld == this.secondsHeld &&
          other.sessionsCompleted == this.sessionsCompleted &&
          other.earlyUnlocks == this.earlyUnlocks);
}

class DailyStatsCompanion extends UpdateCompanion<DailyStat> {
  final Value<String> day;
  final Value<int> pickupsBlocked;
  final Value<int> secondsHeld;
  final Value<int> sessionsCompleted;
  final Value<int> earlyUnlocks;
  final Value<int> rowid;
  const DailyStatsCompanion({
    this.day = const Value.absent(),
    this.pickupsBlocked = const Value.absent(),
    this.secondsHeld = const Value.absent(),
    this.sessionsCompleted = const Value.absent(),
    this.earlyUnlocks = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyStatsCompanion.insert({
    required String day,
    this.pickupsBlocked = const Value.absent(),
    this.secondsHeld = const Value.absent(),
    this.sessionsCompleted = const Value.absent(),
    this.earlyUnlocks = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : day = Value(day);
  static Insertable<DailyStat> custom({
    Expression<String>? day,
    Expression<int>? pickupsBlocked,
    Expression<int>? secondsHeld,
    Expression<int>? sessionsCompleted,
    Expression<int>? earlyUnlocks,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (day != null) 'day': day,
      if (pickupsBlocked != null) 'pickups_blocked': pickupsBlocked,
      if (secondsHeld != null) 'seconds_held': secondsHeld,
      if (sessionsCompleted != null) 'sessions_completed': sessionsCompleted,
      if (earlyUnlocks != null) 'early_unlocks': earlyUnlocks,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyStatsCompanion copyWith({
    Value<String>? day,
    Value<int>? pickupsBlocked,
    Value<int>? secondsHeld,
    Value<int>? sessionsCompleted,
    Value<int>? earlyUnlocks,
    Value<int>? rowid,
  }) {
    return DailyStatsCompanion(
      day: day ?? this.day,
      pickupsBlocked: pickupsBlocked ?? this.pickupsBlocked,
      secondsHeld: secondsHeld ?? this.secondsHeld,
      sessionsCompleted: sessionsCompleted ?? this.sessionsCompleted,
      earlyUnlocks: earlyUnlocks ?? this.earlyUnlocks,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (day.present) {
      map['day'] = Variable<String>(day.value);
    }
    if (pickupsBlocked.present) {
      map['pickups_blocked'] = Variable<int>(pickupsBlocked.value);
    }
    if (secondsHeld.present) {
      map['seconds_held'] = Variable<int>(secondsHeld.value);
    }
    if (sessionsCompleted.present) {
      map['sessions_completed'] = Variable<int>(sessionsCompleted.value);
    }
    if (earlyUnlocks.present) {
      map['early_unlocks'] = Variable<int>(earlyUnlocks.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyStatsCompanion(')
          ..write('day: $day, ')
          ..write('pickupsBlocked: $pickupsBlocked, ')
          ..write('secondsHeld: $secondsHeld, ')
          ..write('sessionsCompleted: $sessionsCompleted, ')
          ..write('earlyUnlocks: $earlyUnlocks, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StreaksTable extends Streaks with TableInfo<$StreaksTable, Streak> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StreaksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currentDaysMeta = const VerificationMeta(
    'currentDays',
  );
  @override
  late final GeneratedColumn<int> currentDays = GeneratedColumn<int>(
    'current_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _longestDaysMeta = const VerificationMeta(
    'longestDays',
  );
  @override
  late final GeneratedColumn<int> longestDays = GeneratedColumn<int>(
    'longest_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastHeldDayMeta = const VerificationMeta(
    'lastHeldDay',
  );
  @override
  late final GeneratedColumn<String> lastHeldDay = GeneratedColumn<String>(
    'last_held_day',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    currentDays,
    longestDays,
    lastHeldDay,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'streaks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Streak> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('current_days')) {
      context.handle(
        _currentDaysMeta,
        currentDays.isAcceptableOrUnknown(
          data['current_days']!,
          _currentDaysMeta,
        ),
      );
    }
    if (data.containsKey('longest_days')) {
      context.handle(
        _longestDaysMeta,
        longestDays.isAcceptableOrUnknown(
          data['longest_days']!,
          _longestDaysMeta,
        ),
      );
    }
    if (data.containsKey('last_held_day')) {
      context.handle(
        _lastHeldDayMeta,
        lastHeldDay.isAcceptableOrUnknown(
          data['last_held_day']!,
          _lastHeldDayMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Streak map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Streak(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      currentDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_days'],
      )!,
      longestDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}longest_days'],
      )!,
      lastHeldDay: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_held_day'],
      ),
    );
  }

  @override
  $StreaksTable createAlias(String alias) {
    return $StreaksTable(attachedDatabase, alias);
  }
}

class Streak extends DataClass implements Insertable<Streak> {
  final int id;
  final int currentDays;
  final int longestDays;

  /// Last day ("yyyy-MM-dd") that counted toward the streak.
  final String? lastHeldDay;
  const Streak({
    required this.id,
    required this.currentDays,
    required this.longestDays,
    this.lastHeldDay,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['current_days'] = Variable<int>(currentDays);
    map['longest_days'] = Variable<int>(longestDays);
    if (!nullToAbsent || lastHeldDay != null) {
      map['last_held_day'] = Variable<String>(lastHeldDay);
    }
    return map;
  }

  StreaksCompanion toCompanion(bool nullToAbsent) {
    return StreaksCompanion(
      id: Value(id),
      currentDays: Value(currentDays),
      longestDays: Value(longestDays),
      lastHeldDay: lastHeldDay == null && nullToAbsent
          ? const Value.absent()
          : Value(lastHeldDay),
    );
  }

  factory Streak.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Streak(
      id: serializer.fromJson<int>(json['id']),
      currentDays: serializer.fromJson<int>(json['currentDays']),
      longestDays: serializer.fromJson<int>(json['longestDays']),
      lastHeldDay: serializer.fromJson<String?>(json['lastHeldDay']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'currentDays': serializer.toJson<int>(currentDays),
      'longestDays': serializer.toJson<int>(longestDays),
      'lastHeldDay': serializer.toJson<String?>(lastHeldDay),
    };
  }

  Streak copyWith({
    int? id,
    int? currentDays,
    int? longestDays,
    Value<String?> lastHeldDay = const Value.absent(),
  }) => Streak(
    id: id ?? this.id,
    currentDays: currentDays ?? this.currentDays,
    longestDays: longestDays ?? this.longestDays,
    lastHeldDay: lastHeldDay.present ? lastHeldDay.value : this.lastHeldDay,
  );
  Streak copyWithCompanion(StreaksCompanion data) {
    return Streak(
      id: data.id.present ? data.id.value : this.id,
      currentDays: data.currentDays.present
          ? data.currentDays.value
          : this.currentDays,
      longestDays: data.longestDays.present
          ? data.longestDays.value
          : this.longestDays,
      lastHeldDay: data.lastHeldDay.present
          ? data.lastHeldDay.value
          : this.lastHeldDay,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Streak(')
          ..write('id: $id, ')
          ..write('currentDays: $currentDays, ')
          ..write('longestDays: $longestDays, ')
          ..write('lastHeldDay: $lastHeldDay')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, currentDays, longestDays, lastHeldDay);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Streak &&
          other.id == this.id &&
          other.currentDays == this.currentDays &&
          other.longestDays == this.longestDays &&
          other.lastHeldDay == this.lastHeldDay);
}

class StreaksCompanion extends UpdateCompanion<Streak> {
  final Value<int> id;
  final Value<int> currentDays;
  final Value<int> longestDays;
  final Value<String?> lastHeldDay;
  const StreaksCompanion({
    this.id = const Value.absent(),
    this.currentDays = const Value.absent(),
    this.longestDays = const Value.absent(),
    this.lastHeldDay = const Value.absent(),
  });
  StreaksCompanion.insert({
    this.id = const Value.absent(),
    this.currentDays = const Value.absent(),
    this.longestDays = const Value.absent(),
    this.lastHeldDay = const Value.absent(),
  });
  static Insertable<Streak> custom({
    Expression<int>? id,
    Expression<int>? currentDays,
    Expression<int>? longestDays,
    Expression<String>? lastHeldDay,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (currentDays != null) 'current_days': currentDays,
      if (longestDays != null) 'longest_days': longestDays,
      if (lastHeldDay != null) 'last_held_day': lastHeldDay,
    });
  }

  StreaksCompanion copyWith({
    Value<int>? id,
    Value<int>? currentDays,
    Value<int>? longestDays,
    Value<String?>? lastHeldDay,
  }) {
    return StreaksCompanion(
      id: id ?? this.id,
      currentDays: currentDays ?? this.currentDays,
      longestDays: longestDays ?? this.longestDays,
      lastHeldDay: lastHeldDay ?? this.lastHeldDay,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (currentDays.present) {
      map['current_days'] = Variable<int>(currentDays.value);
    }
    if (longestDays.present) {
      map['longest_days'] = Variable<int>(longestDays.value);
    }
    if (lastHeldDay.present) {
      map['last_held_day'] = Variable<String>(lastHeldDay.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StreaksCompanion(')
          ..write('id: $id, ')
          ..write('currentDays: $currentDays, ')
          ..write('longestDays: $longestDays, ')
          ..write('lastHeldDay: $lastHeldDay')
          ..write(')'))
        .toString();
  }
}

abstract class _$KedgeDatabase extends GeneratedDatabase {
  _$KedgeDatabase(QueryExecutor e) : super(e);
  $KedgeDatabaseManager get managers => $KedgeDatabaseManager(this);
  late final $BlockProfilesTable blockProfiles = $BlockProfilesTable(this);
  late final $SessionsTable sessions = $SessionsTable(this);
  late final $DailyStatsTable dailyStats = $DailyStatsTable(this);
  late final $StreaksTable streaks = $StreaksTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    blockProfiles,
    sessions,
    dailyStats,
    streaks,
  ];
}

typedef $$BlockProfilesTableCreateCompanionBuilder =
    BlockProfilesCompanion Function({
      Value<int> id,
      required String name,
      required TriggerType triggerType,
      required FrictionLevel frictionLevel,
      Value<String?> iosSelectionId,
      Value<String?> androidPackagesJson,
      Value<int> appCount,
      Value<int> categoryCount,
      Value<int?> scheduleDaysMask,
      Value<int?> scheduleStartMinutes,
      Value<int?> scheduleEndMinutes,
      Value<int?> appLimitMinutes,
      Value<bool> isArchived,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$BlockProfilesTableUpdateCompanionBuilder =
    BlockProfilesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<TriggerType> triggerType,
      Value<FrictionLevel> frictionLevel,
      Value<String?> iosSelectionId,
      Value<String?> androidPackagesJson,
      Value<int> appCount,
      Value<int> categoryCount,
      Value<int?> scheduleDaysMask,
      Value<int?> scheduleStartMinutes,
      Value<int?> scheduleEndMinutes,
      Value<int?> appLimitMinutes,
      Value<bool> isArchived,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$BlockProfilesTableReferences
    extends BaseReferences<_$KedgeDatabase, $BlockProfilesTable, BlockProfile> {
  $$BlockProfilesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$SessionsTable, List<Session>> _sessionsRefsTable(
    _$KedgeDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.sessions,
    aliasName: 'block_profiles__id__sessions__profile_id',
  );

  $$SessionsTableProcessedTableManager get sessionsRefs {
    final manager = $$SessionsTableTableManager(
      $_db,
      $_db.sessions,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_sessionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BlockProfilesTableFilterComposer
    extends Composer<_$KedgeDatabase, $BlockProfilesTable> {
  $$BlockProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TriggerType, TriggerType, int>
  get triggerType => $composableBuilder(
    column: $table.triggerType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<FrictionLevel, FrictionLevel, int>
  get frictionLevel => $composableBuilder(
    column: $table.frictionLevel,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get iosSelectionId => $composableBuilder(
    column: $table.iosSelectionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get androidPackagesJson => $composableBuilder(
    column: $table.androidPackagesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get appCount => $composableBuilder(
    column: $table.appCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get categoryCount => $composableBuilder(
    column: $table.categoryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scheduleDaysMask => $composableBuilder(
    column: $table.scheduleDaysMask,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scheduleStartMinutes => $composableBuilder(
    column: $table.scheduleStartMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scheduleEndMinutes => $composableBuilder(
    column: $table.scheduleEndMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get appLimitMinutes => $composableBuilder(
    column: $table.appLimitMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> sessionsRefs(
    Expression<bool> Function($$SessionsTableFilterComposer f) f,
  ) {
    final $$SessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableFilterComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BlockProfilesTableOrderingComposer
    extends Composer<_$KedgeDatabase, $BlockProfilesTable> {
  $$BlockProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get triggerType => $composableBuilder(
    column: $table.triggerType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get frictionLevel => $composableBuilder(
    column: $table.frictionLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iosSelectionId => $composableBuilder(
    column: $table.iosSelectionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get androidPackagesJson => $composableBuilder(
    column: $table.androidPackagesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get appCount => $composableBuilder(
    column: $table.appCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get categoryCount => $composableBuilder(
    column: $table.categoryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scheduleDaysMask => $composableBuilder(
    column: $table.scheduleDaysMask,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scheduleStartMinutes => $composableBuilder(
    column: $table.scheduleStartMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scheduleEndMinutes => $composableBuilder(
    column: $table.scheduleEndMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get appLimitMinutes => $composableBuilder(
    column: $table.appLimitMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BlockProfilesTableAnnotationComposer
    extends Composer<_$KedgeDatabase, $BlockProfilesTable> {
  $$BlockProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TriggerType, int> get triggerType =>
      $composableBuilder(
        column: $table.triggerType,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<FrictionLevel, int> get frictionLevel =>
      $composableBuilder(
        column: $table.frictionLevel,
        builder: (column) => column,
      );

  GeneratedColumn<String> get iosSelectionId => $composableBuilder(
    column: $table.iosSelectionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get androidPackagesJson => $composableBuilder(
    column: $table.androidPackagesJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get appCount =>
      $composableBuilder(column: $table.appCount, builder: (column) => column);

  GeneratedColumn<int> get categoryCount => $composableBuilder(
    column: $table.categoryCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get scheduleDaysMask => $composableBuilder(
    column: $table.scheduleDaysMask,
    builder: (column) => column,
  );

  GeneratedColumn<int> get scheduleStartMinutes => $composableBuilder(
    column: $table.scheduleStartMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get scheduleEndMinutes => $composableBuilder(
    column: $table.scheduleEndMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get appLimitMinutes => $composableBuilder(
    column: $table.appLimitMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> sessionsRefs<T extends Object>(
    Expression<T> Function($$SessionsTableAnnotationComposer a) f,
  ) {
    final $$SessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BlockProfilesTableTableManager
    extends
        RootTableManager<
          _$KedgeDatabase,
          $BlockProfilesTable,
          BlockProfile,
          $$BlockProfilesTableFilterComposer,
          $$BlockProfilesTableOrderingComposer,
          $$BlockProfilesTableAnnotationComposer,
          $$BlockProfilesTableCreateCompanionBuilder,
          $$BlockProfilesTableUpdateCompanionBuilder,
          (BlockProfile, $$BlockProfilesTableReferences),
          BlockProfile,
          PrefetchHooks Function({bool sessionsRefs})
        > {
  $$BlockProfilesTableTableManager(
    _$KedgeDatabase db,
    $BlockProfilesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BlockProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BlockProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BlockProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<TriggerType> triggerType = const Value.absent(),
                Value<FrictionLevel> frictionLevel = const Value.absent(),
                Value<String?> iosSelectionId = const Value.absent(),
                Value<String?> androidPackagesJson = const Value.absent(),
                Value<int> appCount = const Value.absent(),
                Value<int> categoryCount = const Value.absent(),
                Value<int?> scheduleDaysMask = const Value.absent(),
                Value<int?> scheduleStartMinutes = const Value.absent(),
                Value<int?> scheduleEndMinutes = const Value.absent(),
                Value<int?> appLimitMinutes = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => BlockProfilesCompanion(
                id: id,
                name: name,
                triggerType: triggerType,
                frictionLevel: frictionLevel,
                iosSelectionId: iosSelectionId,
                androidPackagesJson: androidPackagesJson,
                appCount: appCount,
                categoryCount: categoryCount,
                scheduleDaysMask: scheduleDaysMask,
                scheduleStartMinutes: scheduleStartMinutes,
                scheduleEndMinutes: scheduleEndMinutes,
                appLimitMinutes: appLimitMinutes,
                isArchived: isArchived,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required TriggerType triggerType,
                required FrictionLevel frictionLevel,
                Value<String?> iosSelectionId = const Value.absent(),
                Value<String?> androidPackagesJson = const Value.absent(),
                Value<int> appCount = const Value.absent(),
                Value<int> categoryCount = const Value.absent(),
                Value<int?> scheduleDaysMask = const Value.absent(),
                Value<int?> scheduleStartMinutes = const Value.absent(),
                Value<int?> scheduleEndMinutes = const Value.absent(),
                Value<int?> appLimitMinutes = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => BlockProfilesCompanion.insert(
                id: id,
                name: name,
                triggerType: triggerType,
                frictionLevel: frictionLevel,
                iosSelectionId: iosSelectionId,
                androidPackagesJson: androidPackagesJson,
                appCount: appCount,
                categoryCount: categoryCount,
                scheduleDaysMask: scheduleDaysMask,
                scheduleStartMinutes: scheduleStartMinutes,
                scheduleEndMinutes: scheduleEndMinutes,
                appLimitMinutes: appLimitMinutes,
                isArchived: isArchived,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BlockProfilesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (sessionsRefs) db.sessions],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (sessionsRefs)
                    await $_getPrefetchedData<
                      BlockProfile,
                      $BlockProfilesTable,
                      Session
                    >(
                      currentTable: table,
                      referencedTable: $$BlockProfilesTableReferences
                          ._sessionsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$BlockProfilesTableReferences(
                            db,
                            table,
                            p0,
                          ).sessionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.profileId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$BlockProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$KedgeDatabase,
      $BlockProfilesTable,
      BlockProfile,
      $$BlockProfilesTableFilterComposer,
      $$BlockProfilesTableOrderingComposer,
      $$BlockProfilesTableAnnotationComposer,
      $$BlockProfilesTableCreateCompanionBuilder,
      $$BlockProfilesTableUpdateCompanionBuilder,
      (BlockProfile, $$BlockProfilesTableReferences),
      BlockProfile,
      PrefetchHooks Function({bool sessionsRefs})
    >;
typedef $$SessionsTableCreateCompanionBuilder =
    SessionsCompanion Function({
      Value<int> id,
      required int profileId,
      required FrictionLevel frictionLevel,
      required SessionState state,
      Value<SessionEndReason?> endReason,
      required DateTime startedAt,
      required DateTime scheduledEndAt,
      Value<DateTime?> endedAt,
      Value<int> earlyUnlockCount,
    });
typedef $$SessionsTableUpdateCompanionBuilder =
    SessionsCompanion Function({
      Value<int> id,
      Value<int> profileId,
      Value<FrictionLevel> frictionLevel,
      Value<SessionState> state,
      Value<SessionEndReason?> endReason,
      Value<DateTime> startedAt,
      Value<DateTime> scheduledEndAt,
      Value<DateTime?> endedAt,
      Value<int> earlyUnlockCount,
    });

final class $$SessionsTableReferences
    extends BaseReferences<_$KedgeDatabase, $SessionsTable, Session> {
  $$SessionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BlockProfilesTable _profileIdTable(_$KedgeDatabase db) =>
      db.blockProfiles.createAlias('sessions__profile_id__block_profiles__id');

  $$BlockProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<int>('profile_id')!;

    final manager = $$BlockProfilesTableTableManager(
      $_db,
      $_db.blockProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SessionsTableFilterComposer
    extends Composer<_$KedgeDatabase, $SessionsTable> {
  $$SessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<FrictionLevel, FrictionLevel, int>
  get frictionLevel => $composableBuilder(
    column: $table.frictionLevel,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<SessionState, SessionState, int> get state =>
      $composableBuilder(
        column: $table.state,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<SessionEndReason?, SessionEndReason, int>
  get endReason => $composableBuilder(
    column: $table.endReason,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scheduledEndAt => $composableBuilder(
    column: $table.scheduledEndAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get earlyUnlockCount => $composableBuilder(
    column: $table.earlyUnlockCount,
    builder: (column) => ColumnFilters(column),
  );

  $$BlockProfilesTableFilterComposer get profileId {
    final $$BlockProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.blockProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BlockProfilesTableFilterComposer(
            $db: $db,
            $table: $db.blockProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SessionsTableOrderingComposer
    extends Composer<_$KedgeDatabase, $SessionsTable> {
  $$SessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get frictionLevel => $composableBuilder(
    column: $table.frictionLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endReason => $composableBuilder(
    column: $table.endReason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scheduledEndAt => $composableBuilder(
    column: $table.scheduledEndAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get earlyUnlockCount => $composableBuilder(
    column: $table.earlyUnlockCount,
    builder: (column) => ColumnOrderings(column),
  );

  $$BlockProfilesTableOrderingComposer get profileId {
    final $$BlockProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.blockProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BlockProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.blockProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SessionsTableAnnotationComposer
    extends Composer<_$KedgeDatabase, $SessionsTable> {
  $$SessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<FrictionLevel, int> get frictionLevel =>
      $composableBuilder(
        column: $table.frictionLevel,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<SessionState, int> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SessionEndReason?, int> get endReason =>
      $composableBuilder(column: $table.endReason, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get scheduledEndAt => $composableBuilder(
    column: $table.scheduledEndAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<int> get earlyUnlockCount => $composableBuilder(
    column: $table.earlyUnlockCount,
    builder: (column) => column,
  );

  $$BlockProfilesTableAnnotationComposer get profileId {
    final $$BlockProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.blockProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BlockProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.blockProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SessionsTableTableManager
    extends
        RootTableManager<
          _$KedgeDatabase,
          $SessionsTable,
          Session,
          $$SessionsTableFilterComposer,
          $$SessionsTableOrderingComposer,
          $$SessionsTableAnnotationComposer,
          $$SessionsTableCreateCompanionBuilder,
          $$SessionsTableUpdateCompanionBuilder,
          (Session, $$SessionsTableReferences),
          Session,
          PrefetchHooks Function({bool profileId})
        > {
  $$SessionsTableTableManager(_$KedgeDatabase db, $SessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> profileId = const Value.absent(),
                Value<FrictionLevel> frictionLevel = const Value.absent(),
                Value<SessionState> state = const Value.absent(),
                Value<SessionEndReason?> endReason = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime> scheduledEndAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                Value<int> earlyUnlockCount = const Value.absent(),
              }) => SessionsCompanion(
                id: id,
                profileId: profileId,
                frictionLevel: frictionLevel,
                state: state,
                endReason: endReason,
                startedAt: startedAt,
                scheduledEndAt: scheduledEndAt,
                endedAt: endedAt,
                earlyUnlockCount: earlyUnlockCount,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int profileId,
                required FrictionLevel frictionLevel,
                required SessionState state,
                Value<SessionEndReason?> endReason = const Value.absent(),
                required DateTime startedAt,
                required DateTime scheduledEndAt,
                Value<DateTime?> endedAt = const Value.absent(),
                Value<int> earlyUnlockCount = const Value.absent(),
              }) => SessionsCompanion.insert(
                id: id,
                profileId: profileId,
                frictionLevel: frictionLevel,
                state: state,
                endReason: endReason,
                startedAt: startedAt,
                scheduledEndAt: scheduledEndAt,
                endedAt: endedAt,
                earlyUnlockCount: earlyUnlockCount,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (profileId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.profileId,
                                referencedTable: $$SessionsTableReferences
                                    ._profileIdTable(db),
                                referencedColumn: $$SessionsTableReferences
                                    ._profileIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$KedgeDatabase,
      $SessionsTable,
      Session,
      $$SessionsTableFilterComposer,
      $$SessionsTableOrderingComposer,
      $$SessionsTableAnnotationComposer,
      $$SessionsTableCreateCompanionBuilder,
      $$SessionsTableUpdateCompanionBuilder,
      (Session, $$SessionsTableReferences),
      Session,
      PrefetchHooks Function({bool profileId})
    >;
typedef $$DailyStatsTableCreateCompanionBuilder =
    DailyStatsCompanion Function({
      required String day,
      Value<int> pickupsBlocked,
      Value<int> secondsHeld,
      Value<int> sessionsCompleted,
      Value<int> earlyUnlocks,
      Value<int> rowid,
    });
typedef $$DailyStatsTableUpdateCompanionBuilder =
    DailyStatsCompanion Function({
      Value<String> day,
      Value<int> pickupsBlocked,
      Value<int> secondsHeld,
      Value<int> sessionsCompleted,
      Value<int> earlyUnlocks,
      Value<int> rowid,
    });

class $$DailyStatsTableFilterComposer
    extends Composer<_$KedgeDatabase, $DailyStatsTable> {
  $$DailyStatsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pickupsBlocked => $composableBuilder(
    column: $table.pickupsBlocked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get secondsHeld => $composableBuilder(
    column: $table.secondsHeld,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sessionsCompleted => $composableBuilder(
    column: $table.sessionsCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get earlyUnlocks => $composableBuilder(
    column: $table.earlyUnlocks,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyStatsTableOrderingComposer
    extends Composer<_$KedgeDatabase, $DailyStatsTable> {
  $$DailyStatsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pickupsBlocked => $composableBuilder(
    column: $table.pickupsBlocked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get secondsHeld => $composableBuilder(
    column: $table.secondsHeld,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sessionsCompleted => $composableBuilder(
    column: $table.sessionsCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get earlyUnlocks => $composableBuilder(
    column: $table.earlyUnlocks,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyStatsTableAnnotationComposer
    extends Composer<_$KedgeDatabase, $DailyStatsTable> {
  $$DailyStatsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get day =>
      $composableBuilder(column: $table.day, builder: (column) => column);

  GeneratedColumn<int> get pickupsBlocked => $composableBuilder(
    column: $table.pickupsBlocked,
    builder: (column) => column,
  );

  GeneratedColumn<int> get secondsHeld => $composableBuilder(
    column: $table.secondsHeld,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sessionsCompleted => $composableBuilder(
    column: $table.sessionsCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<int> get earlyUnlocks => $composableBuilder(
    column: $table.earlyUnlocks,
    builder: (column) => column,
  );
}

class $$DailyStatsTableTableManager
    extends
        RootTableManager<
          _$KedgeDatabase,
          $DailyStatsTable,
          DailyStat,
          $$DailyStatsTableFilterComposer,
          $$DailyStatsTableOrderingComposer,
          $$DailyStatsTableAnnotationComposer,
          $$DailyStatsTableCreateCompanionBuilder,
          $$DailyStatsTableUpdateCompanionBuilder,
          (
            DailyStat,
            BaseReferences<_$KedgeDatabase, $DailyStatsTable, DailyStat>,
          ),
          DailyStat,
          PrefetchHooks Function()
        > {
  $$DailyStatsTableTableManager(_$KedgeDatabase db, $DailyStatsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyStatsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyStatsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyStatsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> day = const Value.absent(),
                Value<int> pickupsBlocked = const Value.absent(),
                Value<int> secondsHeld = const Value.absent(),
                Value<int> sessionsCompleted = const Value.absent(),
                Value<int> earlyUnlocks = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyStatsCompanion(
                day: day,
                pickupsBlocked: pickupsBlocked,
                secondsHeld: secondsHeld,
                sessionsCompleted: sessionsCompleted,
                earlyUnlocks: earlyUnlocks,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String day,
                Value<int> pickupsBlocked = const Value.absent(),
                Value<int> secondsHeld = const Value.absent(),
                Value<int> sessionsCompleted = const Value.absent(),
                Value<int> earlyUnlocks = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyStatsCompanion.insert(
                day: day,
                pickupsBlocked: pickupsBlocked,
                secondsHeld: secondsHeld,
                sessionsCompleted: sessionsCompleted,
                earlyUnlocks: earlyUnlocks,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyStatsTableProcessedTableManager =
    ProcessedTableManager<
      _$KedgeDatabase,
      $DailyStatsTable,
      DailyStat,
      $$DailyStatsTableFilterComposer,
      $$DailyStatsTableOrderingComposer,
      $$DailyStatsTableAnnotationComposer,
      $$DailyStatsTableCreateCompanionBuilder,
      $$DailyStatsTableUpdateCompanionBuilder,
      (DailyStat, BaseReferences<_$KedgeDatabase, $DailyStatsTable, DailyStat>),
      DailyStat,
      PrefetchHooks Function()
    >;
typedef $$StreaksTableCreateCompanionBuilder =
    StreaksCompanion Function({
      Value<int> id,
      Value<int> currentDays,
      Value<int> longestDays,
      Value<String?> lastHeldDay,
    });
typedef $$StreaksTableUpdateCompanionBuilder =
    StreaksCompanion Function({
      Value<int> id,
      Value<int> currentDays,
      Value<int> longestDays,
      Value<String?> lastHeldDay,
    });

class $$StreaksTableFilterComposer
    extends Composer<_$KedgeDatabase, $StreaksTable> {
  $$StreaksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentDays => $composableBuilder(
    column: $table.currentDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get longestDays => $composableBuilder(
    column: $table.longestDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastHeldDay => $composableBuilder(
    column: $table.lastHeldDay,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StreaksTableOrderingComposer
    extends Composer<_$KedgeDatabase, $StreaksTable> {
  $$StreaksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentDays => $composableBuilder(
    column: $table.currentDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get longestDays => $composableBuilder(
    column: $table.longestDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastHeldDay => $composableBuilder(
    column: $table.lastHeldDay,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StreaksTableAnnotationComposer
    extends Composer<_$KedgeDatabase, $StreaksTable> {
  $$StreaksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get currentDays => $composableBuilder(
    column: $table.currentDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get longestDays => $composableBuilder(
    column: $table.longestDays,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastHeldDay => $composableBuilder(
    column: $table.lastHeldDay,
    builder: (column) => column,
  );
}

class $$StreaksTableTableManager
    extends
        RootTableManager<
          _$KedgeDatabase,
          $StreaksTable,
          Streak,
          $$StreaksTableFilterComposer,
          $$StreaksTableOrderingComposer,
          $$StreaksTableAnnotationComposer,
          $$StreaksTableCreateCompanionBuilder,
          $$StreaksTableUpdateCompanionBuilder,
          (Streak, BaseReferences<_$KedgeDatabase, $StreaksTable, Streak>),
          Streak,
          PrefetchHooks Function()
        > {
  $$StreaksTableTableManager(_$KedgeDatabase db, $StreaksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StreaksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StreaksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StreaksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> currentDays = const Value.absent(),
                Value<int> longestDays = const Value.absent(),
                Value<String?> lastHeldDay = const Value.absent(),
              }) => StreaksCompanion(
                id: id,
                currentDays: currentDays,
                longestDays: longestDays,
                lastHeldDay: lastHeldDay,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> currentDays = const Value.absent(),
                Value<int> longestDays = const Value.absent(),
                Value<String?> lastHeldDay = const Value.absent(),
              }) => StreaksCompanion.insert(
                id: id,
                currentDays: currentDays,
                longestDays: longestDays,
                lastHeldDay: lastHeldDay,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StreaksTableProcessedTableManager =
    ProcessedTableManager<
      _$KedgeDatabase,
      $StreaksTable,
      Streak,
      $$StreaksTableFilterComposer,
      $$StreaksTableOrderingComposer,
      $$StreaksTableAnnotationComposer,
      $$StreaksTableCreateCompanionBuilder,
      $$StreaksTableUpdateCompanionBuilder,
      (Streak, BaseReferences<_$KedgeDatabase, $StreaksTable, Streak>),
      Streak,
      PrefetchHooks Function()
    >;

class $KedgeDatabaseManager {
  final _$KedgeDatabase _db;
  $KedgeDatabaseManager(this._db);
  $$BlockProfilesTableTableManager get blockProfiles =>
      $$BlockProfilesTableTableManager(_db, _db.blockProfiles);
  $$SessionsTableTableManager get sessions =>
      $$SessionsTableTableManager(_db, _db.sessions);
  $$DailyStatsTableTableManager get dailyStats =>
      $$DailyStatsTableTableManager(_db, _db.dailyStats);
  $$StreaksTableTableManager get streaks =>
      $$StreaksTableTableManager(_db, _db.streaks);
}
