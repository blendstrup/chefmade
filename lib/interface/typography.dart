import 'package:flutter/cupertino.dart' show TextStyle, FontWeight;

//TODO Replace typography sized with: 10, 11, 12, 14, 18, 24, 30, 36, 48, 60, 72
//TODO Adjust typography using the semiBold font

class AppTypography {
  AppTypography._();

  static const _regular = FontWeight.w400;
  //static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w800;

  static const headline1 = TextStyle(
    fontFamily: 'NotoSerif',
    fontWeight: _regular, //medium
    fontSize: 52,
    letterSpacing: -1.5,
  );

  static const TextStyle headline2 = TextStyle(
    fontFamily: 'NotoSerif',
    fontWeight: _regular, //medium
    fontSize: 40,
    letterSpacing: -0.5,
  );

  static const TextStyle headline3 = TextStyle(
    fontFamily: 'NotoSerif',
    fontWeight: _regular, //semiBold
    fontSize: 32,
    letterSpacing: 0,
  );

  static const TextStyle headline4 = TextStyle(
    fontFamily: 'NotoSerif',
    fontWeight: _regular, //semiBold
    fontSize: 26,
    letterSpacing: 0.25,
  );

  static const TextStyle headline5 = TextStyle(
    fontFamily: 'NotoSerif',
    fontWeight: _bold,
    fontSize: 20,
    letterSpacing: 0,
  );

  static const TextStyle headline6 = TextStyle(
    fontFamily: 'NotoSerif',
    fontWeight: _bold,
    fontSize: 18,
    letterSpacing: 0.15,
  );

  static const TextStyle subtitle1 = TextStyle(
    fontFamily: 'NotoSerif',
    fontWeight: _regular, //medium
    fontSize: 18,
    letterSpacing: 0.15,
  );

  static const TextStyle subtitle2 = TextStyle(
    fontFamily: 'NotoSerif',
    fontWeight: _regular, //medium
    fontSize: 14,
    letterSpacing: 0.1,
  );

  static const TextStyle bodyText1 = TextStyle(
    fontFamily: 'Lato',
    fontWeight: _regular,
    fontSize: 18,
    letterSpacing: 0.5,
  );

  static const TextStyle bodyText2 = TextStyle(
    fontFamily: 'Lato',
    fontWeight: _regular,
    fontSize: 14,
    letterSpacing: 0.25,
  );

  static const TextStyle button = TextStyle(
    fontFamily: 'Lato',
    fontWeight: _bold, //semiBold
    fontSize: 18,
    letterSpacing: 1.25,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: 'Lato',
    fontWeight: _regular,
    fontSize: 14,
    letterSpacing: 0.4,
  );

  static const TextStyle overline = TextStyle(
    fontFamily: 'Lato',
    fontWeight: _regular,
    fontSize: 12,
    letterSpacing: 1.5,
  );
}
