import 'dart:convert' show json;

import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;
import 'package:equatable/equatable.dart';

class SideOrder extends Equatable {
  const SideOrder({
    required this.title,
    required this.description,
    required this.docId,
    required this.price,
    required this.basedOnGuests,
  });

  factory SideOrder.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic> doc = snapshot.data()! as Map<String, dynamic>;

    return SideOrder.fromMap(doc, docId: snapshot.id);
  }

  factory SideOrder.fromJson(String source) =>
      SideOrder.fromMap(json.decode(source));

  factory SideOrder.fromMap(Map<String, dynamic> map, {String? docId}) {
    try {
      return SideOrder(
        title: map['title'],
        description: map['description'],
        docId: docId ?? map['docId'],
        price: map['price'],
        basedOnGuests: map['basedOnGuests'],
      );
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  final String description;
  final String? docId;
  final String title;
  final num price;
  final bool basedOnGuests;

  @override
  List<Object?> get props => [description, docId, title, price, basedOnGuests];

  @override
  bool get stringify => true;

  SideOrder copyWith({
    String? title,
    String? description,
    String? docId,
    num? price,
    bool? basedOnGuests,
  }) {
    return SideOrder(
      title: title ?? this.title,
      description: description ?? this.description,
      docId: docId ?? this.docId,
      price: price ?? this.price,
      basedOnGuests: basedOnGuests ?? this.basedOnGuests,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'basedOnGuests': basedOnGuests,
      //'docId': docId,
    };
  }

  String toJson() => json.encode(toMap());
}
