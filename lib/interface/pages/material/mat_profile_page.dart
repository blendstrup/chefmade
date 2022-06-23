import 'package:flutter/material.dart';

import '../../widgets/common/base_page.dart';
import '../../widgets/material/mat_sliver_appbar.dart';

class MatProfilePage extends StatelessWidget {
  const MatProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BasePage(
        appBar: const MatSliverAppBar(text: 'Profile'),
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
