/// This class defines the OnboardController
/// @author  Yusuf umar
/// @version 1.0
/// @since   2023-12-19
///

import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/core/util/enums.dart';
import 'package:jenos/scr/features/onboarding/controller/onboard_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Controller class for managing the navigation bar state.
class OnboardController extends StateNotifier<OnboardState> {
  OnboardController() : super(OnboardState.initial());

  void setAccountType(AccountType type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    state = state.copyWith(accountType: type);

    if (state.accountType == AccountType.individual) {
      prefs.setString("accountType", "individual");
    } else {
      prefs.setString("accountType", "enterprise");
    }
    log("state accountType:${state.accountType}");
  }

  void getAccountType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String account = prefs.getString("accountType") ?? "individual";
    //
    if (account == "individual") {
      state = state.copyWith(accountType: AccountType.individual);
    } else {
      state = state.copyWith(accountType: AccountType.enterprise);
    }
    log("state accountType:${state.accountType}");
  }
}

/// Provider for accessing the [OnboardController] instance.
final onboardController =
    StateNotifierProvider<OnboardController, OnboardState>(
        (ref) => OnboardController());
