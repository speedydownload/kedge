import 'dart:math';

import 'package:flutter_test/flutter_test.dart';

import 'package:ballast/domain/enums.dart';
import 'package:ballast/domain/friction_policy.dart';

void main() {
  group('gentle', () {
    test('always allowed, no wait, pauses instead of ending', () {
      for (final used in [0, 3, 99]) {
        final r = FrictionPolicy.requestEarlyUnlock(
            level: FrictionLevel.gentle, earlyUnlocksToday: used);
        expect(r.allowed, isTrue);
        expect(r.wait, Duration.zero);
        expect(r.effect, UnlockEffect.pauseShield);
        expect(r.requiresPassphrase, isFalse);
      }
    });
  });

  group('firm', () {
    test('grants with a 60-second wait and ends the session', () {
      final r = FrictionPolicy.requestEarlyUnlock(
          level: FrictionLevel.firm, earlyUnlocksToday: 2);
      expect(r.allowed, isTrue);
      expect(r.wait, const Duration(seconds: 60));
      expect(r.effect, UnlockEffect.endSession);
    });

    test('denies the fourth unlock of the day', () {
      final r = FrictionPolicy.requestEarlyUnlock(
          level: FrictionLevel.firm, earlyUnlocksToday: 3);
      expect(r.allowed, isFalse);
      expect(r.denialReason, isNotNull);
      expect(r.effect, isNull);
    });
  });

  group('strict', () {
    test('requires the passphrase, no wait, ends the session', () {
      final r = FrictionPolicy.requestEarlyUnlock(
          level: FrictionLevel.strict, earlyUnlocksToday: 0);
      expect(r.allowed, isTrue);
      expect(r.requiresPassphrase, isTrue);
      expect(r.effect, UnlockEffect.endSession);
    });

    test('cannot be disabled while a session runs', () {
      expect(FrictionPolicy.canDisableStrict(sessionActive: true), isFalse);
      expect(FrictionPolicy.canDisableStrict(sessionActive: false), isTrue);
    });

    test('uninstall protection is strict-only', () {
      expect(FrictionPolicy.uninstallProtection(FrictionLevel.strict), isTrue);
      expect(FrictionPolicy.uninstallProtection(FrictionLevel.firm), isFalse);
      expect(FrictionPolicy.uninstallProtection(FrictionLevel.gentle), isFalse);
    });
  });

  group('passphrase', () {
    test('is exactly 40 characters from the unambiguous alphabet', () {
      final p = FrictionPolicy.generatePassphrase(random: Random(7));
      expect(p.length, 40);
      expect(p, isNot(matches(RegExp('[0O1lI]'))));
    });

    test('two generations differ', () {
      expect(FrictionPolicy.generatePassphrase(),
          isNot(FrictionPolicy.generatePassphrase()));
    });

    test('verification is exact — no trimming mercy', () {
      final p = FrictionPolicy.generatePassphrase(random: Random(7));
      expect(FrictionPolicy.verifyPassphrase(expected: p, entered: p), isTrue);
      expect(FrictionPolicy.verifyPassphrase(expected: p, entered: ' $p'),
          isFalse);
      expect(
          FrictionPolicy.verifyPassphrase(
              expected: p, entered: p.toLowerCase() == p ? p.toUpperCase() : p.toLowerCase()),
          isFalse);
      expect(FrictionPolicy.verifyPassphrase(expected: '', entered: ''), isFalse);
    });
  });
}
