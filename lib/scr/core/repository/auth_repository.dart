/// This class defines the AuthRepository
/// @author  Yusuf umar
/// @version 1.0
/// @since   2023-12-19
///

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/constant/app_endpoint.dart';
import 'package:jenos/scr/core/helper/api_response.dart';
import 'package:jenos/scr/core/dio_provider/dio_provider.dart';
import 'package:jenos/scr/core/helper/app_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthRepository {
  Future<ApiResponse<dynamic>> signUp(
    String email,
    String password,
    String userName,
    String phoneNumber,
  );

  Future<ApiResponse<dynamic>> signIn(
    String email,
    String password,
  );

  Future<ApiResponse<dynamic>> forgotPassword(String email);
  Future<ApiResponse<dynamic>> verifyOtp(String otp);
  Future<ApiResponse<dynamic>> resetPassword(String password);
}

/// Implementation of the authentication repository.
class AuthRepositoryImpl implements AuthRepository {
  final Dio _dio;

  AuthRepositoryImpl(this._dio);

  @override
  Future<ApiResponse<dynamic>> signUp(
    String email,
    String password,
    String userName,
    String phoneNumber,
  ) async {
    try {
      var body = {
        "email": email.trim(),
        "password": password.trim(),
        "userName": userName.trim(),
        "phoneNumber": phoneNumber.trim(),
      };

      final response = await _dio.post("${Endpoint.baseUrl}/rider", data: body);

      log("account1 success ${response.data}");

      // MerchantUserModel userModel = MerchantUserModel.fromJson(response.data);

      return ApiResponse<dynamic>(
        success: true,
        data: response.data,
        message:
            "Register successful, check your email and follow the instruction",
      );
    } on DioException catch (e) {
      // log("account1 err0r ${e}");

      return AppException.handleError(
        e,
      );
    }
  }

  @override
  Future<ApiResponse<dynamic>> signIn(
    String email,
    String password,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String accountType = prefs.getString('accountType') ?? "";
    String fcmToken = prefs.getString("fcmToken") ?? "";

    // var pathUrl =
    //     accountType == "enterprise" ? "/enterprise/login" : "/rider/login";
    // accountType == "enterprise" ? "/enterprise/login" : "/rider/login";

    try {
      final response =
          await _dio.post("${Endpoint.baseUrl}/rider/login", data: {
        "email": email.trim(),
        "password": password.trim(),
        "firebaseId": fcmToken.trim(),
      });
      // MerchantUserModel userModel = MerchantUserModel.fromJson(response.data);

      await prefs.setString('token', response.data['data']['token']!);
      await prefs.setString('userId', response.data['data']['_id']!);

      return ApiResponse<dynamic>(
        success: true,
        data: response.data['data'],
        message: "Signed in successful",
      );
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }

//
  @override
  Future<ApiResponse<dynamic>> forgotPassword(
    String email,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', email);
      final response = await _dio.post("${Endpoint.baseUrl}/auth/otp", data: {
        "type": "email",
        "userDetail": email,
      });

      log("forgot response:$response");

      return ApiResponse<dynamic>(
        success: true,
        data: response.data['data'],
        message: "request sent",
      );
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }

//
  @override
  Future<ApiResponse<dynamic>> verifyOtp(
    String otp,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String email = prefs.getString('email') ?? "";
      final response =
          await _dio.post("${Endpoint.baseUrl}/auth/otp/verify", data: {
        "otp": otp,
        "userDetail": email,
      });

      log("forgot response:$response");

      return ApiResponse<dynamic>(
        success: true,
        data: response.data['data'],
        message: "request sent",
      );
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }

//
  @override
  Future<ApiResponse<dynamic>> resetPassword(
    String password,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String email = prefs.getString('email') ?? "";
      // String accountType = prefs.getString('accountType') ?? "";

      // var pathUrl = accountType == "merchant"
      //     ? "/auth/merchant-reset-password"
      //     : "/auth/customer-reset-password";

      //auth/merchant-reset-password
      final response =
          await _dio.post("${Endpoint.baseUrl}/auth/reset-password", data: {
        "newPassword": password,
        "email": email,
      });

      log("resetPassword response:$response");

      return ApiResponse<dynamic>(
        success: true,
        data: response.data['data'],
        message: "request sent",
      );
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
//
}

final authRepository = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(
    ref.read(dioProvider),
  ),
);
