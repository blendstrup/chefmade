import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/dining_model.dart';
import '../../utils/file_utilities.dart';
import 'dinings_state.dart';

class DiningsStateNotifier extends StateNotifier<DiningsState> {
  DiningsStateNotifier() : super(const DiningsInitial());

  void setState(DiningsState newState) {
    state = newState;
  }

  Map<String, List<Dining>> groupAndFilterDinings(
    List<Dining> dinings,
    Map<String, bool> currentStatus,
  ) {
    List<Dining> filteredList = [
      ...dinings.where((dining) {
        if (currentStatus[dining.status] == true) {
          return true;
        } else {
          return false;
        }
      }).toList()
    ];

    return groupBy(
      filteredList.reversed,
      (Dining dining) => FileUtilities.formatMonthYear(dining.eventDate),
    );
  }
}
