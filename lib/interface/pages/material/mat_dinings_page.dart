import 'package:flutter/material.dart';

import '../../widgets/common/base_page.dart';
import '../../widgets/material/mat_sliver_appbar.dart';

class MatDiningsPage extends StatelessWidget {
  const MatDiningsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BasePage(
        appBar: const MatSliverAppBar(text: 'Dinings'),
        slivers: [
          SliverFillRemaining(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: const Text('Open dining'),
                  onPressed: () => Navigator.of(context).pushNamed('dining'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
