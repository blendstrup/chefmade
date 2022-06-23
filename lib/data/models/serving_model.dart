import 'dart:convert' show json;

import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;
import 'package:equatable/equatable.dart';

class Serving extends Equatable {
  const Serving({
    required this.title,
    required this.description,
    required this.docId,
    required this.order,
  });

  factory Serving.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic> doc = snapshot.data()! as Map<String, dynamic>;

    return Serving.fromMap(doc, docId: snapshot.id);
  }

  factory Serving.fromJson(String source) =>
      Serving.fromMap(json.decode(source));

  factory Serving.fromMap(Map<String, dynamic> map, {String? docId}) {
    try {
      return Serving(
        title: map['title'],
        description: map['description'],
        docId: docId ?? map['docId'],
        order: map['order'],
      );
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  final String description;
  final String? docId;
  final String title;
  final num order;

  @override
  List<Object?> get props => [description, docId, title, order];

  @override
  bool get stringify => true;

  Serving copyWith({
    String? title,
    String? description,
    String? docId,
    num? order,
  }) {
    return Serving(
      title: title ?? this.title,
      description: description ?? this.description,
      docId: docId ?? this.docId,
      order: order ?? this.order,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'order': order,
      //'docId': docId,
    };
  }

  String toJson() => json.encode(toMap());
}
