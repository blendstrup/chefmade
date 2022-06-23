import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Icons;

class ExpandableSection extends StatefulWidget {
  const ExpandableSection({
    Key? key,
    required this.title,
    required this.children,
    this.prefix,
    this.trailing,
    this.trailingPrefix,
    this.trailingPrefixSpacing,
    this.titlePadding,
    this.childrenPadding,
    this.childrenAlignment,
    this.initiallyExpanded,
    this.centerTitle,
    this.backgroundColor,
    this.collapsedBackgroundColor,
    this.maintainState,
  }) : super(key: key);

  final Widget title;
  final List<Widget> children;
  final Widget? prefix;
  final Widget? trailing;
  final Widget? trailingPrefix;
  final double? trailingPrefixSpacing;
  final EdgeInsets? titlePadding;
  final EdgeInsets? childrenPadding;
  final CrossAxisAlignment? childrenAlignment;
  final bool? initiallyExpanded;
  final bool? centerTitle;
  final bool? maintainState;
  final Color? backgroundColor;
  final Color? collapsedBackgroundColor;

  @override
  _ExpandableSectionState createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<ExpandableSection>
    with AutomaticKeepAliveClientMixin {
  late bool _expanded;
  double _iconTurns = 0;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded ?? false;
    if (_expanded) {
      _iconTurns = 0.5;
    }
  }

  @override
  bool get wantKeepAlive => widget.maintainState ?? false;

  void _toggleExpansion() {
    setState(() {
      _expanded = !_expanded;
      if (_expanded) {
        _iconTurns = 0.5;
      } else {
        _iconTurns = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    IconData _platformIcon =
        Platform.isIOS ? CupertinoIcons.chevron_down : Icons.arrow_drop_down;
    super.build(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _toggleExpansion,
          child: Padding(
            padding: widget.titlePadding ?? const EdgeInsets.all(0),
            child: Stack(
              children: [
                Row(
                  children: [
                    if (widget.prefix != null) widget.prefix!,
                    if (widget.centerTitle != null && widget.centerTitle!)
                      Flexible(child: Center(child: widget.title))
                    else
                      widget.title,
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        if (widget.trailingPrefix != null) ...[
                          widget.trailingPrefix!,
                          SizedBox(width: widget.trailingPrefixSpacing ?? 20),
                        ],
                        widget.trailing ??
                            AnimatedRotation(
                              turns: _iconTurns,
                              duration: const Duration(milliseconds: 200),
                              child: Icon(_platformIcon),
                              curve: Curves.easeInOut,
                            ),
                        if (widget.titlePadding == null)
                          const SizedBox(width: 10),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        ExpandableSectionChildren(
          expand: _expanded,
          child: Padding(
            padding: widget.childrenPadding ?? const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment:
                  widget.childrenAlignment ?? CrossAxisAlignment.center,
              children: widget.children,
            ),
          ),
        ),
      ],
    );
  }
}

class ExpandableSectionChildren extends StatefulWidget {
  const ExpandableSectionChildren({
    Key? key,
    required this.expand,
    required this.child,
  }) : super(key: key);

  final Widget child;
  final bool expand;

  @override
  _ExpandableSectionChildrenState createState() =>
      _ExpandableSectionChildrenState();
}

class _ExpandableSectionChildrenState extends State<ExpandableSectionChildren>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController expandController;

  @override
  void didUpdateWidget(ExpandableSectionChildren oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.expand) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    if (widget.expand) {
      expandController.forward();
    }
  }

  void prepareAnimations() {
    expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    Animation<double> curve = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axisAlignment: 1.0,
      sizeFactor: animation,
      child: widget.child,
    );
  }
}
