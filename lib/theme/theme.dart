import 'package:flutter/material.dart';

import 'tokens.dart';
import 'typography.dart';

/// Builds the two app themes from tokens. Dark is the default and primary.
abstract final class KedgeTheme {
  static ThemeData dark() => _build(
        brightness: Brightness.dark,
        background: KedgeColors.ink,
        surface: KedgeColors.surface,
        surfaceRaised: KedgeColors.surfaceRaised,
        textPrimary: KedgeColors.textPrimary,
        textSecondary: KedgeColors.textSecondary,
        divider: KedgeColors.divider,
      );

  static ThemeData light() => _build(
        brightness: Brightness.light,
        background: KedgeColors.inkLight,
        surface: KedgeColors.surfaceLight,
        surfaceRaised: KedgeColors.surfaceRaisedLight,
        textPrimary: KedgeColors.textPrimaryLight,
        textSecondary: KedgeColors.textSecondaryLight,
        divider: KedgeColors.dividerLight,
      );

  static ThemeData _build({
    required Brightness brightness,
    required Color background,
    required Color surface,
    required Color surfaceRaised,
    required Color textPrimary,
    required Color textSecondary,
    required Color divider,
  }) {
    final onBrass =
        brightness == Brightness.dark ? KedgeColors.ink : KedgeColors.inkLight;
    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: KedgeColors.brass,
      onPrimary: onBrass,
      secondary: KedgeColors.teal,
      onSecondary: onBrass,
      error: KedgeColors.clay,
      onError: KedgeColors.textPrimary,
      surface: surface,
      onSurface: textPrimary,
      surfaceContainerHighest: surfaceRaised,
      onSurfaceVariant: textSecondary,
      outline: divider,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      dividerColor: divider,
      splashFactory: NoSplash.splashFactory,
      textTheme: TextTheme(
        displaySmall: KedgeType.display(textPrimary),
        headlineLarge: KedgeType.h1(textPrimary),
        headlineMedium: KedgeType.h2(textPrimary),
        titleMedium: KedgeType.h3(textPrimary),
        bodyLarge: KedgeType.body(textPrimary),
        bodyMedium: KedgeType.body(textSecondary),
        labelLarge: KedgeType.bodyMedium(textPrimary),
        bodySmall: KedgeType.caption(textSecondary),
        labelSmall: KedgeType.micro(textSecondary),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: textPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: KedgeType.h2(textPrimary),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(KedgeRadii.lg),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: KedgeColors.brass,
          foregroundColor: onBrass,
          disabledBackgroundColor: KedgeColors.brassDim,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(KedgeRadii.md),
          ),
          textStyle: KedgeType.bodyMedium(onBrass),
        ),
      ),
    );
  }
}
