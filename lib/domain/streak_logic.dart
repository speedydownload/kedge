/// Pure streak arithmetic over "yyyy-MM-dd" day keys (local time).
/// A day counts toward the streak only when it was *held* — at least one
/// session completed and none ended early that day. Persistence lives in
/// StreakRepository; the rules live here so they can be tested exhaustively.
final class StreakUpdate {
  const StreakUpdate({
    required this.currentDays,
    required this.longestDays,
    required this.lastHeldDay,
  });

  final int currentDays;
  final int longestDays;
  final String? lastHeldDay;
}

abstract final class StreakLogic {
  static String dayKey(DateTime local) {
    final y = local.year.toString().padLeft(4, '0');
    final m = local.month.toString().padLeft(2, '0');
    final d = local.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  static String previousDay(String day) {
    final parsed = DateTime.parse(day);
    return dayKey(parsed.subtract(const Duration(days: 1)));
  }

  static StreakUpdate apply({
    required int currentDays,
    required int longestDays,
    required String? lastHeldDay,
    required String day,
    required bool held,
  }) {
    if (!held) {
      // The day broke; the record stands.
      return StreakUpdate(
        currentDays: 0,
        longestDays: longestDays,
        lastHeldDay: lastHeldDay,
      );
    }
    if (day == lastHeldDay) {
      // Already counted today — holding twice in a day is still one day.
      return StreakUpdate(
        currentDays: currentDays,
        longestDays: longestDays,
        lastHeldDay: lastHeldDay,
      );
    }
    final consecutive = lastHeldDay != null && previousDay(day) == lastHeldDay;
    final current = consecutive ? currentDays + 1 : 1;
    return StreakUpdate(
      currentDays: current,
      longestDays: current > longestDays ? current : longestDays,
      lastHeldDay: day,
    );
  }
}
