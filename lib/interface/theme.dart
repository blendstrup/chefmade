import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'typography.dart';

class AppTheme {
  AppTheme._();

  static ThemeData materialLightTheme = _themeData(
    _lightColorScheme,
    _lightTextTheme,
  );

  static ThemeData materialDarkTheme = _themeData(
    _darkColorScheme,
    _darkTextTheme,
  );

  static CupertinoThemeData cupertinoTheme = _cupertinoThemeData();

  static ThemeData _themeData(ColorScheme colorScheme, TextTheme textTheme) {
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: textTheme,
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      canvasColor: colorScheme.background,
      backgroundColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      focusColor: colorScheme.onPrimary,
      toggleableActiveColor: colorScheme.primary,
      indicatorColor: colorScheme.onPrimary,
      appBarTheme: AppBarTheme(
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.primary),
        backgroundColor: colorScheme.surface,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 8,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: colorScheme.surface,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        },
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static CupertinoThemeData _cupertinoThemeData() {
    return CupertinoThemeData(
      textTheme: CupertinoTextThemeData(
        primaryColor: _cupertinoTextColor,
        textStyle: AppTypography.bodyText1.copyWith(
          color: _cupertinoTextColor,
        ),
        actionTextStyle: AppTypography.button.copyWith(
          color: AppColors.blue,
        ),
        tabLabelTextStyle: AppTypography.caption.copyWith(
          color: _cupertinoTextColor,
        ),
        navTitleTextStyle: AppTypography.headline5.copyWith(
          color: _cupertinoTextColor,
        ),
        navLargeTitleTextStyle: AppTypography.headline2.copyWith(
          color: _cupertinoTextColor,
        ),
        navActionTextStyle: AppTypography.button.copyWith(
          color: AppColors.blue,
        ),
        pickerTextStyle: AppTypography.button.copyWith(
          color: _cupertinoTextColor,
        ),
        dateTimePickerTextStyle: AppTypography.button.copyWith(
          color: _cupertinoTextColor,
        ),
      ),
      primaryColor: const CupertinoDynamicColor.withBrightness(
        color: AppColors.black,
        darkColor: AppColors.white,
      ),
      barBackgroundColor: const CupertinoDynamicColor.withBrightness(
        color: AppColors.white,
        darkColor: AppColors.black,
      ),
      scaffoldBackgroundColor: const CupertinoDynamicColor.withBrightness(
        color: AppColors.background,
        darkColor: AppColors.darkGrey1,
      ),
    );
  }

  //_lightColorScheme not corrected yet
  static const ColorScheme _lightColorScheme = ColorScheme(
    primary: AppColors.black,
    primaryVariant: AppColors.black,
    secondary: AppColors.blue,
    secondaryVariant: AppColors.blue,
    background: AppColors.background,
    surface: AppColors.white,
    onBackground: AppColors.white,
    error: AppColors.red,
    onError: AppColors.black,
    onPrimary: AppColors.black,
    onSecondary: AppColors.black,
    onSurface: AppColors.black,
    brightness: Brightness.light,
  );

  //_darkColorScheme not corrected yet
  static const ColorScheme _darkColorScheme = ColorScheme(
    primary: AppColors.white,
    primaryVariant: AppColors.white,
    secondary: AppColors.blue,
    secondaryVariant: AppColors.blue,
    background: AppColors.darkGrey2,
    surface: AppColors.black,
    onBackground: AppColors.white, // White with 0.05 opacity
    error: AppColors.red,
    onError: AppColors.white,
    onPrimary: AppColors.white,
    onSecondary: AppColors.white,
    onSurface: AppColors.white,
    brightness: Brightness.dark,
  );

  static CupertinoDynamicColor get _cupertinoTextColor =>
      const CupertinoDynamicColor.withBrightness(
        color: AppColors.black,
        darkColor: AppColors.white,
      );

  static final TextTheme _lightTextTheme = TextTheme(
    headline1: AppTypography.headline1.copyWith(color: AppColors.black),
    headline2: AppTypography.headline2.copyWith(color: AppColors.black),
    headline3: AppTypography.headline3.copyWith(color: AppColors.black),
    headline4: AppTypography.headline4.copyWith(color: AppColors.black),
    headline5: AppTypography.headline5.copyWith(color: AppColors.black),
    headline6: AppTypography.headline6.copyWith(color: AppColors.black),
    subtitle1: AppTypography.subtitle1.copyWith(color: AppColors.black),
    subtitle2: AppTypography.subtitle2.copyWith(color: AppColors.black),
    bodyText1: AppTypography.bodyText1.copyWith(color: AppColors.black),
    bodyText2: AppTypography.bodyText2.copyWith(color: AppColors.black),
    button: AppTypography.button.copyWith(color: AppColors.black),
    caption: AppTypography.caption.copyWith(color: AppColors.black),
    overline: AppTypography.overline.copyWith(color: AppColors.black),
  );

  static final TextTheme _darkTextTheme = TextTheme(
    headline1: AppTypography.headline1.copyWith(color: AppColors.white),
    headline2: AppTypography.headline2.copyWith(color: AppColors.white),
    headline3: AppTypography.headline3.copyWith(color: AppColors.white),
    headline4: AppTypography.headline4.copyWith(color: AppColors.white),
    headline5: AppTypography.headline5.copyWith(color: AppColors.white),
    headline6: AppTypography.headline6.copyWith(color: AppColors.white),
    subtitle1: AppTypography.subtitle1.copyWith(color: AppColors.white),
    subtitle2: AppTypography.subtitle2.copyWith(color: AppColors.white),
    bodyText1: AppTypography.bodyText1.copyWith(color: AppColors.white),
    bodyText2: AppTypography.bodyText2.copyWith(color: AppColors.white),
    button: AppTypography.button.copyWith(color: AppColors.white),
    caption: AppTypography.caption.copyWith(color: AppColors.white),
    overline: AppTypography.overline.copyWith(color: AppColors.white),
  );
}
