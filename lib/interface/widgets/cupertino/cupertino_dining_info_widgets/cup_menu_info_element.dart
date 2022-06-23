import 'package:flutter/cupertino.dart';

class CupMenuInfoElement extends StatelessWidget {
  const CupMenuInfoElement({
    Key? key,
    required this.title,
    this.text,
    this.child,
    this.children,
    this.centerTitle = false,
    this.spacing,
  }) : super(key: key);

  final String title;
  final String? text;
  final Widget? child;
  final List<Widget>? children;
  final bool centerTitle;
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    CupertinoThemeData _theme = CupertinoTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: centerTitle ? Alignment.center : Alignment.centerLeft,
          child: Text(
            title,
            style: _theme.textTheme.textStyle.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        SizedBox(height: spacing ?? 3),
        if (text != null)
          Text(
            text!,
            softWrap: true,
          )
        else if (child != null)
          child!
        else if (children != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children!,
          ),
      ],
    );
  }
}
