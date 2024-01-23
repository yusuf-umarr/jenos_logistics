/// This class defines the OnboardController
/// @author  Yusuf umar
/// @version 1.0
/// @since   2023-12-19
///

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/core/enums.dart';
import 'package:jenos/scr/features/onboarding/controller/onboard_state.dart';

/// Controller class for managing the navigation bar state.
class OnboardController extends StateNotifier<OnboardState> {
  OnboardController() : super(OnboardState.initial());

  void setAccountType(AccountType type) {
    state = state.copyWith(accountType: type);

    print("state:${state.accountType}");
  }
}

/// Provider for accessing the [OnboardController] instance.
final onboardController =
    StateNotifierProvider<OnboardController, OnboardState>(
        (ref) => OnboardController());
