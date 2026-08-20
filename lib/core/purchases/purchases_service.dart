import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../config/env.dart';

/// Wraps RevenueCat. When no API key is configured (placeholder builds) it
/// stays inert and every Pro check returns false.
final class PurchasesService {
  PurchasesService();

  bool _configured = false;
  bool get isConfigured => _configured;

  String get _apiKey =>
      Platform.isIOS ? Env.revenueCatIosApiKey : Env.revenueCatAndroidApiKey;

  Future<void> init() async {
    if (_apiKey.isEmpty) {
      debugPrint(
        'PurchasesService: no RevenueCat API key configured; purchases disabled.',
      );
      return;
    }
    await Purchases.setLogLevel(kDebugMode ? LogLevel.debug : LogLevel.info);
    await Purchases.configure(PurchasesConfiguration(_apiKey));
    _configured = true;
  }

  /// Whether the `pro` entitlement is currently active.
  Future<bool> isPro() async {
    if (!_configured) return false;
    final info = await Purchases.getCustomerInfo();
    return info.entitlements.active.containsKey(Env.proEntitlementId);
  }

  Future<Offerings?> offerings() async {
    if (!_configured) return null;
    return Purchases.getOfferings();
  }

  Future<CustomerInfo?> restore() async {
    if (!_configured) return null;
    return Purchases.restorePurchases();
  }
}
