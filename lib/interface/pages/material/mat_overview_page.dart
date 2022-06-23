import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/repository_providers.dart';
import '../../widgets/common/base_page.dart';
import '../../widgets/material/mat_elevated_button.dart';
import '../../widgets/material/mat_sliver_appbar.dart';

class MatOverviewPage extends StatelessWidget {
  const MatOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);

    return Scaffold(
      body: BasePage(
        appBar: const MatSliverAppBar(text: 'Overview'),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverFillRemaining(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Overview'),
                  const SizedBox(height: 20),
                  Text(
                    'Headline5',
                    style: _theme.textTheme.headline5,
                  ),
                  const SizedBox(height: 60),
                  Consumer(
                    builder: (context, ref, _) => MatElevatedButton(
                      text: 'Log out',
                      onPressed: () => showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 20),
                            ListTile(
                              title: Text(
                                'Log out',
                                style: _theme.textTheme.button,
                              ),
                              leading: const Icon(Icons.logout),
                              onTap: () {
                                Navigator.of(context).pop();
                                ref.watch(authRepositoryProvider).logout();
                              },
                            ),
                            ListTile(
                              title: Text(
                                'Cancel',
                                style: _theme.textTheme.button,
                              ),
                              leading: const Icon(Icons.cancel),
                              onTap: () => Navigator.of(context).pop(),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
