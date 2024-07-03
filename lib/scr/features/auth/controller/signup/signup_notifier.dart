/// This class defines the SignupNotifier
/// @author  Yusuf umar
/// @version 1.0
/// @since   2023-12-19

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/common_widgets/navigation.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/core/util/enums.dart';
import 'package:jenos/scr/core/util/util.dart';
import 'package:jenos/scr/features/auth/controller/signup/signup_state.dart';
import 'package:jenos/scr/core/repository/auth_repository.dart';
import 'package:jenos/scr/features/auth/pages/reset_password.dart';
import 'package:jenos/scr/features/auth/pages/signin_page.dart';
import 'package:jenos/scr/features/auth/pages/verify_otp.dart';

/// Notifier class for handling the Signup state.
class SignupNotifier extends StateNotifier<SignupState> {
  SignupNotifier(this.authRepository) : super(SignupState.initial());

  final AuthRepository authRepository;

  /// Method to sign up
  Future<void> signUp(
    String email,
    String password,
    String userName,
    String phoneNumber, 
      context,
    {
    bool isMerchant = false,
  
  } ) async {
    state = state.copyWith(
      loadState: NetworkState.loading,
    );
    try {
      final response = await authRepository.signUp(
        email,
        password,
        userName,
        phoneNumber,
      );

      if (response.success) {
        state = state.copyWith(
          userModel: response.data,
          loadState: NetworkState.success,
          message: response.message,
        );
           Util.showSnackBar(
          context,
          state.message.toString(),
        );
        Timer(const Duration(seconds: 4), () {
          navigate(context, const SignInPage());
        });

        return;
      }
      // log("account error ${response.data}");

      state = state.copyWith(
        loadState: NetworkState.error,
        message: response.message,
      );
         Util.showSnackBar(
        context,
        state.message != "" ? state.message.toString() : "Server error",
        color: Colors.red,
      );
      // log("account error ${response.data}");

      return;
    } catch (e) {
      state = state.copyWith(
        loadState: NetworkState.error,
        message: e.toString(),
      );
    }
  }

  /// Method to validate the provided email [value].
  String? validateEmail(value) {
    // validator: (val) {
    if (value.isEmpty) {
      return '*This field is required';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePhone(value) {
    if (value == null || value.isEmpty) {
      return '*This field is required';
    }
    if (value.length < 10 || value.length > 11) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? validateName(value) {
    if (value == null || value.isEmpty) {
      return '*This field is required';
    }
    return null;
  }

  String? validatePass(value) {
    if (value!.isEmpty) {
      return '*This field is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateConfirmPass(value, confirm) {
    if (value!.isEmpty) {
      return '*This field is required';
    }
    if (value != confirm.text) {
      return 'Password does not match';
    }
    return null;
  }

    //
  Future<void> forgotPassword(
    String email,
    context,
  ) async {
    state = state.copyWith(
      loadState: NetworkState.loading,
    );
    try {
      final response = await authRepository.forgotPassword(email);

      if (response.success) {
        log("forgotPassword response success:$response");
        state = state.copyWith(
          userModel: response.data,
          loadState: NetworkState.success,
          message: response.message,
        );
        navigate(context, const VerifyOtp());

        Future.delayed(const Duration(seconds: 1), () {
          state = state.copyWith(
            loadState: NetworkState.idle,
          );
        });

        return;
      }
      state = state.copyWith(
        loadState: NetworkState.error,
        message: response.message,
      );
      log("response.message erro 1:${response.message}");

      Util.showSnackBar(
        context,
        state.message != ""
            ? state.message.toString()
            : "Server unavailable, please try again",
        color: Colors.red,
      );

      return;
    } catch (e) {
      state = state.copyWith(
        loadState: NetworkState.error,
        message: e.toString(),
      );
    }
  }

//
  Future<void> verifyOtp(
    String otp,
    context,
  ) async {
    state = state.copyWith(
      loadState: NetworkState.loading,
    );
    try {
      final response = await authRepository.verifyOtp(otp);

      if (response.success) {
        state = state.copyWith(
          userModel: response.data,
          loadState: NetworkState.success,
          message: response.message,
        );

        Future.delayed(const Duration(seconds: 1), () {
          state = state.copyWith(
            loadState: NetworkState.idle,
          );
        });
        navigate(context, const ResetPassword());

        return;
      }
      state = state.copyWith(
        loadState: NetworkState.error,
        message: response.message,
      );
      log("response.message erro 1:${response.message}");

      Util.showSnackBar(
        context,
        state.message != ""
            ? state.message.toString()
            : "Server unavailable, please try again",
        color: Colors.red,
      );

      return;
    } catch (e) {
      state = state.copyWith(
        loadState: NetworkState.error,
        message: e.toString(),
      );

      log("response.message error 2$e");
    }
  }

//
  Future<void> resetPassword(
    String password,
    context,
  ) async {
    state = state.copyWith(
      loadState: NetworkState.loading,
    );
    try {
      final response = await authRepository.resetPassword(password);

      if (response.success) {
        state = state.copyWith(
          userModel: response.data,
          loadState: NetworkState.success,
          message: response.message,
        );
        Util.showSnackBar(
          context,
          "Password reset successful",
          color: AppColors.primaryColor,
        );

        Future.delayed(const Duration(seconds: 2), () {
          state = state.copyWith(
            loadState: NetworkState.idle,
          );
          navigate(context, const SignInPage());
        });

        return;
      }
      state = state.copyWith(
        loadState: NetworkState.error,
        message: response.message,
      );
      log("response.message erro 1:${response.message}");

      Util.showSnackBar(
        context,
        state.message != ""
            ? state.message.toString()
            : "Server unavailable, please try again",
        color: Colors.red,
      );

      return;
    } catch (e) {
      state = state.copyWith(
        loadState: NetworkState.error,
        message: e.toString(),
      );

      log("response.message error 2$e");
    }
  }

//
}

/// Provider for the SignupNotifier class.
final signupNotifier = StateNotifierProvider<SignupNotifier, SignupState>(
    (ref) => SignupNotifier(ref.read(authRepository)));
