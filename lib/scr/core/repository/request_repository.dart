/// This class defines the RequestRepository
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
abstract class RequestRepository {
  Future<ApiResponse<dynamic>> acceptRequest(
    String receiverName,
    String phone,
    String deliveryAddress,
    String pickUpDate,
    String pickUpTime,
    String paymentMethod,
    String paymentType,
    String senderName,
    itemImage,
    String customerId,
    String userType,
  );
  //get customers added by the merchant
  Future<ApiResponse<dynamic>> getRiderRequest();
}

class RequestRepositoryImpl implements RequestRepository {
  final Dio _dio;

  RequestRepositoryImpl(this._dio);

  @override
  Future<ApiResponse<dynamic>> acceptRequest(
    String receiverName,
    String phone,
    String deliveryAddress,
    String pickUpDate,
    String pickUpTime,
    String paymentMethod,
    String paymentType,
    String senderName,
    itemImage,
    String customerId,
    String userType,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId') ?? "";
    String accountType = prefs.getString('accountType') ?? "";

    try {
      FormData merchantFormData = FormData.fromMap({
        "receiverName": receiverName,
        "phone": phone,
        "deliveryAddress": deliveryAddress,
        "pickUpDate": pickUpDate,
        "pickUpTime": pickUpTime,
        "paymentMethod": paymentMethod,
        "paymentType": paymentType,
        "senderName": senderName,
        "itemImage": itemImage != null
            ? await MultipartFile.fromFile(itemImage.path)
            : '',
        "customerId": customerId,
        "userType": userType,
        "createdBy": userId
      });

      FormData customerFormData = FormData.fromMap({
        "receiverName": receiverName,
        "phone": phone,
        "deliveryAddress": deliveryAddress,
        "pickUpDate": pickUpDate,
        "pickUpTime": pickUpTime,
        "paymentMethod": paymentMethod,
        "paymentType": paymentType,
        "senderName": senderName,
        "itemImage": itemImage != null
            ? await MultipartFile.fromFile(itemImage.path)
            : '',
        "customerId": userId,
      });
      final response = await _dio.post(
        "${Endpoint.baseUrl}/request",
        data: accountType == "merchant" ? merchantFormData : customerFormData,
      );
      log("new request success ============$accountType======");
      return ApiResponse<dynamic>(
        success: true,
        data: response.data,
        message: "Request successful created",
      );
    } on DioException catch (e) {
      return AppException.handleError(
        e,
      );
    }
  }

  @override
  Future<ApiResponse<dynamic>> getRiderRequest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId') ?? "";
    //     String accountType = prefs.getString('accountType') ?? "";

    String accountType = prefs.getString('accountType') ?? "";

    var pathUrl =
        accountType == "enterprise" ? "/request/?createdBy=$userId" : "/request?assignRider=$userId";


    try {
      //https://jenosway-backend.onrender.com/api/v1/request?assignRider=65d49a1b5c0de0b309e10ef5

      final response = await _dio.get(
        "${Endpoint.baseUrl}$pathUrl",
      );

      return ApiResponse<dynamic>(
        success: true,
        data: response.data['data'],
        message: " successful",
      );
    } on DioException catch (e) {
      // log("get rider request error$e");
      return AppException.handleError(
        e,
      );
    }
  }
}

final requestRepository = Provider<RequestRepository>(
  (ref) => RequestRepositoryImpl(
    ref.read(dioProvider),
  ),
);
