// To parse this JSON data, do
//
//     final addCustomerModel = addCustomerModelFromJson(jsonString);

import 'dart:convert';

AddCustomerModel addCustomerModelFromJson(String str) =>
    AddCustomerModel.fromJson(json.decode(str));

String addCustomerModelToJson(AddCustomerModel data) =>
    json.encode(data.toJson());

class AddCustomerModel {
  final String? name;
  final String? phoneNumber;
  final String? location;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  AddCustomerModel({
    this.name,
    this.phoneNumber,
    this.location,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory AddCustomerModel.fromJson(Map<String, dynamic> json) =>
      AddCustomerModel(
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        location: json["location"],
        id: json["_id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phoneNumber": phoneNumber,
        "location": location,
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
