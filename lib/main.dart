import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer();
  // Both no-op harmlessly when keys are placeholders.
  await container.read(purchasesProvider).init();
  await container.read(analyticsProvider).init();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const BallastApp(),
    ),
  );
}
