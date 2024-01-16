/// This class defines the SignupNotifier
/// @author  Yusuf umar
/// @version 1.0
/// @since   2023-07-19 


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/core/enums.dart';
import 'package:jenos/scr/features/auth/models/user_model.dart';
import 'package:jenos/scr/features/auth/controller/signup/signup_state.dart';
import 'package:jenos/scr/features/auth/repository/auth_repository.dart';

/// Notifier class for handling the Signup state.
class SignupNotifier extends StateNotifier<SignupState> {
  SignupNotifier(this.authRepository) : super(SignupState.initial());

  final AuthRepository authRepository;

  /// Method to sign up with the provided [model].
  Future<void> signUp(UserModel model) async {
    state = state.copyWith(
      loadState: NetworkState.loading,
    );
    try {
      final response = await authRepository.signUp(model);

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

  /// Method to validate the provided password [value].
  String? validatePassword(value) {
    if (value.isEmpty || value == null) {
      return "Password can't be empty";
    } else if (value.length < 8) {
      return "Password must be at least 8 characters";
    } else if (!value.contains(RegExp('[A-Z]'))) {
      return "Password must contain upper and lower case characters";
    } else if (!value.contains(RegExp('[0-9]'))) {
      return "Password must contain a number";
    } else if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return "Password must contain a special character";
    }
    return null;
  }

  /// Method to validate the provided email [value].
  String? validateEmail(value) {
    if (value == null || value.isEmpty) {
      return "Email can't be empty";
    }
    return null;
  }

  /// Method to validate the provided name [value].
  String? validateName(value) {
    if (value == null || value.isEmpty) {
      return "Name can't be empty";
    }
    return null;
  }
}

/// Provider for the SignupNotifier class.
final signupNotifier = StateNotifierProvider<SignupNotifier, SignupState>(
    (ref) => SignupNotifier(ref.read(authRepository)));
