import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/menu_model.dart';
import '../../../../state/restaurant_providers.dart';
import '../../common/expandable_section.dart';
import '../../common/image.dart';
import '../cup_chip.dart';
import '../cup_divider.dart';
import 'cup_menu_info_element.dart';

class CupMenuInfoLoaded extends StatelessWidget {
  const CupMenuInfoLoaded(this.menu, {Key? key}) : super(key: key);

  final Menu menu;
  final String _noMenuImage = 'http://via.placeholder.com/700x200';

  @override
  Widget build(BuildContext context) {
    return ExpandableSection(
      title: Text(
        menu.title,
        style: CupertinoTheme.of(context)
            .textTheme
            .textStyle
            .copyWith(fontWeight: FontWeight.w800),
        overflow: TextOverflow.ellipsis,
      ),
      centerTitle: true,
      titlePadding: const EdgeInsets.all(10),
      childrenPadding: const EdgeInsets.symmetric(horizontal: 20),
      childrenAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        AppNetworkImage(
          imageUrl: menu.menuImagePath ?? _noMenuImage,
          height: 100, //120?
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 20),
        CupMenuInfoElement(title: 'Description', text: menu.description),
        //const SizedBox(height: 20),
        //MenuInfoElement(
        //  title: 'Extra information',
        //  text: menu.extraInformation,
        //),
        const CupDivider.long(
          margin: EdgeInsets.only(top: 15, bottom: 10),
        ),
        Consumer(
          builder: (context, ref, _) {
            final _restaurant = ref.watch(restaurantProvider).value;
            return Column(
              children: [
                CupMenuInfoElement(
                  title: 'Cook brings',
                  spacing: 5,
                  child: Wrap(
                    runSpacing: 5,
                    spacing: 5,
                    children: [
                      for (final e in _restaurant!.cookBrings.entries)
                        if (e.value)
                          CupChip(
                            borderRadius: 5,
                            child: Text(
                              toBeginningOfSentenceCase(e.key)!.splitMapJoin(
                                RegExp(r'(?<=[a-z])(?=[A-Z])'),
                                onMatch: (str) => ' ',
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                          ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                CupMenuInfoElement(
                  title: 'Cook needs',
                  spacing: 5,
                  child: Wrap(
                    runSpacing: 5,
                    spacing: 5,
                    children: [
                      for (final e in _restaurant.cookNeeds.entries)
                        if (e.value)
                          CupChip(
                            borderRadius: 5,
                            child: Text(
                              toBeginningOfSentenceCase(e.key)!.splitMapJoin(
                                RegExp(r'(?<=[a-z])(?=[A-Z])'),
                                onMatch: (str) => ' ',
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                          ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        if (menu.servings != null) ...[
          const CupDivider.long(
            margin: EdgeInsets.only(top: 20, bottom: 10),
          ),
          CupMenuInfoElement(
            title: 'Servings (${menu.servings!.length})',
            centerTitle: true,
            children: [
              for (final serving in menu.servings!.sortedBy(
                (e) => e.order,
              )) ...[
                CupMenuInfoElement(
                  title: serving.title,
                  text: serving.description,
                ),
                if (serving != menu.servings!.sortedBy((e) => e.order).last)
                  const SizedBox(height: 10),
              ],
            ],
          ),
        ],
        const SizedBox(height: 30),
      ],
    );
  }
}
