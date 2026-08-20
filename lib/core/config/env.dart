/// Build-time configuration. Inject real values with --dart-define, e.g.
///
///   flutter run --dart-define=REVENUECAT_IOS_API_KEY=appl_xxx \
///               --dart-define=POSTHOG_API_KEY=phc_xxx
///
/// Empty values are placeholders: the corresponding service initialises as a
/// no-op and the app still runs. See README for the full list.
abstract final class Env {
  static const revenueCatIosApiKey =
      String.fromEnvironment('REVENUECAT_IOS_API_KEY');
  static const revenueCatAndroidApiKey =
      String.fromEnvironment('REVENUECAT_ANDROID_API_KEY');
  static const posthogApiKey = String.fromEnvironment('POSTHOG_API_KEY');
  static const posthogHost = String.fromEnvironment(
    'POSTHOG_HOST',
    defaultValue: 'https://us.i.posthog.com',
  );

  /// RevenueCat entitlement identifier gating all Pro features.
  static const proEntitlementId = 'pro';
}
