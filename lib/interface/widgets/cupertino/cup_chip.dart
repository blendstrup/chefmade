import 'package:flutter/cupertino.dart';

import '../../colors.dart';
import 'cup_material.dart';

class CupChip extends StatelessWidget {
  const CupChip({
    Key? key,
    required this.child,
    this.margin,
    this.padding,
    this.color,
    this.borderRadius,
  }) : super(key: key);

  final Widget child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? color;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return CupMaterial(
      child: Padding(
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
        child: child,
      ),
      margin: margin ?? const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: color ??
            const CupertinoDynamicColor.withBrightness(
              color: AppColors.lightGrey1,
              darkColor: AppColors.darkGrey3,
            ).resolveFrom(context),
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
      ),
    );
  }
}
