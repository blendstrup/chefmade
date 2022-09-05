import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../../data/models/dining_model.dart';
import '../../../state/repository_providers.dart';
import '../../../state/restaurant_providers.dart';
import '../../../utils/file_utilities.dart';
import '../../widgets/common/base_page.dart';
import '../../widgets/common/toast.dart';
import '../../widgets/cupertino/cup_divider.dart';
import '../../widgets/cupertino/cup_text_field.dart';
import '../../widgets/cupertino/cupertino_dining_info_widgets/cup_additional_info.dart';
import '../../widgets/cupertino/cupertino_dining_info_widgets/cup_export_action_sheet.dart';
import '../../widgets/cupertino/cupertino_dining_info_widgets/cup_info_section.dart';
import '../../widgets/cupertino/cupertino_dining_info_widgets/cup_menu_info.dart';
import '../../widgets/cupertino/cupertino_dining_info_widgets/cup_no_menu_info.dart';
import '../../widgets/cupertino/cupertino_dining_info_widgets/cup_status_info.dart';

class CupDiningInfoPage extends StatefulWidget {
  const CupDiningInfoPage(this.dining, {Key? key}) : super(key: key);

  final Dining dining;

  @override
  State<CupDiningInfoPage> createState() => _CupDiningInfoPageState();
}

class _CupDiningInfoPageState extends State<CupDiningInfoPage> {
  OverlaySupportEntry? _overlaySupportEntry;

  @override
  Widget build(BuildContext context) {
    String _month = FileUtilities.formatAbrMonth(widget.dining.eventDate);
    String _day = FileUtilities.formatDay(widget.dining.eventDate);

    CupertinoThemeData _theme = CupertinoTheme.of(context);

    Dining _dining = widget.dining;

    return WillPopScope(
      onWillPop: () async {
        if (_overlaySupportEntry != null) _overlaySupportEntry!.dismiss();
        return true;
      },
      child: CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        child: BasePage(
          removeFocusOnTap: true,
          appBar: CupertinoSliverNavigationBar(
            largeTitle: Text('Dining $_day. $_month'),
            previousPageTitle: 'Dinings',
            trailing: GestureDetector(
              child: Text('Export', style: _theme.textTheme.actionTextStyle),
              onTap: () => _showExportModal(_dining),
            ),
          ),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 20),
              sliver: SliverList(
                delegate: SliverChildListDelegate.fixed(
                  [
                    const SizedBox(height: 20),
                    CupStatusInfo(status: _dining.status),
                    const CupDivider.long(
                      margin: EdgeInsets.only(top: 10, bottom: 20),
                    ),
                    CupInfoSection(
                      icon: CupertinoIcons.person_crop_square,
                      title: 'Customer information',
                      textGroups: [
                        TextGrouping(
                          title: 'Name',
                          description:
                              '${_dining.customerFirstName} ${_dining.customerLastName}',
                        ),
                        TextGrouping(
                          title: 'Email',
                          description: _dining.customerEmail,
                        ),
                        TextGrouping(
                          title: 'Phone',
                          description: '+45 ${_dining.customerPhone}',
                        ),
                      ],
                    ),
                    const CupDivider.long(
                      margin: EdgeInsets.symmetric(vertical: 20),
                    ),
                    CupInfoSection(
                      icon: CupertinoIcons.square_list,
                      title: 'Dining information',
                      textGroups: [
                        TextGrouping(
                            title: 'Address',
                            description:
                                '${_dining.venueStreet} ${_dining.venueStreetNumber}, ${_dining.venueZipCode} ${_dining.venueCity}'),
                        TextGrouping(
                          title: 'Number of guests',
                          description: _dining.numberOfGuests.toString(),
                        ),
                        TextGrouping(
                          title: 'Arrival time',
                          description:
                              FileUtilities.formatTime(_dining.arrivalTime!),
                        ),
                        TextGrouping(
                          title: 'First serving time',
                          description:
                              FileUtilities.formatTime(_dining.serveTime),
                        ),
                      ],
                      children: [
                        if (_dining.sideOrders != null) ...[
                          const SizedBox(height: 20),
                          CupAdditionalInfo(dining: _dining),
                        ],
                        if (_dining.menu != null)
                          CupMenuInfo(menu: _dining.menu!),
                        if (_dining.menu == null) const CupNoMenuInfo(),
                      ],
                    ),
                    const CupDivider.long(
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                    ),
                    CupInfoSection(
                      icon: CupertinoIcons.chart_bar_square,
                      title: 'Business information',
                      textGroups: [
                        TextGrouping(
                          title: 'Menu price',
                          description:
                              '${_dining.pricePerPerson} kr. pr. person',
                        ),
                        if (_dining.sideOrders!.isNotEmpty)
                          TextGrouping.list(
                            title: 'Additional income',
                            descriptionList: [
                              for (final side in _dining.sideOrders!)
                                if (side.basedOnGuests)
                                  '${side.title}: ${side.price} kr. pr. person'
                                else
                                  '${side.title}: ${side.price} kr.'
                            ],
                          ),
                        TextGrouping.list(
                          title: 'Total',
                          descriptionList: [
                            for (final side in _dining.sideOrders!)
                              if (side.basedOnGuests)
                                '${_dining.numberOfGuests * side.price} kr. for ${_dining.numberOfGuests} x ${side.title}'
                              else
                                '${side.price} kr. for ${side.title}',
                            '${_dining.numberOfGuests * _dining.pricePerPerson!} kr. for ${_dining.numberOfGuests} x Menu',
                            getTotal(_dining),
                          ],
                        ),
                      ],
                    ),
                    const CupDivider.long(
                      margin: EdgeInsets.symmetric(vertical: 20),
                    ),
                    CupInfoSection(
                      icon: CupertinoIcons.equal_square,
                      title: 'Notes',
                      children: [
                        const SizedBox(height: 10),
                        Consumer(
                          builder: (context, ref, _) => CupTextField(
                            maintainState: true,
                            scrollPadding: const EdgeInsets.only(bottom: 120),
                            initial: _dining.notes,
                            placeholder: 'Add notes to this dining here...',
                            onSave: (notes) => ref
                                .watch(firestoreRepositoryProvider)
                                .updateDiningNotes(
                                  restaurantId: ref
                                      .watch(restaurantProvider)
                                      .value!
                                      .docId!,
                                  diningId: _dining.docId!,
                                  notes: notes,
                                ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                    const CupDivider.long(
                      margin: EdgeInsets.symmetric(vertical: 20),
                    ),
                    Consumer(builder: (context, ref, _) {
                      return CupertinoButton(
                        onPressed: () {
                          String _name =
                              ref.watch(restaurantProvider).value!.name;
                          ref.watch(emailRepositoryProvider).openMail(
                                subject:
                                    '$_name anmodning angående: Private Dining - ${FileUtilities.formatDate(_dining.eventDate)}',
                                body:
                                    'Hej chefmade\n\n[Skriv din besked her]\n\nMvh\n$_name',
                                recipient: 'info@chefmade.dk',
                              );
                        },
                        child: Text(
                          'Contact chefmade\nabout this dining',
                          textAlign: TextAlign.center,
                          style: _theme.textTheme.actionTextStyle,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getTotal(Dining dining) {
    if (dining.status == 'cancelled') return '\nTotal: Cancelled or declined.';

    num menuPrice = dining.numberOfGuests * dining.pricePerPerson!;
    num additionlPrice = 0;

    for (final e in dining.sideOrders!) {
      if (e.basedOnGuests) {
        additionlPrice += e.price * dining.numberOfGuests;
      } else {
        additionlPrice += e.price;
      }
    }

    return '\nTotal: ${menuPrice + additionlPrice} kr.';
  }

  void _showExportModal(Dining dining) async {
    final result = await showCupertinoModalPopup<bool>(
        context: context,
        builder: (BuildContext context) {
          return CupExportActionSheet(dining: dining);
        });
    if (result ?? false) {
      _overlaySupportEntry = showOverlay(
        (context, t) => Opacity(
          opacity: t,
          child: const AppToast('Check your email'),
        ),
      );
    }
  }
}
