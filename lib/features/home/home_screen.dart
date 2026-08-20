import 'package:flutter/material.dart';

import '../../theme/tokens.dart';

/// Phase 0 placeholder. The real home (state card, streak row, today's
/// stats, quick-start chips) lands in Phase 4.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(BallastSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Text('Nothing blocked yet.', style: textTheme.headlineLarge),
              const SizedBox(height: BallastSpacing.sm),
              Text(
                'Pick the apps that get you.',
                style: textTheme.bodyMedium,
              ),
              const Spacer(),
              FilledButton(
                onPressed: null,
                child: const Text('Start a block'),
              ),
              const SizedBox(height: BallastSpacing.md),
            ],
          ),
        ),
      ),
    );
  }
}
