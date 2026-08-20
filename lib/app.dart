import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/routing/router.dart';
import 'theme/theme.dart';

class BallastApp extends ConsumerWidget {
  const BallastApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Ballast',
      debugShowCheckedModeBanner: false,
      theme: BallastTheme.light(),
      darkTheme: BallastTheme.dark(),
      themeMode: ThemeMode.dark,
      routerConfig: ref.watch(routerProvider),
    );
  }
}
