/// This class defines the SigninNotifier
/// @author  Yusuf umar
/// @version 1.0
/// @since   2023-12-19

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/core/enums.dart';
import 'package:jenos/scr/features/auth/models/user_model.dart';
import 'package:jenos/scr/features/auth/controller/signin/signin_state.dart';
import 'package:jenos/scr/features/auth/repository/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Notifier class for handling the Signin state.
class SigninNotifier extends StateNotifier<SigninState> {
  SigninNotifier(this.authRepository) : super(SigninState.initial());

  final AuthRepository authRepository;

  /// Method to sign in with the provided [model].
  Future<void> signIn(UserModel model) async {
    state = state.copyWith(
      loadState: NetworkState.loading,
    );
    try {
      final response = await authRepository.signIn(model);

      if (response.success) {
        state = state.copyWith(
          userModel: response.data,
          loadState: NetworkState.success,
          message: response.message,
        );

        return;
      }
      state = state.copyWith(
        loadState: NetworkState.error,
        message: response.message,
      );
    } catch (e) {
      state = state.copyWith(
        loadState: NetworkState.error,
        message: e.toString(),
      );
    }
  }

  /// Method to validate the provided email [value].
  String? validateEmail(value) {
    if (value == null || value.isEmpty) {
      return "Email can't be empty";
    }
    return null;
  }

  /// Method to validate the provided password [value].
  String? validatePassword(value) {
    if (value == null || value.isEmpty) {
      return "Password can't be empty";
    }
    return null;
  }

  /// Method to sign out the user by removing the authentication token from SharedPreferences.
  void signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
  }
}

/// Provider for the SigninNotifier class.
final signinNotifier = StateNotifierProvider<SigninNotifier, SigninState>(
    (ref) => SigninNotifier(ref.read(authRepository)));
