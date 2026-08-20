import 'package:flutter/widgets.dart';

/// Font families are declared in pubspec.yaml once the font files land in
/// Phase 1 (assets/fonts). Until then these names fall back to the platform
/// default, which is harmless.
abstract final class BallastFonts {
  /// Headlines only — the brand signature serif.
  static const fraunces = 'Fraunces';

  /// UI, body, numbers.
  static const inter = 'Inter';
}

/// Type scale: display 34, h1 28, h2 22, h3 18, body 16, caption 13, micro 11.
abstract final class BallastType {
  static TextStyle display(Color color) => TextStyle(
        fontFamily: BallastFonts.fraunces,
        fontSize: 34,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.8,
        height: 1.15,
        color: color,
      );

  static TextStyle h1(Color color) => TextStyle(
        fontFamily: BallastFonts.fraunces,
        fontSize: 28,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.6,
        height: 1.2,
        color: color,
      );

  static TextStyle h2(Color color) => TextStyle(
        fontFamily: BallastFonts.fraunces,
        fontSize: 22,
        fontWeight: FontWeight.w500,
        letterSpacing: -0.4,
        height: 1.25,
        color: color,
      );

  static TextStyle h3(Color color) => TextStyle(
        fontFamily: BallastFonts.inter,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: color,
      );

  static TextStyle body(Color color) => TextStyle(
        fontFamily: BallastFonts.inter,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.45,
        color: color,
      );

  static TextStyle bodyMedium(Color color) =>
      body(color).copyWith(fontWeight: FontWeight.w500);

  static TextStyle caption(Color color) => TextStyle(
        fontFamily: BallastFonts.inter,
        fontSize: 13,
        fontWeight: FontWeight.w400,
        height: 1.4,
        color: color,
      );

  static TextStyle micro(Color color) => TextStyle(
        fontFamily: BallastFonts.inter,
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2,
        height: 1.3,
        color: color,
      );

  /// All stats use tabular figures so numbers never jitter as they tick.
  static TextStyle stat(Color color, {double fontSize = 28}) => TextStyle(
        fontFamily: BallastFonts.inter,
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        height: 1.2,
        color: color,
        fontFeatures: const [FontFeature.tabularFigures()],
      );
}
