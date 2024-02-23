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
        "email": email,
        "password": password,
        "userName": userName,
        "phoneNumber": phoneNumber,
      };

      final response = await _dio.post("${Endpoint.baseUrl}/rider", data: body);

      log("account1 success ${response.data}");

      // MerchantUserModel userModel = MerchantUserModel.fromJson(response.data);

      return ApiResponse<dynamic>(
        success: true,
        data: response.data,
        message: "Register successful",
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
    String accountType = prefs.getString('accountType') ?? "";

    var pathUrl =
        accountType == "individual" ? "/rider/login" : "/enterprise/login";

    try {
      final response = await _dio.post("${Endpoint.baseUrl}$pathUrl", data: {
        "email": email,
        "password": password,
      });
      // MerchantUserModel userModel = MerchantUserModel.fromJson(response.data);

      log("response.data['data']['token']:${response.data['data']['token']}");
      log("response.data['data']['_id']:${response.data['data']['_id']}");
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
}

final authRepository = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(
    ref.read(dioProvider),
  ),
);
