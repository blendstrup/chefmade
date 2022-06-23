import 'dart:ui' show Color;

class AppColors {
  AppColors._();

  /// [AppColors.background] is used as the primary background color in the light themes. For dark themes [AppColors.darkGrey1] is used.
  static const Color background = Color(0xFFFFF4F4);

  /// [AppColors.blue] is primarily used for text buttons and to indicate interactible elements.
  static const Color blue = Color(0xFF77BBFF);

  static const Color white = Color(0xFFFFFFFF);
  static const Color lightGrey1 = Color(0xFFEFEFEF);
  static const Color lightGrey2 = Color(0xFFDFDFDF);
  static const Color lightGrey3 = Color(0xFFCFCFCF);

  static const Color black = Color(0xFF000000);
  static const Color darkGrey1 = Color(0xFF151515);
  static const Color darkGrey2 = Color(0xFF202020);
  static const Color darkGrey3 = Color(0xFF303030);

  /// [AppColors.red] should only be used to indicate a failed status.
  static const Color red = Color(0xFFFF7777);

  /// [AppColors.red] should only be used to indicate a pending status.
  static const Color yellow = Color(0xFFFFDD77);

  /// [AppColors.red] should only be used to indicate a successful status.
  static const Color green = Color(0xFF77EEBB);

  static const Color transparent = Color(0x00000000);
}
