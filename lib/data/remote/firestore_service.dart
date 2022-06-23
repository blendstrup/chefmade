import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static Stream<DocumentSnapshot> getRestaurantStream({
    required FirebaseFirestore firestore,
    required String userId,
  }) {
    return firestore.collection('restaurants').doc(userId).snapshots();
  }

  static Stream<QuerySnapshot> getDiningsStream({
    required FirebaseFirestore firestore,
    required String userId,
  }) {
    return firestore
        .collection('restaurants')
        .doc(userId)
        .collection('dinings')
        .snapshots();
  }

  static Future<void> updateDiningNotes({
    required FirebaseFirestore firestore,
    required String restaurantId,
    required String diningId,
    required String notes,
  }) {
    return firestore
        .collection('restaurants')
        .doc(restaurantId)
        .collection('dinings')
        .doc(diningId)
        .update({'notes': notes})
        .then((value) => print('User Updated'))
        .catchError((error) => print('Failed to update user: $error'));
  }

  static Future<QuerySnapshot> getSideOrders({
    required DocumentReference diningRef,
  }) {
    return diningRef.collection('sideOrders').get();
  }

  static Future<DocumentSnapshot> getMenu({
    required DocumentReference menuRef,
  }) {
    return menuRef.get();
  }

  static Future<QuerySnapshot> getServings({
    required DocumentReference menuRef,
  }) {
    return menuRef.collection('servings').get();
  }
}
