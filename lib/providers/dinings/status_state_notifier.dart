import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'status_state.dart';

class StatusStateNotifier extends StateNotifier<StatusState> {
  StatusStateNotifier()
      : super(const StatusInitial({
          'requested': false,
          'upcoming': true,
          'completed': true,
          'cancelled': false,
        }));

  void toggle(String item) {
    Map<String, bool> current = Map.from(state.status);
    current[item] = !current[item]!;
    state = StatusSelected(current);
  }
}
