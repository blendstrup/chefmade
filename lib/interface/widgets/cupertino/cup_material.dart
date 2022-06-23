import 'package:flutter/cupertino.dart';

import '../../colors.dart';

class CupMaterial extends StatelessWidget {
  const CupMaterial({
    Key? key,
    this.children,
    this.child,
    this.margin = const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 10.0),
    this.decoration,
    this.clipBehavior = Clip.none,
    this.borderRadius = const BorderRadius.all(Radius.circular(10.0)),
  })  : assert((children == null || child == null)),
        super(key: key);

  final Widget? child;
  final List<Widget>? children;
  final BoxDecoration? decoration;
  final Clip clipBehavior;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    final DecoratedBox decoratedChildrenGroup = DecoratedBox(
      decoration: decoration ??
          BoxDecoration(
            color: CupertinoDynamicColor.resolve(
              decoration?.color ??
                  const CupertinoDynamicColor.withBrightness(
                    color: AppColors.white,
                    darkColor: AppColors.darkGrey2,
                  ).resolveFrom(context),
              context,
            ),
            borderRadius: borderRadius,
          ),
      child: child ?? Column(children: children!),
    );

    return Padding(
      padding: margin,
      child: clipBehavior == Clip.none
          ? decoratedChildrenGroup
          : ClipRRect(
              borderRadius: borderRadius,
              clipBehavior: clipBehavior,
              child: decoratedChildrenGroup,
            ),
    );
  }
}
