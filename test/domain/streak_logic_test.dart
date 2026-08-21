import 'package:flutter_test/flutter_test.dart';

import 'package:kedge/domain/streak_logic.dart';

void main() {
  test('dayKey formats local dates', () {
    expect(StreakLogic.dayKey(DateTime(2026, 8, 21, 23, 59)), '2026-08-21');
    expect(StreakLogic.dayKey(DateTime(2026, 1, 2)), '2026-01-02');
  });

  test('previousDay crosses month and year boundaries', () {
    expect(StreakLogic.previousDay('2026-03-01'), '2026-02-28');
    expect(StreakLogic.previousDay('2026-01-01'), '2025-12-31');
  });

  test('first held day starts a streak of 1', () {
    final u = StreakLogic.apply(
        currentDays: 0, longestDays: 0, lastHeldDay: null,
        day: '2026-08-21', held: true);
    expect(u.currentDays, 1);
    expect(u.longestDays, 1);
    expect(u.lastHeldDay, '2026-08-21');
  });

  test('consecutive day increments', () {
    final u = StreakLogic.apply(
        currentDays: 10, longestDays: 10, lastHeldDay: '2026-08-20',
        day: '2026-08-21', held: true);
    expect(u.currentDays, 11);
    expect(u.longestDays, 11);
  });

  test('same day counted once', () {
    final u = StreakLogic.apply(
        currentDays: 5, longestDays: 8, lastHeldDay: '2026-08-21',
        day: '2026-08-21', held: true);
    expect(u.currentDays, 5);
    expect(u.longestDays, 8);
  });

  test('a gap resets to 1, longest survives', () {
    final u = StreakLogic.apply(
        currentDays: 7, longestDays: 7, lastHeldDay: '2026-08-15',
        day: '2026-08-21', held: true);
    expect(u.currentDays, 1);
    expect(u.longestDays, 7);
    expect(u.lastHeldDay, '2026-08-21');
  });

  test('a broken day zeroes current, longest and lastHeldDay survive', () {
    final u = StreakLogic.apply(
        currentDays: 7, longestDays: 9, lastHeldDay: '2026-08-20',
        day: '2026-08-21', held: false);
    expect(u.currentDays, 0);
    expect(u.longestDays, 9);
    expect(u.lastHeldDay, '2026-08-20');
  });
}
