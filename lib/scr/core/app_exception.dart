import 'package:dio/dio.dart';
import 'package:jenos/scr/core/api_response.dart';
import 'package:jenos/scr/core/logger.dart';

class AppException {
  //HANDLE ERROR
  static ApiResponse<T> handleError<T>(DioException e, {T? data}) {
    if (e.response != null) { //e.type == DioExceptionType. && 
      if (e.response!.statusCode! == 400) {
        return ApiResponse(
          success: false,
          message: e.response.toString(), //jsonDecode(res.body)['msg']
          data: data, 
        );
      }
      if (e.response!.statusCode! >= 500) {
        return ApiResponse(
          success: false,
          message: "A server error occurred",
          data: data,
        );
      }
      if (e.response?.data is Map<String, dynamic>) {
        // debugLog(ApiResponse.fromMap(e.response?.data).error);
        // return ApiResponse.fromMap(e.response?.data);
      } else if (e.response?.data is String) {
        debugLog(e.response?.data);
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
