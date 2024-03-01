/// This class defines the ProfileRepository
/// @author  Yusuf umar
/// @version 1.0
/// @since   2023-12-19
///

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/constant/app_endpoint.dart';
import 'package:jenos/scr/core/helper/api_response.dart';
import 'package:jenos/scr/core/helper/app_exception.dart';
import 'package:jenos/scr/core/dio_provider/dio_provider.dart';
import 'package:jenos/scr/core/util/util.dart';
import 'package:jenos/scr/core/models/user_merchant_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Abstract class representing the authentication repository.
abstract class ProfileRepository {
  Future<ApiResponse<dynamic>> updateProfile(
    String fullName,
    String phoneNumber,
    String address,
  );

  // Future<ApiResponse<dynamic>> signIn(String email, String password);
  Future<ApiResponse<dynamic>> getUserData();
  Future<ApiResponse> uploadImage(
    file,
  );
}

/// Implementation of the authentication repository.
class ProfileRepositoryImpl implements ProfileRepository {
  final Dio _dio;

  ProfileRepositoryImpl(this._dio);

  @override
  Future<ApiResponse<dynamic>> updateProfile(
    String fullName,
    String phoneNumber,
    String address,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accountType = prefs.getString('accountType') ?? "";
    String userId = prefs.getString('userId') ?? "";

    final pathUrl =
        accountType == "individual" ? "/rider/$userId" : "/enterprise/$userId";

    //userName

    var riderBody = {
      "userName": fullName,
      "phoneNumber": phoneNumber,
      "address": address,
    };

    var enterpriseriseBody = {
      "userName": fullName,
      "phoneNumber": phoneNumber,
      "address": address,
    };

    try {
      final response = await _dio.put("${Endpoint.baseUrl}$pathUrl",
          data: accountType == "individual" ? riderBody : enterpriseriseBody);

      // MerchantUserModel userModel = MerchantUserModel.fromJson(response.data);

      return ApiResponse<dynamic>(
        success: true,
        data: response.data,
        message: "update successful",
      );
    } on DioException catch (e) {
      return AppException.handleError(
        e,
      );
    }
  }

  @override
  Future<ApiResponse<dynamic>> getUserData() async {


log("getUserData called");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accountType = prefs.getString('accountType') ?? "individual";

    log("accountType here:$accountType");

    final pathUrl =
        accountType == "individual" ? "/rider/me" : "/enterprise/me";
    try {
      final response = await _dio.get(
        "${Endpoint.baseUrl}$pathUrl",
      );

      // log("getuser response:${response.data}");

      return ApiResponse<dynamic>(
        success: true,
        data: response.data['data'],
        //this endpoint returns list as customer data
        message: "Successful",
      );
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }

  @override
  Future<ApiResponse> uploadImage(
    // BuildContext? context,
    file,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId') ?? "";
    String accountType = prefs.getString('accountType') ?? "";

    try {
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(file.path, filename: "image"),
      });

      //customer/update-profile-image/65c1f348773198d5bd5baff8

      final pathUrl = accountType == "merchant"
          ? "/merchant/image/$userId"
          : "/customer/update-profile-image/$userId";

      Response response = await _dio.put(
        "${Endpoint.baseUrl}$pathUrl",
        data: formData,
      );

      log("response1: ${response.data}");

      return ApiResponse<dynamic>(
        success: true,
        data: response.data,
        message: "Successful",
      );
    } catch (e) {
      log("response2: $e");
      return ApiResponse<dynamic>(
        success: true,
        message: "Successful",
      );
    }
  }
}

final profileRepository = Provider<ProfileRepository>(
  (ref) => ProfileRepositoryImpl(
    ref.read(dioProvider),
  ),
);
