import 'dart:convert' show json;

import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;
import 'package:equatable/equatable.dart';

import 'dining_model.dart';
import 'menu_model.dart';

class Restaurant extends Equatable {
  const Restaurant({
    required this.active,
    this.bankAccountNumber,
    this.bankName,
    this.chefmadeFee,
    required this.city,
    this.company,
    required this.cookBrings,
    required this.cookNeeds,
    required this.coverImagePath,
    this.cvr,
    this.dinings,
    this.docId,
    required this.email,
    required this.logoImagePath,
    required this.longDescription,
    required this.maxAmountOfGuests,
    required this.maxDistance,
    this.menus,
    this.metaDescription,
    this.metaTitle,
    required this.minAmountOfGuests,
    required this.name,
    required this.phone,
    this.regNumber,
    required this.shortDescription,
    required this.street,
    required this.streetNumber,
    required this.zipCode,
  });

  factory Restaurant.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic> doc = snapshot.data()! as Map<String, dynamic>;

    return Restaurant.fromMap(doc, docId: snapshot.id);
  }

  factory Restaurant.fromJson(String source) =>
      Restaurant.fromMap(json.decode(source));

  factory Restaurant.fromMap(Map<String, dynamic> map, {String? docId}) {
    //Add null operators to make more safe?
    try {
      return Restaurant(
        active: map['active'],
        bankAccountNumber: map['bankAccountNumber'],
        bankName: map['bankName'],
        chefmadeFee: map['chefmadeFee'],
        city: map['city'],
        company: map['company'],
        cookBrings: Map<String, bool>.from(map['cookBrings']),
        cookNeeds: Map<String, bool>.from(map['cookNeeds']),
        coverImagePath: map['coverImagePath'],
        cvr: map['cvr'],
        dinings: map['dinings'] != null
            ? List<Dining>.from(map['dinings']?.map((x) => Dining.fromMap(x)))
            : [],
        docId: docId ?? map['docId'],
        email: map['email'],
        logoImagePath: map['logoImagePath'],
        longDescription: map['longDescription'],
        maxAmountOfGuests: map['maxAmountOfGuests'],
        maxDistance: map['maxDistance'],
        menus: map['menus'] != null
            ? List<Menu>.from(map['menus']?.map((x) => Menu.fromMap(x)))
            : [],
        metaDescription: map['metaDescription'],
        metaTitle: map['metaTitle'],
        minAmountOfGuests: map['minAmountOfGuests'],
        name: map['name'],
        phone: map['phone'],
        regNumber: map['regNumber'],
        shortDescription: map['shortDescription'],
        street: map['street'],
        streetNumber: map['streetNumber'],
        zipCode: map['zipCode'],
      );
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  final bool active;
  final num? bankAccountNumber;
  final String? bankName;
  final num? chefmadeFee;
  final String city;
  final String? company;
  final Map<String, bool> cookBrings;
  final Map<String, bool> cookNeeds;
  final String coverImagePath;
  final num? cvr;
  final List<Dining>? dinings;
  final String? docId;
  final String email;
  final String logoImagePath;
  final String longDescription;
  final num maxAmountOfGuests;
  final num maxDistance;
  final List<Menu>? menus;
  final String? metaDescription;
  final String? metaTitle;
  final num minAmountOfGuests;
  final String name;
  final String phone;
  final num? regNumber;
  final String shortDescription;
  final String street;
  final num streetNumber;
  final num zipCode;

  @override
  List<Object?> get props => [
        active,
        bankAccountNumber,
        bankName,
        chefmadeFee,
        city,
        company,
        cookBrings,
        cookNeeds,
        coverImagePath,
        cvr,
        dinings,
        docId,
        email,
        logoImagePath,
        longDescription,
        maxAmountOfGuests,
        maxDistance,
        menus,
        metaDescription,
        metaTitle,
        minAmountOfGuests,
        name,
        phone,
        regNumber,
        shortDescription,
        street,
        streetNumber,
        zipCode,
      ];

  @override
  bool get stringify => true;

  Restaurant copyWith({
    bool? active,
    double? bankAccountNumber,
    String? bankName,
    double? chefmadeFee,
    String? city,
    String? company,
    Map<String, bool>? cookBrings,
    Map<String, bool>? cookNeeds,
    String? coverImagePath,
    double? cvr,
    List<Dining>? dinings,
    String? docId,
    String? email,
    String? logoImagePath,
    String? longDescription,
    double? maxAmountOfGuests,
    double? maxDistance,
    List<Menu>? menus,
    String? metaDescription,
    String? metaTitle,
    double? minAmountOfGuests,
    String? name,
    String? phone,
    double? regNumber,
    String? shortDescription,
    String? street,
    double? streetNumber,
    double? zipCode,
  }) {
    return Restaurant(
      active: active ?? this.active,
      bankAccountNumber: bankAccountNumber ?? this.bankAccountNumber,
      bankName: bankName ?? this.bankName,
      chefmadeFee: chefmadeFee ?? this.chefmadeFee,
      city: city ?? this.city,
      company: company ?? this.company,
      cookBrings: cookBrings ?? this.cookBrings,
      cookNeeds: cookNeeds ?? this.cookNeeds,
      coverImagePath: coverImagePath ?? this.coverImagePath,
      cvr: cvr ?? this.cvr,
      dinings: dinings ?? this.dinings,
      docId: docId ?? this.docId,
      email: email ?? this.email,
      logoImagePath: logoImagePath ?? this.logoImagePath,
      longDescription: longDescription ?? this.longDescription,
      maxAmountOfGuests: maxAmountOfGuests ?? this.maxAmountOfGuests,
      maxDistance: maxDistance ?? this.maxDistance,
      menus: menus ?? this.menus,
      metaDescription: metaDescription ?? this.metaDescription,
      metaTitle: metaTitle ?? this.metaTitle,
      minAmountOfGuests: minAmountOfGuests ?? this.minAmountOfGuests,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      regNumber: regNumber ?? this.regNumber,
      shortDescription: shortDescription ?? this.shortDescription,
      street: street ?? this.street,
      streetNumber: streetNumber ?? this.streetNumber,
      zipCode: zipCode ?? this.zipCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'active': active,
      'bankAccountNumber': bankAccountNumber,
      'bankName': bankName,
      'chefmadeFee': chefmadeFee,
      'city': city,
      'company': company,
      'cookBrings': cookBrings,
      'cookNeeds': cookNeeds,
      'coverImagePath': coverImagePath,
      'cvr': cvr,
      'dinings': dinings?.map((x) => x.toMap()).toList(),
      //'docId': docId,
      'email': email,
      'logoImagePath': logoImagePath,
      'longDescription': longDescription,
      'maxAmountOfGuests': maxAmountOfGuests,
      'maxDistance': maxDistance,
      'menus': menus?.map((x) => x.toMap()).toList(),
      'metaDescription': metaDescription,
      'metaTitle': metaTitle,
      'minAmountOfGuests': minAmountOfGuests,
      'name': name,
      'phone': phone,
      'regNumber': regNumber,
      'shortDescription': shortDescription,
      'street': street,
      'streetNumber': streetNumber,
      'zipCode': zipCode,
    };
  }

  String toJson() => json.encode(toMap());
}
