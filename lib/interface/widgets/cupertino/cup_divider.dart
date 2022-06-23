import 'package:flutter/cupertino.dart';

class CupDivider extends StatelessWidget {
  const CupDivider.short({
    Key? key,
    this.isLong = false,
    this.dividerColor,
    this.dividerHeight,
    this.margin,
  }) : super(key: key);

  const CupDivider.long({
    Key? key,
    this.isLong = true,
    this.dividerColor,
    this.dividerHeight,
    this.margin,
  }) : super(key: key);

  final bool isLong;
  final Color? dividerColor;
  final double? dividerHeight;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    final Color _defaultColor = CupertinoColors.separator.resolveFrom(context);
    final double _defaultHeight = 1.0 / MediaQuery.of(context).devicePixelRatio;

    final Widget longDivider = Container(
      color: dividerColor ?? _defaultColor,
      height: dividerHeight ?? _defaultHeight,
    );

    final Widget shortDivider = Container(
      margin: const EdgeInsetsDirectional.only(start: 15.0),
      color: dividerColor ?? _defaultColor,
      height: dividerHeight ?? _defaultHeight,
    );

    return Padding(
      padding: margin ?? const EdgeInsets.all(0),
      child: isLong ? longDivider : shortDivider,
    );
  }
}
