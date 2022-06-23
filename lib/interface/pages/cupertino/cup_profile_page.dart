import 'package:flutter/cupertino.dart';

import '../../widgets/common/base_page.dart';

class CupProfilePage extends StatelessWidget {
  const CupProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: BasePage(
        appBar: const CupertinoSliverNavigationBar(
          largeTitle: Text('Profile'),
        ),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverFillRemaining(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Profile'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
