/// This class defines the AuthRepository
/// @author  Yusuf umar
/// @version 1.0
/// @since   2023-07-19
///


import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/core/api_response.dart';
import 'package:jenos/scr/core/app_exception.dart';
import 'package:jenos/scr/core/provider/dio_provider.dart';
import 'package:jenos/scr/features/auth/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Abstract class representing the authentication repository.
abstract class AuthRepository {
  /// Sign up a user with the provided [model].
  Future<ApiResponse<UserModel>> signUp(UserModel model);

  /// Sign in a user with the provided [model].
  Future<ApiResponse<UserModel>> signIn(UserModel model);

  /// Verify an OTP with the provided [model].

  /// Get the user data.
  Future<ApiResponse<UserModel>> getUserData();

}

/// Implementation of the authentication repository.
class AuthRepositoryImpl implements AuthRepository {
  final Dio _dio;

  AuthRepositoryImpl(this._dio);

  @override
  Future<ApiResponse<UserModel>> signUp(UserModel model) async {
    try {
      final response = await _dio.post(
        "auth/signup",
        data: {
          "name": model.name,
          "email": model.email,
          "password": model.password,
        },
      );
      UserModel userModel = UserModel.fromJson(response.data);

      return ApiResponse<UserModel>(
        success: true,
        data: userModel,
        message: "Register successful",
      );
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }

  @override
  Future<ApiResponse<UserModel>> signIn(UserModel model) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final response = await _dio.post("/auth/signin", data: {
        "email": model.email,
        "password": model.password,
      });
      UserModel userModel = UserModel.fromJson(response.data);
      await prefs.setString('x-auth-token', userModel.token!);

      return ApiResponse<UserModel>(
        success: true,
        data: userModel,
        message: "Signed in successful",
      );
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }



  @override
  Future<ApiResponse<UserModel>> getUserData() async {
    try {
      final response = await _dio.get(
        "auth/get-user",
      );
      UserModel userModel = UserModel.fromJson(response.data);

      return ApiResponse<UserModel>(
        success: true,
        data: userModel,
        message: "Successful",
      );
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }




}

final authRepository = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(
    ref.read(dioProvider),
  ),
);
