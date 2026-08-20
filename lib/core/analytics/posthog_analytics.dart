import 'package:posthog_flutter/posthog_flutter.dart';

import '../config/env.dart';
import 'analytics_service.dart';

final class PosthogAnalytics implements AnalyticsService {
  PosthogAnalytics();

  @override
  Future<void> init() async {
    final config = PostHogConfig(Env.posthogApiKey)
      ..host = Env.posthogHost
      ..captureApplicationLifecycleEvents = true
      ..debug = false;
    await Posthog().setup(config);
  }

  @override
  Future<void> track(String event, [Map<String, Object>? properties]) =>
      Posthog().capture(eventName: event, properties: properties ?? const {});

  @override
  Future<void> screen(String screenName) =>
      Posthog().screen(screenName: screenName);
}
