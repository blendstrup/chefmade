import 'package:cloud_firestore/cloud_firestore.dart' show DocumentReference;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/menu_model.dart';
import '../data/models/restaurant_model.dart';
import 'repository_providers.dart';

final restaurantProvider = StreamProvider.autoDispose<Restaurant>(
  (ref) => ref.watch(firestoreRepositoryProvider).getRestaurant(
        userId: ref.watch(authRepositoryProvider).getCurrentUser()!.uid,
      ),
);

final authStateProvider = StreamProvider.autoDispose(
  (ref) => ref.watch(authRepositoryProvider).authStateChanges(),
);

final menuProvider = FutureProvider.family
    .autoDispose<Menu, DocumentReference>((ref, menuRef) async {
  final initialMenu =
      await ref.watch(firestoreRepositoryProvider).getMenu(menuRef: menuRef);
  if (initialMenu.menuImagePath != null) {
    final imagePath = await ref
        .watch(storageRepositoryProvider)
        .getImageUrl(initialMenu.menuImagePath!);
    return initialMenu.copyWith(menuImagePath: imagePath);
  } else {
    return initialMenu;
  }
});
