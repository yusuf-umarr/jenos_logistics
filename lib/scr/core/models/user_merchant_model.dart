// // To parse this JSON data, do
// //
// //     final merchantUserModel = merchantUserModelFromJson(jsonString);

// import 'dart:convert';

// MerchantUserModel merchantUserModelFromJson(String str) =>
//     MerchantUserModel.fromJson(json.decode(str));

// String merchantUserModelToJson(MerchantUserModel data) =>
//     json.encode(data.toJson());

// class MerchantUserModel {
//   final bool? success;
//   final String? msg;
//   final Data? data;

//   MerchantUserModel({
//     this.success,
//     this.msg,
//     this.data,
//   });

//   factory MerchantUserModel.fromJson(Map<String, dynamic> json) =>
//       MerchantUserModel(
//         success: json["success"],
//         msg: json["msg"],
//         data: json["data"] == null ? null : Data.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "msg": msg,
//         "data": data?.toJson(),
//       };
// }

// class Data {
//   final String? id;
//   final String? email;
//   final String? phoneNumber;
//   final String? fullName;
//   final String? token;

//   Data({
//     this.id,
//     this.email,
//     this.phoneNumber,
//     this.fullName,
//     this.token,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         id: json["_id"],
//         email: json["email"],
//         phoneNumber: json["phoneNumber"],
//         fullName: json["fullName"],
//         token: json["token"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "email": email,
//         "phoneNumber": phoneNumber,
//         "fullName": fullName,
//         "token": token,
//       };
// }
