/// Thin analytics abstraction so the SDK can be swapped without touching
/// call sites. Privacy rule: never log the names of apps a user blocked and
/// never log usage content — counts and enum values only.
abstract interface class AnalyticsService {
  Future<void> init();
  Future<void> track(String event, [Map<String, Object>? properties]);
  Future<void> screen(String screenName);
}

/// Canonical event names (section 9 of the spec). Always use these constants;
/// never inline event strings at call sites.
abstract final class AnalyticsEvents {
  static const onboardingStarted = 'onboarding_started';
  static const onboardingStepCompleted = 'onboarding_step_completed'; // {step}
  static const permissionRequested = 'permission_requested'; // {platform}
  static const permissionGranted = 'permission_granted'; // {platform}
  static const appsSelected = 'apps_selected'; // {count}
  static const profileCreated =
      'profile_created'; // {trigger_type, friction_level}
  static const sessionStarted =
      'session_started'; // {profile_id, duration_min, friction_level}
  static const sessionCompleted =
      'session_completed'; // {held, early_unlock_count}
  static const shieldShown = 'shield_shown'; // {profile_id}
  static const earlyUnlockAttempted =
      'early_unlock_attempted'; // {friction_level}
  static const earlyUnlockSucceeded =
      'early_unlock_succeeded'; // {friction_level}
  static const paywallShown = 'paywall_shown'; // {placement}
  static const paywallDismissed = 'paywall_dismissed'; // {placement}
  static const trialStarted = 'trial_started'; // {product_id}
  static const purchaseCompleted = 'purchase_completed'; // {product_id}
  static const streakIncremented = 'streak_incremented'; // {days}
}

/// Used when no analytics key is configured (local dev, tests).
final class NoopAnalytics implements AnalyticsService {
  const NoopAnalytics();

  @override
  Future<void> init() async {}

  @override
  Future<void> track(String event, [Map<String, Object>? properties]) async {}

  @override
  Future<void> screen(String screenName) async {}
}
