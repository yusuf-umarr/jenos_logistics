import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:jenos/scr/core/helper/api_response.dart';
import 'package:jenos/scr/core/util/logger.dart';

class AppException {
  //HANDLE ERROR
  static ApiResponse<T> handleError<T>(DioException e, {T? data}) {
    try {
      if (e.response != null) {
        if (e.response!.statusCode! >= 500) {
          return ApiResponse(
            success: false,
            message: "A server error occurred",
            data: data,
          );
        }
        if (e.response!.statusCode! >= 400) {
          // print("runtimeType:${jsonDecode(e.response!)}");
          // print("runtimeType:${e.response!.data['message']}");
          log("error in res:${e.response.runtimeType}");
          log("error in res.data:${e.response!.data.runtimeType}");

          /*
          [log] error in res:Response<dynamic>
[log] error in res.data:_Map<String, dynamic>
          */

          // if (e.response!.data.contains('message')) {
          //   log("error start-with========================");
          // }

          //{"message":"","errors":{"success":false}}

          // if (e.response == null) {
          //   return ApiResponse(
          //     success: false,
          //     message: jsonDecode(e.response!.data), //jsonDecode(res.body)['msg']
          //     data: data,
          //   );
          // }

          return ApiResponse(
            success: false,
            message: e.response!.data['message'],
            //jsonDecode(res.body)['msg']
            data: data,
          );
        }
        if (e.response?.data is Map<String, dynamic>) {
          // debugLog(ApiResponse.fromMap(e.response?.data).error);
          // return ApiResponse.fromMap(e.response?.data);
        } else if (e.response?.data is String) {
          // debugLog(e.response?.data);
          return ApiResponse(
            success: false,
            message: e.response?.data,
            data: data,
          );
        }
      }
      return ApiResponse(
        success: false,
        data: data,
        message: _mapException(e.type),
      );
    } catch (e) {
      return ApiResponse(
        success: false,
        data: data,
        message: "Unknown errors====",
      );
    }
  }

  static _mapException(DioExceptionType type) {
    if (DioExceptionType.connectionTimeout == type ||
        DioExceptionType.receiveTimeout == type ||
        DioExceptionType.sendTimeout == type) {
      return "Your connection timed out";
    } else if (DioExceptionType.unknown == type) {
      return "A network error occurred. Please check your connection";
    }
    return "An error occurred";
  }
}
