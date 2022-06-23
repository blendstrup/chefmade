import 'package:flutter/material.dart';

import '../../colors.dart';

class MatElevatedButton extends StatelessWidget {
  const MatElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  final void Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    bool _isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return ElevatedButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 15,
        ),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .button!
              .copyWith(color: _isDark ? AppColors.black : AppColors.white),
        ),
      ),
    );
  }
}
