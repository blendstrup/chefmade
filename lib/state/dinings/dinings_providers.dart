import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/dining_model.dart';
import '../repository_providers.dart';
import 'dinings_state.dart';
import 'dinings_state_notifier.dart';
import 'status_state.dart';
import 'status_state_notifier.dart';

final statusProvider = StateNotifierProvider<StatusStateNotifier, StatusState>(
  (ref) => StatusStateNotifier(),
);

final diningsProvider =
    StateNotifierProvider.autoDispose<DiningsStateNotifier, DiningsState>(
  (ref) {
    final dinings = ref.watch(diningsStreamProvider).value;
    final currentStatus = ref.watch(statusProvider);

    final notifier = DiningsStateNotifier();

    if (dinings != null) {
      notifier.setState(const DiningsLoading());

      final groupedFilteredDinings = notifier.groupAndFilterDinings(
        dinings,
        currentStatus.status,
      );

      notifier.setState(DiningsLoaded(groupedFilteredDinings));
    }

    return notifier;
  },
);

final diningsStreamProvider = StreamProvider.autoDispose<List<Dining>>(
  (ref) => ref
      .watch(firestoreRepositoryProvider)
      .getDinings(
        userId: ref.watch(authRepositoryProvider).getCurrentUser()!.uid,
      )
      .asyncMap(
    (list) {
      list.sort((a, b) => a.eventDate.compareTo(b.eventDate));
      return list;
    },
  ),
);
