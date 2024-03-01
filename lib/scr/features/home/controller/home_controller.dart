/// This class defines the HomeController
/// @author  Yusuf umar
/// @version 1.0
/// @since   2023-12-19
///

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/features/bottom_bar/controller/bottom_bar_state.dart';
import 'package:dio/dio.dart';
import 'package:jenos/scr/features/home/controller/home_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Controller class for managing the navigation bar state.
class HomeController extends StateNotifier<HomeState> {
  HomeController() : super(HomeState.initial());

  void setShowPop(bool show) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool("isShowPop", show);

    state = state.copyWith(isShowPop: show);
  }

//uses to display home pop-up-setting when first open the app
  void getShowPop() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool pop = prefs.getBool("isShowPop") ?? false;

    state = state.copyWith(isShowPop: pop);
  }
}

/// Provider for accessing the [HomeController] instance.
final homeController =
    StateNotifierProvider<HomeController, HomeState>((ref) => HomeController());
