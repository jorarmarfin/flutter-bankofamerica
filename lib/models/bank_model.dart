// To parse this JSON data, do
//
//     final bankModel = bankModelFromMap(jsonString);

import 'dart:convert';

class BankModel {
  BankModel({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.phone,
    required this.zip,
    required this.distance,
  });

  int id;
  String name;
  String address;
  String latitude;
  String longitude;
  String phone;
  String zip;
  String distance;

  factory BankModel.fromJson(String str) => BankModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BankModel.fromMap(Map<String, dynamic> json) => BankModel(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        phone: json["phone"],
        zip: json["zip"],
        distance: json["distance"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "phone": phone,
        "zip": zip,
        "distance": distance,
      };
}
