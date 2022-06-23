import 'package:flutter/material.dart';

import '../../colors.dart';

class Error extends StatelessWidget {
  const Error({
    Key? key,
    required this.error,
    this.stackTrace,
  }) : super(key: key);

  final String error;
  final StackTrace? stackTrace;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: AppColors.yellow,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Icon(
              Icons.error_outline,
              color: AppColors.red,
              size: 60,
            ),
            const SizedBox(height: 20),
            Text('Error: $error'),
            const SizedBox(height: 10),
            if (stackTrace != null) Text('Stack trace: $stackTrace'),
          ],
        ),
      ),
    );
  }
}
