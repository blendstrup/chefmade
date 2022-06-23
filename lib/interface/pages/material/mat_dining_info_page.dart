import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//import '../../state/repository_providers.dart';
import '../../colors.dart';
import '../../widgets/common/base_page.dart';
import '../../widgets/material/mat_sliver_appbar.dart';

class MatDiningInfoPage extends StatelessWidget {
  const MatDiningInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BasePage(
        appBar: const MatSliverAppBar(text: 'Dining #'),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverFillRemaining(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer(builder: (context, ref, _) {
                    //final _emailRepository = ref.watch(emailRepositoryProvider);

                    return TextButton(
                      child: const Text('Export CSV file'),
                      onPressed: () => print(''),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showSnackBar(String text, BuildContext context) {
    //'CSV filen er blevet tilsendt din mail'
    final _snackBar = SnackBar(
      content: Text(text),
      backgroundColor: AppColors.green,
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(_snackBar);
  }
}
