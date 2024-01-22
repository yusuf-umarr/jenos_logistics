/// This class defines the UserModel
/// @author  Yusuf umar
/// @version 1.0
/// @since   2023-12-19
///
import 'dart:convert';

/// Converts a JSON string to a [UserModel] object.
UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

/// Converts a [UserModel] object to a JSON string.
String userModelToJson(UserModel data) => json.encode(data.toJson());

/// Represents a user model.
class UserModel {
  String? id;
  String? token;
  String? name;
  String? email;
  String? password;
  int? v;
  String? phoneNumber;

  /// Creates a new instance of [UserModel].
  UserModel({
    this.id,
    this.token,
    this.name,
    this.email,
    this.password,
    this.v,
    this.phoneNumber,
  });

  /// Creates a new [UserModel] instance from a JSON map.
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        token: json["token"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        v: json["__v"],
        phoneNumber: json["phoneNumber"],
      );

  /// Converts the [UserModel] instance to a JSON map.
  Map<String, dynamic> toJson() => {
        "_id": id,
        "token": token,
        "name": name,
        "email": email,
        "password": password,
        "__v": v,
        "phoneNumber": phoneNumber,
      };
}
