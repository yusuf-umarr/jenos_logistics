import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/common_widgets/appbbutton.dart';
import 'package:jenos/scr/common_widgets/custom_widget.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/constant/app_size.dart';
import 'package:jenos/scr/core/util/enums.dart';
import 'package:jenos/scr/core/util/util.dart';
import 'package:jenos/scr/features/auth/controller/password_visibility/password_notifier.dart';
import 'package:jenos/scr/features/profile/controller/user_profile/pprofile_controller.dart';
import 'package:jenos/scr/features/profile/controller/user_profile/profile_state.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _rkey = GlobalKey<FormState>();

  final TextEditingController _oldPassController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _oldPassController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  File? image;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Consumer(builder: (context, ref, _) {
      ref.listen<ProfileState>(profileController, (prev, state) {
        if (state.loadState == NetworkState.error) {
          Util.showSnackBar(
            context,
            state.message.toString(),
            color: Colors.red,
          );
        } else if (state.loadState == NetworkState.success) {
          Util.showSnackBar(
            context,
            state.message.toString(),
          );

          Timer(const Duration(seconds: 3), () {
            ref.read(profileController.notifier).getUserData();

            Navigator.of(context).pop();
          });
        }
      });
      return Scaffold(
        appBar: CustomWidget.customAppbar(context,
            title: "Change password", isArrow: true),
        body: Form(
          key: _rkey,
          child: ListView(
            padding: const EdgeInsets.all(AppSize.defaultPadding),
            children: [
              const SizedBox(
                height: AppSize.defaultPadding,
              ),
              Consumer(builder: (context, ref, _) {
                final isVisibility = ref.watch(passwordNotifier).visibility;
                return Util.inputField2(
                  isExternalLabel: true,
                  isPassword: isVisibility,
                  useExternalText: true,
                  isPrefix: false,
                  isCompulsory: false,
                  fontSizeExternal: 14,
                  borderRadius: 5,
                  externalTextColor: Colors.black,
                  borderColor: AppColors.greyColor,
                  bgColor: Colors.white,
                  externalText: "Old password",
                  hint: "******",
                  hintColor: Colors.grey,
                  prefixIconColor: AppColors.primaryColor,
                  controller: _oldPassController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return '*This field is required';
                    }
                    if (val.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                  suffixWidget: IconButton(
                    onPressed: () => ref
                        .read(passwordNotifier.notifier)
                        .togglePasswordVisibility(),
                    icon: Icon(
                      isVisibility ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                  isIcon: true,
                );
              }),

              const SizedBox(
                height: AppSize.defaultPadding * 1.5,
              ),
              Consumer(builder: (context, ref, _) {
                final isVisible = ref.watch(passwordNotifier).confirmVisibility;
                return Util.inputField2(
                  isExternalLabel: true,
                  isPassword: isVisible,
                  useExternalText: true,
                  isPrefix: false,
                  isCompulsory: false,
                  fontSizeExternal: 14,
                  borderRadius: 5,
                  externalTextColor: Colors.black,
                  borderColor: AppColors.greyColor,
                  bgColor: Colors.white,
                  externalText: "New password",
                  hint: "******",
                  hintColor: Colors.grey,
                  prefixIconColor: AppColors.primaryColor,
                  controller: _newPasswordController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return '*This field is required';
                    }
                    if (val.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                  suffixWidget: IconButton(
                    onPressed: () => ref
                        .read(passwordNotifier.notifier)
                        .toggleConfirmPasswordVisibility(),
                    icon: Icon(
                      isVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                  isIcon: true,
                );
              }),

              const SizedBox(
                height: AppSize.defaultPadding * 1.5,
              ),
              // Text(
              //   "Must be a minimum of 8 characters long, and must contain at least one special character, at least one uppercase letter and at least one numerical digit.",
              //   style: Theme.of(context)
              //       .textTheme
              //       .bodySmall!
              //       .copyWith(fontWeight: FontWeight.w500, color: AppColors.grey),
              // ),
              Consumer(builder: (context, ref, _) {
                final isVisible = ref.watch(passwordNotifier).confirmVisibility;
                return Util.inputField2(
                  isExternalLabel: true,
                  isPassword: isVisible,
                  useExternalText: true,
                  isPrefix: false,
                  isCompulsory: false,
                  fontSizeExternal: 14,
                  borderRadius: 5,
                  externalTextColor: Colors.black,
                  borderColor: AppColors.greyColor,
                  bgColor: Colors.white,
                  externalText: "Confirm password",
                  hint: "******",
                  hintColor: Colors.grey,
                  prefixIconColor: AppColors.primaryColor,
                  controller: _confirmPasswordController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return '*This field is required';
                    }
                    if (val != _newPasswordController.text) {
                      return 'Password does not match';
                    }
                    return null;
                  },
                  suffixWidget: IconButton(
                    onPressed: () => ref
                        .read(passwordNotifier.notifier)
                        .toggleConfirmPasswordVisibility(),
                    icon: Icon(
                      isVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                  isIcon: true,
                );
              }),
              const SizedBox(
                height: AppSize.defaultPadding * 1.5,
              ),
              const SizedBox(
                height: AppSize.defaultPadding * 2,
              ),
              Consumer(builder: (context, ref, _) {
                final loadState = ref.watch(profileController).loadState;

                final personalNotifier = ref.read(profileController.notifier);

                //loadState: NetworkState.loading
                return AppButton(
                  isIcon: true,
                  isLoading: loadState == NetworkState.loading,
                  text: 'Update password',
                  onPressed: () async {
                    FocusScope.of(context).unfocus();

                    if (_rkey.currentState!.validate()) {
                      // personalNotifier.changePassword(
                      //   _oldPassController.text,
                      //   _newPasswordController.text,
                      // );

                      _oldPassController.clear();
                      _newPasswordController.clear();
                      _confirmPasswordController.clear();
                    }
                    // navigate(context, const SignInPage());
                  },
                );
              }),
            ],
          ),
        ),
      );
    });
  }
}
