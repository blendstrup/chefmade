import 'package:flutter/cupertino.dart';

import '../../../../data/models/dining_model.dart';

class CupAdditionalInfo extends StatelessWidget {
  const CupAdditionalInfo({Key? key, required this.dining}) : super(key: key);

  final Dining dining;

  @override
  Widget build(BuildContext context) {
    CupertinoThemeData _theme = CupertinoTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Additional',
          style: _theme.textTheme.textStyle.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 3),
        if (dining.sideOrders!.isNotEmpty) ...[
          for (final side in dining.sideOrders!) ...[
            Text(
              side.title,
              softWrap: true,
              style: _theme.textTheme.textStyle.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              side.description,
              softWrap: true,
            ),
            if (side != dining.sideOrders!.last) const SizedBox(height: 15),
          ],
          const SizedBox(height: 20),
        ] else ...[
          const Text('No side orders.'),
          const SizedBox(height: 20),
        ],
      ],
    );
  }
}
