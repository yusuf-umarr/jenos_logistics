/// This class defines the NavBarController
/// @author  Yusuf umar
/// @version 1.0
/// @since   2023-12-19
///

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/features/bottom_bar/controller/bottom_bar_state.dart';
import 'package:dio/dio.dart';

/// Controller class for managing the navigation bar state.
class NavBarController extends StateNotifier<NavBarState> {
  NavBarController() : super(NavBarState.initial());

  int currentIndex = 0;

  void setNavbarIndex(int index) {
    currentIndex = index;

    state = state.copyWith(currentIndex: index);
  }

  Future<bool> validateToken() async {
    final dio = Dio();

    try {
      final response = await dio.get(
        "auth/get-user",
      );
      // print("get profile-------------${response.body}");

      if (response.statusCode == 200) {
        print(" Token is valid");
        return true; // Token is valid
      } else {
        print("Token is invalid");
        return false; // Token is invalid
      }
    } catch (e) {
      print('Error validating token: $e');
      return false; // Error occurred during validation
    }
  }
}

/// Provider for accessing the [NavBarController] instance.
final navBarController = StateNotifierProvider<NavBarController, NavBarState>(
    (ref) => NavBarController());
