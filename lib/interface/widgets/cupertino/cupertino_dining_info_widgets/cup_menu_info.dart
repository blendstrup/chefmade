import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/models/menu_model.dart';
import '../../../../state/restaurant_providers.dart';
import '../../common/base_async_builder.dart';
import '../cup_material.dart';
import 'cup_menu_info_loaded.dart';

class CupMenuInfo extends StatelessWidget {
  const CupMenuInfo({Key? key, required this.menu}) : super(key: key);

  final DocumentReference menu;

  @override
  Widget build(BuildContext context) {
    return CupMaterial(
      margin: const EdgeInsets.all(0),
      children: [
        Consumer(
          builder: (context, ref, _) {
            return BaseAsyncBuilder<Menu>.future(
              future: ref.watch(menuProvider(menu).future),
              onWaiting: Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Menu loading'),
                    SizedBox(width: 10),
                    CupertinoActivityIndicator(),
                  ],
                ),
              ),
              onData: (menu) => CupMenuInfoLoaded(menu),
            );
          },
        ),
      ],
    );
  }
}
