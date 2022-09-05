import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../interface/widgets/cupertino/cup_bottom_sheet.dart';
import '../../interface/widgets/cupertino/cupertino_dinings_list_widgets/cup_status_filter.dart';

final cupModalOpenProvider = StateNotifierProvider<CupModalOpenNotifier, bool>(
  (ref) => CupModalOpenNotifier(),
);

class CupModalOpenNotifier extends StateNotifier<bool> {
  CupModalOpenNotifier() : super(false);

  void showCupertinoModalBottomSheet(BuildContext context) async {
    state = true;
    await AppCupertinoScaffold.showCupertinoModalBottomSheet(
      context: context,
      useRootNavigator: true,
      duration: const Duration(milliseconds: 250),
      builder: (context) => const CupStatusFilter(),
    );
    state = false;
  }
}
