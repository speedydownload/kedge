import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/db/database.dart';
import 'analytics/analytics_service.dart';
import 'analytics/posthog_analytics.dart';
import 'blocking/blocking_engine.dart';
import 'blocking/method_channel_blocking_engine.dart';
import 'config/env.dart';
import 'purchases/purchases_service.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
KedgeDatabase database(Ref ref) {
  final db = KedgeDatabase();
  ref.onDispose(db.close);
  return db;
}

@Riverpod(keepAlive: true)
AnalyticsService analytics(Ref ref) =>
    Env.posthogApiKey.isEmpty ? const NoopAnalytics() : PosthogAnalytics();

@Riverpod(keepAlive: true)
PurchasesService purchases(Ref ref) => PurchasesService();

@Riverpod(keepAlive: true)
BlockingEngine blockingEngine(Ref ref) =>
    Platform.isIOS ? IosBlockingEngine() : AndroidBlockingEngine();
