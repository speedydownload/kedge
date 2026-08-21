import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/routing/router.dart';
import 'theme/theme.dart';

class KedgeApp extends ConsumerWidget {
  const KedgeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Kedge',
      debugShowCheckedModeBanner: false,
      theme: KedgeTheme.light(),
      darkTheme: KedgeTheme.dark(),
      themeMode: ThemeMode.dark,
      routerConfig: ref.watch(routerProvider),
    );
  }
}
