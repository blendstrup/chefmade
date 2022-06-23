import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/dinings/dinings_providers.dart';
import '../../../../providers/dinings/dinings_state.dart';
import '../../../colors.dart';
import 'cup_dinings_list_entry.dart';
import 'cup_dinings_list_month.dart';

class CupDiningsList extends ConsumerWidget {
  const CupDiningsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(diningsProvider);

    if (state is DiningsInitial) {
      return const SliverFillRemaining(
        child: Center(child: CupertinoActivityIndicator()),
      );
    } else if (state is DiningsLoading) {
      return const SliverFillRemaining(
        child: Center(child: CupertinoActivityIndicator()),
      );
    } else if (state is DiningsLoaded) {
      if (state.dinings.isEmpty) {
        return const SliverFillRemaining(
          child: Center(child: Text('No dinings found')),
        );
      } else {
        return SliverPadding(
          padding: const EdgeInsets.only(bottom: 80),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final diningsMonth = state.dinings.entries.toList()[index];
                return CupDiningsListMonth(
                  title: diningsMonth.key,
                  count: '(${diningsMonth.value.length})',
                  month: diningsMonth.value.first.eventDate.month,
                  childrenPadding: const EdgeInsets.only(
                    bottom: 20,
                    left: 20,
                    right: 20,
                  ),
                  children: [
                    ...state.dinings.entries.toList()[index].value.reversed.map(
                          (e) => CupDiningsListEntry(
                            icon: _getIcon(e.status),
                            dining: e,
                          ),
                        ),
                  ],
                );
              },
              childCount: state.dinings.entries.length,
            ),
          ),
        );
      }
    } else {
      return const SizedBox.shrink();
    }
  }

  Icon _getIcon(String status) {
    switch (status) {
      case 'requested':
        // flag, question, bell, person_crop, ellipsis
        return const Icon(
          CupertinoIcons.ellipsis_circle_fill,
          color: AppColors.lightGrey3,
        );
      case 'upcoming':
        // info, ellipsis, person_crop, calendar, clock
        return const Icon(
          CupertinoIcons.clock_fill,
          color: AppColors.yellow,
        );
      case 'completed':
        // checkmark, money_dollar, money_euro, heart
        return const Icon(
          CupertinoIcons.checkmark_circle_fill,
          color: AppColors.green,
        );
      case 'cancelled':
        // xmark, slash, trash, heart_slash, minus, divide
        return const Icon(
          CupertinoIcons.xmark_circle_fill,
          color: AppColors.red,
        );
      default:
        return const Icon(
          CupertinoIcons.exclamationmark_circle_fill,
          color: AppColors.lightGrey3,
        );
    }
  }
}
