/// This class defines the PersonalInfoNotifier
/// @author  Yusuf umar
/// @version 1.0
/// @since   2023-12-19


import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/core/util/enums.dart';
import 'package:jenos/scr/features/profile/controller/personal_info/personal_info_state.dart';
import 'package:jenos/scr/core/repository/profile_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Notifier class for handling the Signin state.
class PersonalInfoNotifier extends StateNotifier<PersonalInformationState> {
  PersonalInfoNotifier(this.profileRepository)
      : super(PersonalInformationState.initial());

  final ProfileRepository profileRepository;

  Future<void> getUserData() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
    String accountType = prefs.getString('accountType') ?? ""; 
    //address

    log("get sritn accountType:$accountType");
    try {
      final response = await profileRepository.getUserData();

      if (response.success) {

        // log("getUserData res:${response.data}");
        state = state.copyWith(
          nameController:
              TextEditingController(text: accountType == "individual"? response.data["userName"]: response.data["fullName"]),
          emailController: TextEditingController(text: response.data["email"]),
          phoneController:
              TextEditingController(text: response.data["phoneNumber"]),
          addrController: TextEditingController(
              text: response.data["address"]),
          imagePath: response.data["image"],
          // CACRegController: TextEditingController(text: accountType != "individual"? response.data["CACReg"]: ""),
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

  void clearUserData() {
    state = state.copyWith(
      imagePath: state.imagePath = null,
      nameController: state.nameController = TextEditingController(),
      emailController: state.emailController = TextEditingController(),
      phoneController: state.phoneController = TextEditingController(),
      addrController: state.addrController = TextEditingController(),
    );

  }

    Future<void> getNotifications() async {
    try {
      final response = await profileRepository.getNotifications();

      if (response.success) {
        state = state.copyWith(appNotificationList: response.data);

        log("getNotifications:${state.appNotificationList}");

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

//

  Future<void> updateProfile(
      String fullName, String phoneNumber, String address,
      {bool isMerchant = true}) async {
    state = state.copyWith(
      loadState: NetworkState.loading,
    );
    try {
      // print("update profile =fullName=${fullName}");
      // print("update profile =phoneNumber=${phoneNumber}");
      // print("update profile =address=${address}");
      final response = await profileRepository.updateProfile(
        fullName,
        phoneNumber,
        address,
      );

      if (response.success) {
        state = state.copyWith(
          loadState: NetworkState.success,
          message: response.message,
        );

        // log("message:${state.message}");
        // log("response.data:${response.data}");

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

  Future<void> uploadProfileImage(imagePath, {bool isMerchant = true}) async {
    state = state.copyWith();
    try {
      final response = await profileRepository.uploadImage(
        imagePath,
      );

      if (response.success) {
        state = state.copyWith(
          // loadState: NetworkState.success,
          message: response.message,
        );

        getUserData();

        // log("message:${state.message}");
        // log("response.data:${response.data}");

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

  resetState() {
    state = state.copyWith(
      loadState: NetworkState.idle,
    );
  }

  logOut(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove('token');
    await prefs.remove('userId');
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/get-started', (Route<dynamic> route) => false);
    clearUserData();
  }
}

/// Provider for the PersonalInfoNotifier class.
final personalInfoNotifier =
    StateNotifierProvider<PersonalInfoNotifier, PersonalInformationState>(
        (ref) => PersonalInfoNotifier(ref.read(profileRepository)));
