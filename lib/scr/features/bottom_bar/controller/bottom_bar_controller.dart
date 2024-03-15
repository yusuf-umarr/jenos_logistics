/// This class defines the NavBarController
/// @author  Yusuf umar
/// @version 1.0
/// @since   2023-12-19
///

import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/constant/app_endpoint.dart';
import 'package:jenos/scr/core/util/enums.dart';
import 'package:jenos/scr/features/bottom_bar/controller/bottom_bar_state.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

/// Controller class for managing the navigation bar state.
class NavBarController extends StateNotifier<NavBarState> {
  NavBarController() : super(NavBarState.initial());

  int currentIndex = 0;

  void setNavbarIndex(int index) {
    currentIndex = index;

    state = state.copyWith(currentIndex: index);
  }

  Future<bool> validateToken() async {
    print("validateToken is called");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String accountType = prefs.getString('accountType') ?? "individual";

    final dio = Dio();
    dio.options.connectTimeout = const Duration(seconds: 15); // 5 seconds timeout

    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    // print("token is called: $token");

    log("=====accountType:$accountType");

    var pathUrl = accountType == "individual" ? "/rider/me" : "/enterprise/me";

    try {
      final response = await dio.get(
        "${Endpoint.baseUrl}$pathUrl",
        options: Options(headers: headers),
      );
      // print("success here: $response");
      return true;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        print("Request timeout");

        return false;
      }
      //  else if (e.type == DioExceptionType.response) {
      //   print("Response error: ${e.response?.statusCode}");
      // }
      else {
        print("Other error: $e");
      }
      return false;
    }
  }
  //
}

/// Provider for accessing the [NavBarController] instance.
final navBarController = StateNotifierProvider<NavBarController, NavBarState>(
    (ref) => NavBarController());
