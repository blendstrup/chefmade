import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/restaurant_model.dart';
import '../../../providers/repository_providers.dart';
import '../../../providers/restaurant_providers.dart';
import '../../widgets/common/base_async_builder.dart';
import '../../widgets/common/base_page.dart';

class CupOverviewPage extends StatelessWidget {
  const CupOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: BasePage(
        appBar: const CupertinoSliverNavigationBar(
          largeTitle: Text('Overview'),
          trailing: LogOutButton(),
        ),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverFillRemaining(
              child: Consumer(
                builder: (context, ref, _) {
                  return BaseAsyncBuilder<Restaurant>.stream(
                    stream: ref.watch(restaurantProvider.stream),
                    onWaiting: const Center(
                      child: CupertinoActivityIndicator(),
                    ),
                    onNoData: const Center(child: CupertinoActivityIndicator()),
                    onData: (Restaurant data) => Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              data.name,
                              style: CupertinoTheme.of(context)
                                  .textTheme
                                  .navTitleTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LogOutButton extends StatelessWidget {
  const LogOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) => GestureDetector(
        child: Text(
          'Log out',
          style: CupertinoTheme.of(context).textTheme.actionTextStyle,
        ),
        onTap: () => showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) => CupertinoActionSheet(
            actions: <CupertinoActionSheetAction>[
              CupertinoActionSheetAction(
                child: const Text('Log out'),
                onPressed: () {
                  Navigator.of(context).pop();
                  ref.watch(authRepositoryProvider).logout();
                },
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              child: const Text('Cancel'),
              onPressed: Navigator.of(context).pop,
            ),
          ),
        ),
      ),
    );
  }
}
