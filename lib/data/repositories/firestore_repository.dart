import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/dining_model.dart';
import '../models/menu_model.dart';
import '../models/restaurant_model.dart';
import '../models/serving_model.dart';
import '../models/side_order_model.dart';
import '../remote/firestore_service.dart';

abstract class IFirestoreRepository {
  Stream<Restaurant> getRestaurant({required String userId});

  Stream<List<Dining>> getDinings({required String userId});

  Future<Menu> getMenu({required DocumentReference menuRef});
}

class FirestoreRepository implements IFirestoreRepository {
  const FirestoreRepository(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Stream<Restaurant> getRestaurant({required String userId}) {
    return FirestoreService.getRestaurantStream(
      firestore: _firestore,
      userId: userId,
    ).map(
      (e) => Restaurant.fromFirestore(e),
    );
  }

  @override
  Stream<List<Dining>> getDinings({required String userId}) {
    return FirestoreService.getDiningsStream(
      firestore: _firestore,
      userId: userId,
    ).asyncMap(
      ((snapshot) async {
        return Future.wait(snapshot.docs
            .map((document) async => Dining.fromFirestore(document).copyWith(
                  sideOrders: await FirestoreService.getSideOrders(
                    diningRef: document.reference,
                  ).then(
                    (snapshot) => snapshot.docs
                        .map((doc) => SideOrder.fromFirestore(doc))
                        .toList(),
                  ),
                ))
            .toList());
      }),
    );
  }

  void updateDiningNotes({
    required String restaurantId,
    required String diningId,
    required String notes,
  }) {
    FirestoreService.updateDiningNotes(
      firestore: _firestore,
      restaurantId: restaurantId,
      diningId: diningId,
      notes: notes,
    );
  }

  @override
  Future<Menu> getMenu({required DocumentReference menuRef}) {
    return FirestoreService.getMenu(menuRef: menuRef).then(
      (value) async {
        return Menu.fromFirestore(value).copyWith(
          servings: await FirestoreService.getServings(menuRef: menuRef).then(
            (snapshot) {
              return snapshot.docs
                  .map((doc) => Serving.fromFirestore(doc))
                  .toList();
            },
          ),
        );
      },
    );
  }
}
