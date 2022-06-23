import 'dart:convert' show json;

import 'package:cloud_firestore/cloud_firestore.dart'
    show DocumentSnapshot, DocumentReference;
import 'package:equatable/equatable.dart';

import 'side_order_model.dart';

class Dining extends Equatable {
  const Dining({
    this.arrivalTime,
    required this.chefmadeFee,
    required this.creationDate,
    required this.customerEmail,
    required this.customerFirstName,
    required this.customerLastName,
    required this.customerPhone,
    this.discount,
    this.docId,
    required this.eventDate,
    this.menu,
    required this.numberOfGuests,
    required this.paid,
    this.personResponsible,
    this.pricePerPerson,
    required this.serveTime,
    required this.status,
    required this.venueCity,
    required this.venueStreet,
    required this.venueStreetNumber,
    required this.venueZipCode,
    this.sideOrders,
    this.notes,
  });

  factory Dining.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic> doc = snapshot.data()! as Map<String, dynamic>;

    return Dining.fromMap(doc, docId: snapshot.id);
  }

  factory Dining.fromJson(String source) => Dining.fromMap(json.decode(source));

  factory Dining.fromMap(Map<String, dynamic> map, {String? docId}) {
    try {
      return Dining(
        arrivalTime: DateTime.parse(map['arrivalTime'].toDate().toString()),
        chefmadeFee: map['chefmadeFee'],
        creationDate: DateTime.parse(map['creationDate'].toDate().toString()),
        customerEmail: map['customerEmail'],
        customerFirstName: map['customerFirstName'],
        customerLastName: map['customerLastName'],
        customerPhone: map['customerPhone'],
        discount: map['discount'],
        docId: docId ?? map['docId'],
        eventDate: DateTime.parse(map['eventDate'].toDate().toString()),
        menu: map['menu'],
        numberOfGuests: map['numberOfGuests'],
        paid: map['paid'],
        personResponsible: map['personResponsible'],
        pricePerPerson: map['pricePerPerson'],
        serveTime: DateTime.parse(map['serveTime'].toDate().toString()),
        status: map['status'],
        venueCity: map['venueCity'],
        venueStreet: map['venueStreet'],
        venueStreetNumber: map['venueStreetNumber'],
        venueZipCode: map['venueZipCode'],
        sideOrders: map['sideOrders'] != null
            ? List<SideOrder>.from(
                map['sideOrders']?.map((x) => SideOrder.fromMap(x)))
            : null,
        notes: map['notes'],
      );
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  final DateTime? arrivalTime;
  final num chefmadeFee;
  final DateTime creationDate;
  final String customerEmail;
  final String customerFirstName;
  final String customerLastName;
  final String customerPhone;
  final num? discount;
  final String? docId;
  final DateTime eventDate;
  final DocumentReference? menu;
  final num numberOfGuests;
  final bool paid;
  final String? personResponsible;
  final num? pricePerPerson;
  final DateTime serveTime;
  final String status;
  final String venueCity;
  final String venueStreet;
  final num venueStreetNumber;
  final num venueZipCode;
  final List<SideOrder>? sideOrders;
  final String? notes;

  @override
  List<Object?> get props => [
        arrivalTime,
        chefmadeFee,
        creationDate,
        customerEmail,
        customerFirstName,
        customerLastName,
        customerPhone,
        discount,
        docId,
        eventDate,
        menu,
        numberOfGuests,
        paid,
        personResponsible,
        pricePerPerson,
        serveTime,
        status,
        venueCity,
        venueStreet,
        venueStreetNumber,
        venueZipCode,
        sideOrders,
        notes,
      ];

  @override
  bool get stringify => true;

  Dining copyWith({
    DateTime? arrivalTime,
    double? chefmadeFee,
    DateTime? creationDate,
    String? customerEmail,
    String? customerFirstName,
    String? customerLastName,
    String? customerPhone,
    double? discount,
    String? docId,
    DateTime? eventDate,
    DocumentReference? menu,
    double? numberOfGuests,
    bool? paid,
    String? personResponsible,
    double? pricePerPerson,
    DateTime? serveTime,
    String? status,
    String? venueCity,
    String? venueStreet,
    double? venueStreetNumber,
    double? venueZipCode,
    List<SideOrder>? sideOrders,
    String? notes,
  }) {
    return Dining(
      arrivalTime: arrivalTime ?? this.arrivalTime,
      chefmadeFee: chefmadeFee ?? this.chefmadeFee,
      creationDate: creationDate ?? this.creationDate,
      customerEmail: customerEmail ?? this.customerEmail,
      customerFirstName: customerFirstName ?? this.customerFirstName,
      customerLastName: customerLastName ?? this.customerLastName,
      customerPhone: customerPhone ?? this.customerPhone,
      discount: discount ?? this.discount,
      docId: docId ?? this.docId,
      eventDate: eventDate ?? this.eventDate,
      menu: menu ?? this.menu,
      numberOfGuests: numberOfGuests ?? this.numberOfGuests,
      paid: paid ?? this.paid,
      personResponsible: personResponsible ?? this.personResponsible,
      pricePerPerson: pricePerPerson ?? this.pricePerPerson,
      serveTime: serveTime ?? this.serveTime,
      status: status ?? this.status,
      venueCity: venueCity ?? this.venueCity,
      venueStreet: venueStreet ?? this.venueStreet,
      venueStreetNumber: venueStreetNumber ?? this.venueStreetNumber,
      venueZipCode: venueZipCode ?? this.venueZipCode,
      sideOrders: sideOrders ?? this.sideOrders,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'arrivalTime': arrivalTime,
      'chefmadeFee': chefmadeFee,
      'creationDate': creationDate,
      'customerEmail': customerEmail,
      'customerFirstName': customerFirstName,
      'customerLastName': customerLastName,
      'customerPhone': customerPhone,
      'discount': discount,
      //'docId': docId,
      'eventDate': eventDate,
      'menu': menu,
      'numberOfGuests': numberOfGuests,
      'paid': paid,
      'personResponsible': personResponsible,
      'pricePerPerson': pricePerPerson,
      'serveTime': serveTime,
      'status': status,
      'venueCity': venueCity,
      'venueStreet': venueStreet,
      'venueStreetNumber': venueStreetNumber,
      'venueZipCode': venueZipCode,
      'sideOrders': sideOrders,
      'notes': notes,
    };
  }

  String toJson() => json.encode(toMap());
}
