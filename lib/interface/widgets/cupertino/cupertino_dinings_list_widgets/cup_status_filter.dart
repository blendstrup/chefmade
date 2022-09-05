import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../state/dinings/dinings_providers.dart';
import '../../../colors.dart';

class CupStatusFilter extends StatelessWidget {
  const CupStatusFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CupertinoThemeData _theme = CupertinoTheme.of(context);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        backgroundColor: _theme.scaffoldBackgroundColor,
        border: const Border.fromBorderSide(BorderSide.none),
        trailing: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Text(
            'Done',
            style: _theme.textTheme.actionTextStyle,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Status',
              style: _theme.textTheme.navLargeTitleTextStyle,
            ),
          ),
          Consumer(
            builder: (context, ref, _) {
              final selectedStatus = ref.watch(statusProvider).status;

              return CupertinoFormSection.insetGrouped(
                backgroundColor: _theme.scaffoldBackgroundColor,
                decoration: BoxDecoration(
                  color: const CupertinoDynamicColor.withBrightness(
                    color: AppColors.white,
                    darkColor: AppColors.darkGrey2,
                  ).resolveFrom(context),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                header: const Text('Select types of dinings to show'),
                children: selectedStatus.entries
                    .map((e) => StatusItem(mapKey: e.key))
                    .toList(),
              );
            },
          ),
          const Spacer(),
          const ShowHideDinings(),
        ],
      ),
    );
  }
}

class StatusItem extends ConsumerWidget {
  const StatusItem({
    Key? key,
    required this.mapKey,
  }) : super(key: key);

  final String mapKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextStyle _boldText = CupertinoTheme.of(context)
        .textTheme
        .textStyle
        .copyWith(fontWeight: FontWeight.w800);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => ref.watch(statusProvider.notifier).toggle(mapKey),
      child: CupertinoFormRow(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        prefix: ref.watch(statusProvider).status[mapKey]!
            ? const Icon(
                CupertinoIcons.check_mark_circled_solid,
                color: AppColors.blue,
              )
            : const Icon(CupertinoIcons.circle),
        child: Row(
          children: [
            const SizedBox(width: 10),
            Text(
              _getText(mapKey),
              style: _boldText,
            ),
          ],
        ),
      ),
    );
  }

  String _getText(String key) {
    switch (key) {
      case 'requested':
        return 'Requested';
      case 'upcoming':
        return 'Upcoming';
      case 'completed':
        return 'Completed';
      case 'cancelled':
        return 'Cancelled & Declined';
      default:
        return '';
    }
  }
}

class ShowHideDinings extends ConsumerWidget {
  const ShowHideDinings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _selectedStatus = ref.watch(statusProvider).status;
    bool _allSelected = _selectedStatus.entries.every((e) => e.value == true);

    CupertinoThemeData _theme = CupertinoTheme.of(context);
    TextStyle _toggleStyle = _theme.textTheme.textStyle.copyWith(
      color: AppColors.blue,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Center(
        child: GestureDetector(
          onTap: () {
            final notifier = ref.watch(statusProvider.notifier);
            _allSelected
                ? _selectedStatus.forEach((key, value) {
                    notifier.toggle(key);
                  })
                : _selectedStatus.forEach((key, value) {
                    if (value == false) {
                      notifier.toggle(key);
                    }
                  });
          },
          child: _allSelected
              ? Text('Hide all dinings', style: _toggleStyle)
              : Text('Show all dinings', style: _toggleStyle),
        ),
      ),
    );
  }
}
