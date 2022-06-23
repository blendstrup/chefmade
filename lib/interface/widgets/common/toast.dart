import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../colors.dart';

class AppToast extends StatelessWidget {
  const AppToast(
    this.text, {
    Key? key,
    this.padding,
    this.alignment,
    this.icon,
    this.contentColor,
    this.textStyle,
  }) : super(key: key);

  final String text;
  final EdgeInsets? padding;
  final Alignment? alignment;
  final IconData? icon;
  final Color? contentColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    IconData _platformIcon =
        Platform.isIOS ? CupertinoIcons.check_mark : Icons.check;
    TextStyle? _platformTextStyle = Platform.isIOS
        ? CupertinoTheme.of(context)
            .textTheme
            .textStyle
            .copyWith(color: contentColor ?? AppColors.white)
        : Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: contentColor ?? AppColors.white);

    return SafeArea(
      child: Center(
        child: Align(
          alignment: alignment ?? Alignment.topCenter,
          child: Padding(
            padding: padding ?? const EdgeInsets.only(top: 120),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: AppColors.black.withOpacity(0.87),
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      icon ?? _platformIcon,
                      color: contentColor ?? AppColors.white,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      text,
                      style: textStyle ?? _platformTextStyle,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
