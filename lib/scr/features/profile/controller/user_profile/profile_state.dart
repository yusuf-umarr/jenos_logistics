import 'package:flutter/material.dart';
import 'package:jenos/scr/core/util/enums.dart';
import 'package:jenos/scr/core/models/user_merchant_model.dart';

/// This class defines the ProfileState
/// @author  Yusuf umar
/// @version 1.0
/// @since   2023-12-19
///

/// Represents the state of the signin process.
class ProfileState {
  /// The network state of the signin process.
  final NetworkState loadState;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addrController = TextEditingController();
  TextEditingController entAddrController = TextEditingController();
  TextEditingController CACRegController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController acctNameController = TextEditingController();
  TextEditingController acctNumberController = TextEditingController();

  /// uses to store message related to the signin state.
  final String? message;
  String? imagePath;
  String wallet;
  List? appNotificationList;

  ProfileState({
    required this.loadState,
    required this.message,
    required this.imagePath,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.addrController,
    required this.entAddrController,
    required this.CACRegController,
    required this.bankNameController,
    required this.acctNameController,
    required this.acctNumberController,
    this.appNotificationList,
    required this.wallet,
  });

  /// Factory method to create the initial signin state.
  factory ProfileState.initial() {
    return ProfileState(
      nameController: TextEditingController(),
      emailController: TextEditingController(),
      phoneController: TextEditingController(),
      addrController: TextEditingController(),
      CACRegController: TextEditingController(),
      entAddrController: TextEditingController(),
      bankNameController: TextEditingController(),
      acctNameController: TextEditingController(),
      acctNumberController: TextEditingController(),
      loadState: NetworkState.idle,
      message: null,
      imagePath: null,
      wallet: "0:00",
      appNotificationList: [],
    );
  }

  /// Method to create a new ProfileState by copying the current state and applying changes to specified properties.
  ProfileState copyWith({
    NetworkState? loadState,
    String? message,
    String? imagePath,
    nameController,
    emailController,
    phoneController,
    addrController,
    entAddrController,
    CACRegController,
    bankNameController,
    acctNameController,
    acctNumberController,
    appNotificationList,
    wallet,
  }) {
    return ProfileState(
      loadState: loadState ?? this.loadState,
      message: message ?? this.message,
      imagePath: imagePath ?? this.imagePath,
      nameController: nameController ?? this.nameController,
      phoneController: phoneController ?? this.phoneController,
      emailController: emailController ?? this.emailController,
      addrController: addrController ?? this.addrController,
      CACRegController: CACRegController ?? this.CACRegController,
      appNotificationList: appNotificationList ?? this.appNotificationList,
      entAddrController: entAddrController ?? this.entAddrController,
      bankNameController: bankNameController ?? this.bankNameController,
      acctNameController: acctNameController ?? this.acctNameController,
      acctNumberController: acctNumberController ?? this.acctNumberController,
      wallet: wallet ?? this.wallet,
    );
  }
}
