// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(profileRepository)
final profileRepositoryProvider = ProfileRepositoryProvider._();

final class ProfileRepositoryProvider
    extends
        $FunctionalProvider<
          ProfileRepository,
          ProfileRepository,
          ProfileRepository
        >
    with $Provider<ProfileRepository> {
  ProfileRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileRepositoryHash();

  @$internal
  @override
  $ProviderElement<ProfileRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProfileRepository create(Ref ref) {
    return profileRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProfileRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProfileRepository>(value),
    );
  }
}

String _$profileRepositoryHash() => r'4b207e74f8e386bcbc56bdd6ac9baeb0640d2710';

@ProviderFor(sessionRepository)
final sessionRepositoryProvider = SessionRepositoryProvider._();

final class SessionRepositoryProvider
    extends
        $FunctionalProvider<
          SessionRepository,
          SessionRepository,
          SessionRepository
        >
    with $Provider<SessionRepository> {
  SessionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionRepositoryHash();

  @$internal
  @override
  $ProviderElement<SessionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SessionRepository create(Ref ref) {
    return sessionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SessionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SessionRepository>(value),
    );
  }
}

String _$sessionRepositoryHash() => r'07d182ce5da2df5ea1413ebd825b4192594e279b';

@ProviderFor(statsRepository)
final statsRepositoryProvider = StatsRepositoryProvider._();

final class StatsRepositoryProvider
    extends
        $FunctionalProvider<StatsRepository, StatsRepository, StatsRepository>
    with $Provider<StatsRepository> {
  StatsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'statsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$statsRepositoryHash();

  @$internal
  @override
  $ProviderElement<StatsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  StatsRepository create(Ref ref) {
    return statsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StatsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StatsRepository>(value),
    );
  }
}

String _$statsRepositoryHash() => r'83e8d16f4cd0a2a2601222825b9831986dec7d62';

@ProviderFor(streakRepository)
final streakRepositoryProvider = StreakRepositoryProvider._();

final class StreakRepositoryProvider
    extends
        $FunctionalProvider<
          StreakRepository,
          StreakRepository,
          StreakRepository
        >
    with $Provider<StreakRepository> {
  StreakRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'streakRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$streakRepositoryHash();

  @$internal
  @override
  $ProviderElement<StreakRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  StreakRepository create(Ref ref) {
    return streakRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StreakRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StreakRepository>(value),
    );
  }
}

String _$streakRepositoryHash() => r'a0fd8475fe86958af6c20195befb9c35a74dd517';

@ProviderFor(sessionService)
final sessionServiceProvider = SessionServiceProvider._();

final class SessionServiceProvider
    extends $FunctionalProvider<SessionService, SessionService, SessionService>
    with $Provider<SessionService> {
  SessionServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionServiceHash();

  @$internal
  @override
  $ProviderElement<SessionService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SessionService create(Ref ref) {
    return sessionService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SessionService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SessionService>(value),
    );
  }
}

String _$sessionServiceHash() => r'6d8e27267ac1c746d4fbc346c7f38564af2067c6';
