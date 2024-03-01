/// This class defines the ManageCustomerRepository
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

/// Abstract class representing the authentication repository.
abstract class ManageCustomerRepository {
  /// these are customer added by the merchant
  Future<ApiResponse<dynamic>> addCustomer(
    String name,
    String email,
    String phone,
    String address,
  );
  Future<ApiResponse<dynamic>> deleteMerchantCustomer(
    String customerId,
 
  );
  //get customers added by the merchant
  Future<ApiResponse<dynamic>> getCustomer();
}

class ManageCustomerRepositoryImpl implements ManageCustomerRepository {
  final Dio _dio;

  ManageCustomerRepositoryImpl(this._dio);

  @override
  Future<ApiResponse<dynamic>> addCustomer(
    String name,
    String email,
    String phoneNumber,
    String address,
  ) async {
    log("add customer called");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId') ?? "";
    try {
      final response = await _dio.post(
        "${Endpoint.baseUrl}/customer/create-customer",
        data: {
          "email": email,
          "fullName": name,
          "phoneNumber": phoneNumber,
          "location": address,
          "merchantId": userId,
          "password": ""
        },
      );

      return ApiResponse<dynamic>(
        success: true,
        data: response.data,
        message: "Customer added successful",
      );
    } on DioException catch (e) {
      return AppException.handleError(
        e,
      );
    }
  }

  @override
  Future<ApiResponse<dynamic>> deleteMerchantCustomer(
    String customerId,
  
  ) async {
    log("delete customer called");
    try {
     //https://jenosway-backend.onrender.com/api/v1/customer/delete-customer/65d6141356759b06b7f16e9e
      final response =
          await _dio.delete("${Endpoint.baseUrl}/customer/delete-customer/$customerId");
      return ApiResponse<dynamic>(
        success: true,
        data: response.data,
        message: "Delete successful",
      );
    } on DioException catch (e) {
      return AppException.handleError(
        e,
      );
    }
  }

  @override
  Future<ApiResponse<dynamic>> getCustomer() async {
    // log("get customer called");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId') ?? "";
    try {
      final response = await _dio.get(
        "${Endpoint.baseUrl}/customer/get-customers/?merchantId=$userId",
      );
      // MerchantUserModel userModel = MerchantUserModel.fromJson(response.data);

      return ApiResponse<dynamic>(
        success: true,
        data: response.data['data'],
        message: " successful",
      );
    } on DioException catch (e) {
      return AppException.handleError(
        e,
      );
    }
  }
}

final manageCustomerRepository = Provider<ManageCustomerRepository>(
  (ref) => ManageCustomerRepositoryImpl(
    ref.read(dioProvider),
  ),
);
