/// This class defines the TripsRepository
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

abstract class TripsRepository {
  //get customers added by the merchant
  Future<ApiResponse<dynamic>> getTrips();
  Future<ApiResponse<dynamic>> startTrip(String tripId);
  Future<ApiResponse<dynamic>> endTrip(String tripId);
  Future<ApiResponse<dynamic>> getRiderAnalysis();
}

class TripsRepositoryImpl implements TripsRepository {
  final Dio _dio;

  TripsRepositoryImpl(this._dio);

  @override
  Future<ApiResponse<dynamic>> getTrips() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId') ?? "";
    //     String accountType = prefs.getString('accountType') ?? "";

    try {
      final response = await _dio.get(
        "${Endpoint.baseUrl}/trips/?assignedRider=$userId",
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

  @override
  Future<ApiResponse<dynamic>> startTrip(String tripId) async {
    try {
      final response = await _dio.put(
        "${Endpoint.baseUrl}/trips/start-trip/$tripId",
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

//
  @override
  Future<ApiResponse<dynamic>> endTrip(String tripId) async {
    //https://jenosway-backend.onrender.com/api/v1/trips/end-trip/65e8aae30d799bf9baf7d4b5
    try {
      final response = await _dio.put(
        "${Endpoint.baseUrl}/trips/end-trip/$tripId",
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

//
  @override
  Future<ApiResponse<dynamic>> getRiderAnalysis() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId') ?? "";
    // String accountType = prefs.getString('accountType') ?? "";

    try {
      final response = await _dio.get(
        "${Endpoint.baseUrl}/trips/rider/analysis/$userId",
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
//
}

final tripsRepository = Provider<TripsRepository>(
  (ref) => TripsRepositoryImpl(
    ref.read(dioProvider),
  ),
);
