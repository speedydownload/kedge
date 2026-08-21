import 'package:flutter_test/flutter_test.dart';

import 'package:kedge/domain/enums.dart';
import 'package:kedge/domain/session_machine.dart';

void main() {
  final noon = DateTime(2026, 8, 21, 12);
  final one = DateTime(2026, 8, 21, 13);

  group('start', () {
    test('scheduled becomes active', () {
      final t = SessionMachine.start(from: SessionState.scheduled);
      expect(t.state, SessionState.active);
      expect(t.endReason, isNull);
      expect(t.endedAt, isNull);
    });

    test('rejects every non-scheduled state', () {
      for (final s in SessionState.values.where(
          (s) => s != SessionState.scheduled)) {
        expect(() => SessionMachine.start(from: s),
            throwsA(isA<InvalidSessionTransition>()));
      }
    });
  });

  group('expire', () {
    test('active completes once the clock ran out, endedAt is the scheduled '
        'end (not the check time)', () {
      final lateCheck = one.add(const Duration(hours: 5)); // app relaunch
      final t = SessionMachine.expire(
          from: SessionState.active, scheduledEndAt: one, now: lateCheck);
      expect(t.state, SessionState.completed);
      expect(t.endReason, SessionEndReason.ranOut);
      expect(t.endedAt, one);
    });

    test('exactly at scheduledEndAt counts as expired', () {
      final t = SessionMachine.expire(
          from: SessionState.active, scheduledEndAt: one, now: one);
      expect(t.state, SessionState.completed);
    });

    test('refuses to complete before the end', () {
      expect(
        () => SessionMachine.expire(
            from: SessionState.active, scheduledEndAt: one, now: noon),
        throwsA(isA<InvalidSessionTransition>()),
      );
    });

    test('rejects non-active states', () {
      for (final s in SessionState.values.where((s) => s != SessionState.active)) {
        expect(
          () => SessionMachine.expire(from: s, scheduledEndAt: one, now: one),
          throwsA(isA<InvalidSessionTransition>()),
        );
      }
    });
  });

  group('endEarly', () {
    test('active ends early with earlyUnlock reason at now', () {
      final t = SessionMachine.endEarly(from: SessionState.active, now: noon);
      expect(t.state, SessionState.endedEarly);
      expect(t.endReason, SessionEndReason.earlyUnlock);
      expect(t.endedAt, noon);
    });

    test('terminal states cannot end early again', () {
      expect(() => SessionMachine.endEarly(from: SessionState.completed, now: noon),
          throwsA(isA<InvalidSessionTransition>()));
    });
  });

  group('cancel', () {
    test('scheduled cancels cleanly', () {
      final t = SessionMachine.cancel(from: SessionState.scheduled, now: noon);
      expect(t.state, SessionState.cancelled);
      expect(t.endReason, SessionEndReason.cancelledBeforeStart);
    });

    test('an active session cannot be cancelled, only ended', () {
      expect(() => SessionMachine.cancel(from: SessionState.active, now: noon),
          throwsA(isA<InvalidSessionTransition>()));
    });
  });

  group('held', () {
    test('completed with zero unlocks is held', () {
      expect(SessionMachine.held(state: SessionState.completed, earlyUnlockCount: 0),
          isTrue);
    });

    test('a gentle pause still breaks the hold', () {
      expect(SessionMachine.held(state: SessionState.completed, earlyUnlockCount: 1),
          isFalse);
    });

    test('endedEarly is never held', () {
      expect(SessionMachine.held(state: SessionState.endedEarly, earlyUnlockCount: 0),
          isFalse);
    });
  });

  test('terminality', () {
    expect(SessionMachine.isTerminal(SessionState.scheduled), isFalse);
    expect(SessionMachine.isTerminal(SessionState.active), isFalse);
    expect(SessionMachine.isTerminal(SessionState.completed), isTrue);
    expect(SessionMachine.isTerminal(SessionState.endedEarly), isTrue);
    expect(SessionMachine.isTerminal(SessionState.cancelled), isTrue);
  });
}
