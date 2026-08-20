import 'package:flutter/widgets.dart';

/// Both families ship as variable TTFs (assets/fonts), so every style pins
/// the `wght` axis alongside fontWeight — without it the variable font
/// renders at its default weight.
abstract final class BallastFonts {
  /// Headlines only — the brand signature serif.
  static const fraunces = 'Fraunces';

  /// UI, body, numbers.
  static const inter = 'Inter';
}

TextStyle _style({
  required String family,
  required double size,
  required int weight,
  required Color color,
  double? letterSpacing,
  required double height,
  List<FontFeature>? features,
}) =>
    TextStyle(
      fontFamily: family,
      fontSize: size,
      fontWeight: FontWeight.values[(weight ~/ 100) - 1],
      fontVariations: [FontVariation('wght', weight.toDouble())],
      letterSpacing: letterSpacing,
      height: height,
      color: color,
      fontFeatures: features,
    );

/// Type scale: display 34, h1 28, h2 22, h3 18, body 16, caption 13, micro 11.
abstract final class BallastType {
  static TextStyle display(Color color) => _style(
      family: BallastFonts.fraunces,
      size: 34,
      weight: 600,
      letterSpacing: -0.8,
      height: 1.15,
      color: color);

  static TextStyle h1(Color color) => _style(
      family: BallastFonts.fraunces,
      size: 28,
      weight: 600,
      letterSpacing: -0.6,
      height: 1.2,
      color: color);

  static TextStyle h2(Color color) => _style(
      family: BallastFonts.fraunces,
      size: 22,
      weight: 500,
      letterSpacing: -0.4,
      height: 1.25,
      color: color);

  static TextStyle h3(Color color) => _style(
      family: BallastFonts.inter,
      size: 18,
      weight: 600,
      height: 1.3,
      color: color);

  static TextStyle body(Color color) => _style(
      family: BallastFonts.inter,
      size: 16,
      weight: 400,
      height: 1.45,
      color: color);

  static TextStyle bodyMedium(Color color) => _style(
      family: BallastFonts.inter,
      size: 16,
      weight: 500,
      height: 1.45,
      color: color);

  static TextStyle caption(Color color) => _style(
      family: BallastFonts.inter,
      size: 13,
      weight: 400,
      height: 1.4,
      color: color);

  static TextStyle micro(Color color) => _style(
      family: BallastFonts.inter,
      size: 11,
      weight: 500,
      letterSpacing: 0.2,
      height: 1.3,
      color: color);

  /// All stats use tabular figures so numbers never jitter as they tick.
  static TextStyle stat(Color color, {double fontSize = 28}) => _style(
      family: BallastFonts.inter,
      size: fontSize,
      weight: 600,
      height: 1.2,
      color: color,
      features: const [FontFeature.tabularFigures()]);
}
