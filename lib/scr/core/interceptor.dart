
import 'package:dio/dio.dart';
import 'package:jenos/scr/core/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token');

    if (token == null) {
      prefs.setString('x-auth-token', '');
    }

    // options.queryParameters["apiKey"] = AuthStrings.apiKey;
    options.headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
    options.sendTimeout = const Duration(seconds: 3);
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
