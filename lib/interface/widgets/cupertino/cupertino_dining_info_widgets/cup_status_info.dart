import 'package:flutter/cupertino.dart';

import '../../../colors.dart';
import '../cup_material.dart';

class CupStatusInfo extends StatelessWidget {
  const CupStatusInfo({Key? key, required this.status}) : super(key: key);

  final String status;

  @override
  Widget build(BuildContext context) {
    final _statusItems = _getStatusItems(status);

    return CupMaterial(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(_statusItems[0], color: _statusItems[1]),
              const SizedBox(width: 10),
              Text(_statusItems[2]),
            ],
          ),
        ),
      ],
    );
  }

  List<dynamic> _getStatusItems(String status) {
    switch (status) {
      case 'requested':
        // flag, question, bell, person_crop, ellipsis
        return [
          CupertinoIcons.ellipsis_circle_fill,
          AppColors.lightGrey3,
          'Requested',
        ];
      case 'upcoming':
        // info, ellipsis, person_crop, calendar, clock
        return [
          CupertinoIcons.clock_fill,
          AppColors.yellow,
          'Upcoming',
        ];
      case 'completed':
        // checkmark, money_dollar, money_euro, heart
        return [
          CupertinoIcons.checkmark_circle_fill,
          AppColors.green,
          'Completed',
        ];
      case 'cancelled':
        // xmark, slash, trash, heart_slash, minus, divide
        return [
          CupertinoIcons.xmark_circle_fill,
          AppColors.red,
          'Cancelled or declined',
        ];
      default:
        return [
          CupertinoIcons.exclamationmark_circle_fill,
          AppColors.lightGrey3,
          'Unknown',
        ];
    }
  }
}
