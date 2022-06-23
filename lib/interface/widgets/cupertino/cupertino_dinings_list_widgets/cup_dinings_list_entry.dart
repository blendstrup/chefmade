import 'package:flutter/cupertino.dart';

import '../../../../data/models/dining_model.dart';
import '../../../pages/cupertino/cup_dining_info_page.dart';

class CupDiningsListEntry extends StatelessWidget {
  const CupDiningsListEntry({
    Key? key,
    required this.icon,
    required this.dining,
  }) : super(key: key);

  final Icon icon;
  final Dining dining;

  @override
  Widget build(BuildContext context) {
    TextStyle _textStyle = CupertinoTheme.of(context).textTheme.textStyle;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).push(CupertinoPageRoute(
        builder: (context) => CupDiningInfoPage(dining),
      )),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: CupertinoFormRow(
          padding: const EdgeInsets.only(left: 10),
          prefix: icon,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${dining.customerFirstName} ${dining.customerLastName}',
                        style: _textStyle.copyWith(fontWeight: FontWeight.w800),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${dining.venueStreet} ${dining.venueStreetNumber}, ${dining.venueCity}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: _textStyle,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'd. ${dining.eventDate.day}',
                        style: _textStyle,
                        overflow: TextOverflow.clip,
                      ),
                      const SizedBox(width: 5),
                      Icon(CupertinoIcons.chevron_right,
                          color: _textStyle.color),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
