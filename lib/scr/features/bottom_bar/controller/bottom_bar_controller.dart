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
    log("validateToken is called");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
        String accountType = prefs.getString('accountType') ?? "";

    final dio = Dio();

    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    // log("token  is called:$token");

    // var url = Uri.parse('${Endpoint.baseUrl}/merchant');

    try {
         var pathUrl =
          accountType == "individual" ? "/rider" : "/enterprise";

      final response = await dio.get(
        "${Endpoint.baseUrl}$pathUrl",
        options: Options(headers: headers),
      );
      return true;
    } on DioException catch (e) {
      return false;
    }
  }
}

/// Provider for accessing the [NavBarController] instance.
final navBarController = StateNotifierProvider<NavBarController, NavBarState>(
    (ref) => NavBarController());
