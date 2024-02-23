// // To parse this JSON data, do
// //
// //     final customerUserModel = customerUserModelFromJson(jsonString);

// import 'dart:convert';

// CustomerUserModel customerUserModelFromJson(String str) =>
//     CustomerUserModel.fromJson(json.decode(str));

// String customerUserModelToJson(CustomerUserModel data) =>
//     json.encode(data.toJson());

// class CustomerUserModel {
//   final bool? success;
//   final Customer? customer;

//   CustomerUserModel({
//     this.success,
//     this.customer,
//   });

//   factory CustomerUserModel.fromJson(Map<String, dynamic> json) =>
//       CustomerUserModel(
//         success: json["success"],
//         customer: json["customer"] == null
//             ? null
//             : Customer.fromJson(json["customer"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "customer": customer?.toJson(),
//       };
// }

// class Customer {
//   final String? fullName;
//   final String? phoneNumber;
//   final String? email;
//   final String? password;
//   final String? location;
//   final String? id;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final int? v;

//   Customer({
//     this.fullName,
//     this.phoneNumber,
//     this.email,
//     this.password,
//     this.location,
//     this.id,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });

//   factory Customer.fromJson(Map<String, dynamic> json) => Customer(
//         fullName: json["fullName"],
//         phoneNumber: json["phoneNumber"],
//         email: json["email"],
//         password: json["password"],
//         location: json["location"],
//         id: json["_id"],
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "fullName": fullName,
//         "phoneNumber": phoneNumber,
//         "email": email,
//         "password": password,
//         "location": location,
//         "_id": id,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "__v": v,
//       };
// }
