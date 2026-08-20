// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(database)
final databaseProvider = DatabaseProvider._();

final class DatabaseProvider
    extends
        $FunctionalProvider<BallastDatabase, BallastDatabase, BallastDatabase>
    with $Provider<BallastDatabase> {
  DatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'databaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$databaseHash();

  @$internal
  @override
  $ProviderElement<BallastDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BallastDatabase create(Ref ref) {
    return database(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BallastDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BallastDatabase>(value),
    );
  }
}

String _$databaseHash() => r'7b1e6a9175d32314fa822a9784cd57add7c2dffd';

@ProviderFor(analytics)
final analyticsProvider = AnalyticsProvider._();

final class AnalyticsProvider
    extends
        $FunctionalProvider<
          AnalyticsService,
          AnalyticsService,
          AnalyticsService
        >
    with $Provider<AnalyticsService> {
  AnalyticsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'analyticsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$analyticsHash();

  @$internal
  @override
  $ProviderElement<AnalyticsService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AnalyticsService create(Ref ref) {
    return analytics(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AnalyticsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AnalyticsService>(value),
    );
  }
}

String _$analyticsHash() => r'57af8b3f5e920995218911746c024a4f3c3843b9';

@ProviderFor(purchases)
final purchasesProvider = PurchasesProvider._();

final class PurchasesProvider
    extends
        $FunctionalProvider<
          PurchasesService,
          PurchasesService,
          PurchasesService
        >
    with $Provider<PurchasesService> {
  PurchasesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'purchasesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$purchasesHash();

  @$internal
  @override
  $ProviderElement<PurchasesService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PurchasesService create(Ref ref) {
    return purchases(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PurchasesService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PurchasesService>(value),
    );
  }
}

String _$purchasesHash() => r'0e800cdab688716584d0c69214810c7893657480';

@ProviderFor(blockingEngine)
final blockingEngineProvider = BlockingEngineProvider._();

final class BlockingEngineProvider
    extends $FunctionalProvider<BlockingEngine, BlockingEngine, BlockingEngine>
    with $Provider<BlockingEngine> {
  BlockingEngineProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'blockingEngineProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$blockingEngineHash();

  @$internal
  @override
  $ProviderElement<BlockingEngine> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BlockingEngine create(Ref ref) {
    return blockingEngine(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BlockingEngine value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BlockingEngine>(value),
    );
  }
}

String _$blockingEngineHash() => r'2a78ed0b64ca3a09422c038284bc51f7a3aa4296';
