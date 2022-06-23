import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/dinings/cup_modal_provider.dart';
import '../../widgets/common/base_page.dart';
import '../../widgets/cupertino/cupertino_dinings_list_widgets/cup_dinings_list.dart';

class CupDiningsListPage extends StatelessWidget {
  const CupDiningsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CupertinoThemeData _theme = CupertinoTheme.of(context);

    return CupertinoPageScaffold(
      child: BasePage(
        appBar: Consumer(builder: (context, ref, _) {
          return CupertinoSliverNavigationBar(
            largeTitle: const Text('Dinings'),
            trailing: GestureDetector(
              child: Text('Status', style: _theme.textTheme.actionTextStyle),
              onTap: () async {
                ref
                    .watch(cupModalOpenProvider.notifier)
                    .showCupertinoModalBottomSheet(context);
              },
            ),
          );
        }),
        slivers: const [CupDiningsList()],
      ),
    );
  }
}
