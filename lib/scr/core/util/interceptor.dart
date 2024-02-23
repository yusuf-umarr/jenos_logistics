// import 'package:dio/dio.dart';
// import 'package:jenos/scr/core/logger.dart';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

// class AppInterceptor extends Interceptor {
//   @override
//   void onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
// SharedPreferences prefs = await SharedPreferences.getInstance();
// String? token = await prefs.getString('token');

//     if (token == null) {
//       prefs.setString('token', '');
//     }

//     // options.queryParameters["apiKey"] = AuthStrings.apiKey;
// options.headers = {
//   'Content-Type': 'application/json; charset=UTF-8',
//   'Authorization': 'Bearer $token',
// };
//     options.sendTimeout =  Duration(seconds: 3);
//     // debugLog(options.baseUrl + options.path);
//     // debugLog(options.headers);
//     return super.onRequest(options, handler);
//   }

//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     if (response.statusCode! >= 200) {
//       debugLog("Yes completed");
//     }
//     return super.onResponse(response, handler);
//   }
// }

import 'package:dio/dio.dart';
import 'package:jenos/scr/core/util/logger.dart';

class AppInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token');



    // var headers = {
    //   'Content-Type': 'application/json; charset=UTF-8',
    //   'Authorization': 'Bearer $token',
    // };


    // log("token:$token");

    options.sendTimeout = Duration(milliseconds: 30000);
       options.headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    // debugLog(options.baseUrl + options.path);
    // debugLog(options.headers);
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode! >= 200) {
      debugLog("Yes completed");
    }
    return super.onResponse(response, handler);
  }
}
