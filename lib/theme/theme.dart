import 'package:flutter/material.dart';

import 'tokens.dart';
import 'typography.dart';

/// Builds the two app themes from tokens. Dark is the default and primary.
abstract final class BallastTheme {
  static ThemeData dark() => _build(
        brightness: Brightness.dark,
        background: BallastColors.ink,
        surface: BallastColors.surface,
        surfaceRaised: BallastColors.surfaceRaised,
        textPrimary: BallastColors.textPrimary,
        textSecondary: BallastColors.textSecondary,
        divider: BallastColors.divider,
      );

  static ThemeData light() => _build(
        brightness: Brightness.light,
        background: BallastColors.inkLight,
        surface: BallastColors.surfaceLight,
        surfaceRaised: BallastColors.surfaceRaisedLight,
        textPrimary: BallastColors.textPrimaryLight,
        textSecondary: BallastColors.textSecondaryLight,
        divider: BallastColors.dividerLight,
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
        brightness == Brightness.dark ? BallastColors.ink : BallastColors.inkLight;
    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: BallastColors.brass,
      onPrimary: onBrass,
      secondary: BallastColors.teal,
      onSecondary: onBrass,
      error: BallastColors.clay,
      onError: BallastColors.textPrimary,
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
        displaySmall: BallastType.display(textPrimary),
        headlineLarge: BallastType.h1(textPrimary),
        headlineMedium: BallastType.h2(textPrimary),
        titleMedium: BallastType.h3(textPrimary),
        bodyLarge: BallastType.body(textPrimary),
        bodyMedium: BallastType.body(textSecondary),
        labelLarge: BallastType.bodyMedium(textPrimary),
        bodySmall: BallastType.caption(textSecondary),
        labelSmall: BallastType.micro(textSecondary),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: textPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: BallastType.h2(textPrimary),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BallastRadii.lg),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: BallastColors.brass,
          foregroundColor: onBrass,
          disabledBackgroundColor: BallastColors.brassDim,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BallastRadii.md),
          ),
          textStyle: BallastType.bodyMedium(onBrass),
        ),
      ),
    );
  }
}
