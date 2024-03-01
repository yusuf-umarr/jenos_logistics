import 'package:flutter/material.dart';
import 'package:jenos/scr/core/util/enums.dart';
import 'package:jenos/scr/core/models/user_merchant_model.dart';

/// This class defines the PersonalInformationState
/// @author  Yusuf umar
/// @version 1.0
/// @since   2023-12-19
///

/// Represents the state of the signin process.
class PersonalInformationState {
  /// The network state of the signin process.
  final NetworkState loadState;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addrController = TextEditingController();
  TextEditingController CACRegController = TextEditingController();

  /// uses to store message related to the signin state.
  final String? message;
    String? imagePath;

  PersonalInformationState({
    required this.loadState,
    required this.message,
    required this.imagePath,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.addrController,
    required this.CACRegController,
  });

  /// Factory method to create the initial signin state.
  factory PersonalInformationState.initial() {
    return PersonalInformationState(
      nameController: TextEditingController(),
      emailController: TextEditingController(),
      phoneController: TextEditingController(),
      addrController: TextEditingController(),
      CACRegController: TextEditingController(),
      loadState: NetworkState.idle,
      message: null,
      imagePath: null,
    );
  }

  /// Method to create a new PersonalInformationState by copying the current state and applying changes to specified properties.
  PersonalInformationState copyWith({
    NetworkState? loadState,
    String? message,
    String? imagePath,
    nameController,
    emailController,
    phoneController,
    addrController,
    CACRegController,
  }) {
    return PersonalInformationState(
      loadState: loadState ?? this.loadState,
      message: message ?? this.message,
      imagePath: imagePath ?? this.imagePath,
      nameController: nameController ?? this.nameController,
      phoneController: phoneController ?? this.phoneController,
      emailController: emailController ?? this.emailController,
      addrController: addrController ?? this.addrController,
      CACRegController: CACRegController ?? this.CACRegController,
    );
  }
}
