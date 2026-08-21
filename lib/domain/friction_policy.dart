import 'dart:math';

import 'enums.dart';

/// What a granted early unlock does to the session.
enum UnlockEffect {
  /// Gentle: shield lifts for [FrictionPolicy.gentlePause], session survives.
  pauseShield,

  /// Firm/Strict: the session ends (SessionState.endedEarly).
  endSession,
}

/// The verdict for one early-unlock request. UI renders exactly this —
/// no friction rules may live in widgets.
final class UnlockRuling {
  const UnlockRuling.denied(this.denialReason)
      : allowed = false,
        wait = Duration.zero,
        effect = null,
        requiresPassphrase = false;

  const UnlockRuling.granted({
    required this.wait,
    required this.effect,
    this.requiresPassphrase = false,
  })  : allowed = true,
        denialReason = null;

  final bool allowed;
  final String? denialReason;

  /// Forced wait (with breathing animation) before the unlock happens.
  final Duration wait;
  final UnlockEffect? effect;

  /// Strict only: the 40-character passphrase (or waiting out the session).
  final bool requiresPassphrase;
}

/// The product differentiator, spec'd precisely:
///  - Gentle: "Unlock for 5 min", unlimited uses.
///  - Firm: 60-second forced wait, max 3 early unlocks per day.
///  - Strict: type a random 40-char passphrase or wait out the session;
///    uninstall protection on; cannot be disabled while a session runs.
abstract final class FrictionPolicy {
  static const gentlePause = Duration(minutes: 5);
  static const firmWait = Duration(seconds: 60);
  static const firmDailyLimit = 3;
  static const passphraseLength = 40;

  /// Unambiguous alphabet (no 0/O, 1/l/I) — the friction is length, not
  /// squinting at glyphs.
  static const _alphabet =
      'abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789';

  static UnlockRuling requestEarlyUnlock({
    required FrictionLevel level,
    required int earlyUnlocksToday,
  }) {
    switch (level) {
      case FrictionLevel.gentle:
        return const UnlockRuling.granted(
          wait: Duration.zero,
          effect: UnlockEffect.pauseShield,
        );
      case FrictionLevel.firm:
        if (earlyUnlocksToday >= firmDailyLimit) {
          return const UnlockRuling.denied(
            'Three early unlocks a day. That was the deal.',
          );
        }
        return const UnlockRuling.granted(
          wait: firmWait,
          effect: UnlockEffect.endSession,
        );
      case FrictionLevel.strict:
        return const UnlockRuling.granted(
          wait: Duration.zero,
          effect: UnlockEffect.endSession,
          requiresPassphrase: true,
        );
    }
  }

  /// Strict mode may only be turned off between sessions — stated on the
  /// toggle before the user enables it.
  static bool canDisableStrict({required bool sessionActive}) => !sessionActive;

  /// Uninstall protection is exclusively a strict-session concern.
  static bool uninstallProtection(FrictionLevel level) =>
      level == FrictionLevel.strict;

  static String generatePassphrase({Random? random}) {
    final rng = random ?? Random.secure();
    return String.fromCharCodes(Iterable.generate(
      passphraseLength,
      (_) => _alphabet.codeUnitAt(rng.nextInt(_alphabet.length)),
    ));
  }

  /// Exact match, no trimming mercy — the typing is the point.
  static bool verifyPassphrase({
    required String expected,
    required String entered,
  }) =>
      expected.isNotEmpty && expected == entered;
}
