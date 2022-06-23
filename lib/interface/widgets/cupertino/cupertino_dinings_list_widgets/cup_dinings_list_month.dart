import 'package:flutter/cupertino.dart';

import '../../../colors.dart';
import '../../common/expandable_section.dart';

class CupDiningsListMonth extends StatelessWidget {
  const CupDiningsListMonth({
    Key? key,
    required this.title,
    required this.count,
    required this.children,
    required this.month,
    this.childrenPadding = const EdgeInsets.all(0),
  }) : super(key: key);

  final String title;
  final String count;
  final int month;
  final List<Widget> children;
  final EdgeInsets childrenPadding;

  @override
  Widget build(BuildContext context) {
    CupertinoThemeData _theme = CupertinoTheme.of(context);

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: CupertinoColors.separator,
            width: 0.5,
          ),
        ),
      ),
      child: ExpandableSection(
        title: Text(
          title,
          style: _theme.textTheme.dateTimePickerTextStyle,
        ),
        trailingPrefix: Text(
          count,
          style: _theme.textTheme.dateTimePickerTextStyle,
        ),
        titlePadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        maintainState: true,
        initiallyExpanded: month == DateTime.now().month,
        childrenPadding: childrenPadding,
        children: [
          CupertinoFormSection.insetGrouped(
            margin: const EdgeInsets.all(0),
            backgroundColor: _theme.scaffoldBackgroundColor,
            children: children,
            decoration: BoxDecoration(
              color: const CupertinoDynamicColor.withBrightness(
                color: AppColors.white,
                darkColor: AppColors.darkGrey2,
              ).resolveFrom(context),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ],
      ),
    );
  }
}
