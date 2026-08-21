import 'package:flutter/widgets.dart';

/// Kedge design tokens. Widgets must never hardcode colours, sizes, or
/// motion values — everything visual routes through this file.
abstract final class KedgeColors {
  // Dark (default, primary)
  static const ink = Color(0xFF0D1117);
  static const surface = Color(0xFF161C24);
  static const surfaceRaised = Color(0xFF1F2833);
  static const brass = Color(0xFFE8B04B);
  static const brassDim = Color(0xFFB8862F);
  static const teal = Color(0xFF4FA3A5);
  static const clay = Color(0xFFD2603F);
  static const textPrimary = Color(0xFFF2F4F5);
  static const textSecondary = Color(0xFF98A2AE);
  static const textMuted = Color(0xFF5C6874);
  static const divider = Color(0xFF232C38);

  // Light
  static const inkLight = Color(0xFFFAF8F4);
  static const surfaceLight = Color(0xFFFFFFFF);
  static const surfaceRaisedLight = Color(0xFFF1EDE6);
  static const textPrimaryLight = Color(0xFF0D1117);
  static const textSecondaryLight = Color(0xFF5C6874);
  static const textMutedLight = Color(0xFF98A2AE);
  static const dividerLight = Color(0xFFE5E0D6);
}

abstract final class KedgeSpacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
  static const xxl = 48.0;
}

abstract final class KedgeRadii {
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 20.0;
}

/// Motion: slow and heavy, never bouncy. The brand is "weight".
abstract final class KedgeMotion {
  static const curve = Curves.easeOutCubic;
  static const standard = Duration(milliseconds: 240);
  static const shieldFadeIn = Duration(milliseconds: 400);
}
