import 'dart:convert' show json;

import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;
import 'package:equatable/equatable.dart';

import 'serving_model.dart';

class Menu extends Equatable {
  const Menu({
    required this.active,
    required this.categories,
    required this.description,
    required this.distancePricing,
    this.docId,
    this.extraInformation,
    this.menuImagePath,
    this.metaDescription,
    this.metaTitle,
    required this.price,
    this.servings,
    required this.servingsAmount,
    required this.title,
  });

  factory Menu.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic> doc = snapshot.data()! as Map<String, dynamic>;

    return Menu.fromMap(doc, docId: snapshot.id);
  }

  factory Menu.fromJson(String source) => Menu.fromMap(json.decode(source));

  factory Menu.fromMap(Map<String, dynamic> map, {String? docId}) {
    try {
      return Menu(
        active: map['active'],
        categories: Map<String, bool>.from(map['categories']),
        description: map['description'],
        distancePricing: Map<String, num>.from(map['distancePricing']),
        docId: docId ?? map['docId'],
        extraInformation: map['extraInformation'],
        menuImagePath: map['menuImagePath'],
        metaDescription: map['metaDescription'],
        metaTitle: map['metaTitle'],
        price: map['price'],
        servings: map['servings'] != null
            ? List<Serving>.from(
                map['servings']?.map((x) => Serving.fromMap(x)))
            : null,
        servingsAmount: map['servingsAmount'],
        title: map['title'],
      );
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  final bool active;
  final Map<String, bool> categories;
  final String description;
  final Map<String, num> distancePricing;
  final String? docId;
  final String? extraInformation;
  final String? menuImagePath;
  final String? metaDescription;
  final String? metaTitle;
  final num price;
  final List<Serving>? servings;
  final num servingsAmount;
  final String title;

  @override
  List<Object?> get props => [
        active,
        categories,
        description,
        distancePricing,
        docId,
        extraInformation,
        menuImagePath,
        metaDescription,
        metaTitle,
        price,
        servings,
        servingsAmount,
        title,
      ];

  @override
  bool get stringify => true;

  Menu copyWith({
    bool? active,
    Map<String, bool>? categories,
    String? description,
    Map<String, num>? distancePricing,
    String? docId,
    String? extraInformation,
    String? menuImagePath,
    String? metaDescription,
    String? metaTitle,
    double? price,
    List<Serving>? servings,
    double? servingsAmount,
    String? title,
  }) {
    return Menu(
      active: active ?? this.active,
      categories: categories ?? this.categories,
      description: description ?? this.description,
      distancePricing: distancePricing ?? this.distancePricing,
      docId: docId ?? this.docId,
      extraInformation: extraInformation ?? this.extraInformation,
      menuImagePath: menuImagePath ?? this.menuImagePath,
      metaDescription: metaDescription ?? this.metaDescription,
      metaTitle: metaTitle ?? this.metaTitle,
      price: price ?? this.price,
      servings: servings ?? this.servings,
      servingsAmount: servingsAmount ?? this.servingsAmount,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'active': active,
      'categories': categories,
      'description': description,
      'distancePricing': distancePricing,
      //'docId': docId,
      'extraInformation': extraInformation,
      'menuImagePath': menuImagePath,
      'metaDescription': metaDescription,
      'metaTitle': metaTitle,
      'price': price,
      'servings': servings,
      'servingsAmount': servingsAmount,
      'title': title,
    };
  }

  String toJson() => json.encode(toMap());
}
