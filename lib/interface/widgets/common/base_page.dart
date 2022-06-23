import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  const BasePage({
    Key? key,
    this.androidOverride,
    this.appBar,
    this.cacheExtent,
    this.clipBehavior = Clip.hardEdge,
    this.reverse = false,
    this.scrollBehavior,
    this.scrollController,
    this.scrollDirection = Axis.vertical,
    this.scrollPhysics,
    this.semanticChildCount,
    this.shrinkWrap = false,
    this.slivers = const <Widget>[],
    this.removeFocusOnTap = false,
  }) : super(key: key);

  /// On android its not possible to set the physics to [NeverScrollableScrollPhysics]
  /// in a [NestedScrollView] with a [SliverAppBar] that has a [FlexibleSpaceBar]
  //
  /// This is a problem in the app since we don't want the login page to have scrolling
  /// so we add a optional [androidOverride] that we then use on the [material_login_page]
  /// to create a [CustomScrollView] instead of the [NestedScrollView]
  final Widget? androidOverride;
  final Widget? appBar;
  final double? cacheExtent;
  final Clip clipBehavior;
  final bool reverse;
  final ScrollBehavior? scrollBehavior;
  final ScrollController? scrollController;
  final Axis scrollDirection;
  final ScrollPhysics? scrollPhysics;
  final int? semanticChildCount;
  final bool shrinkWrap;
  final List<Widget> slivers;
  final bool removeFocusOnTap;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return GestureDetector(
        onTap: () => {
          if (removeFocusOnTap) FocusManager.instance.primaryFocus?.unfocus()
        },
        child: DefaultTextStyle(
          style: CupertinoTheme.of(context).textTheme.textStyle,
          child: CustomScrollView(
            cacheExtent: cacheExtent,
            clipBehavior: clipBehavior,
            reverse: reverse,
            scrollBehavior: scrollBehavior,
            controller: scrollController,
            scrollDirection: scrollDirection,
            physics: scrollPhysics,
            semanticChildCount: semanticChildCount,
            shrinkWrap: shrinkWrap,
            slivers: [appBar!, ...slivers],
          ),
        ),
      );
    } else {
      return androidOverride ??
          GestureDetector(
            onTap: () => {
              if (removeFocusOnTap)
                FocusManager.instance.primaryFocus?.unfocus()
            },
            child: NestedScrollView(
              controller: scrollController,
              scrollBehavior: scrollBehavior,
              physics: scrollPhysics,
              reverse: reverse,
              scrollDirection: scrollDirection,
              headerSliverBuilder: (BuildContext context, bool _) {
                return [appBar!];
              },
              body: Builder(
                builder: (context) {
                  return CustomScrollView(
                    cacheExtent: cacheExtent,
                    clipBehavior: clipBehavior,
                    semanticChildCount: semanticChildCount,
                    shrinkWrap: shrinkWrap,
                    slivers: [
                      ...slivers,
                    ],
                  );
                },
              ),
            ),
          );
    }
  }
}
