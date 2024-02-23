import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jenos/scr/constant/app_assets.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/core/util/enums.dart';
import 'package:jenos/scr/core/util/util.dart';
import 'package:jenos/scr/common_widgets/appbbutton.dart';
import 'package:jenos/scr/common_widgets/navigation.dart';
import 'package:jenos/scr/features/auth/controller/password_visibility/password_notifier.dart';
import 'package:jenos/scr/features/auth/controller/signup/signup_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/features/auth/controller/signup/signup_state.dart';
import 'package:jenos/scr/features/auth/pages/signin_page.dart';
import 'package:jenos/scr/features/onboarding/controller/onboard_controller.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final _rkey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signupState = ref.read(signupNotifier.notifier);
    final Size size = MediaQuery.of(context).size;

    return Consumer(builder: (context, ref, _) {
      ref.listen<SignupState>(signupNotifier, (prev, state) {
        if (state.loadState == NetworkState.error) {
          Util.showSnackBar(
            context,
            state.message != "" ? state.message.toString() : "Server error",
            color: Colors.red,
          );
        } else if (state.loadState == NetworkState.success) {
          Util.showSnackBar(
            context,
            state.message.toString(),
          );
          Timer(const Duration(seconds: 4), () {
            navigate(context, const SignInPage());
          });
        }
      });
      return Scaffold(
          body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              Assets.appBg,
            ),
            SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Form(
                  key: _rkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        "Start your",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 30,
                            ),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        "Journey",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: AppColors.primaryColor,
                              fontSize: 30,
                            ),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Util.inputField2(
                        isExternalLabel: true,
                        useExternalText: true,
                        isPrefix: false,
                        isCompulsory: false,
                        fontSizeExternal: 14,
                        borderRadius: 5,
                        borderColor: AppColors.greyColor,
                        bgColor: Colors.white,
                        externalText: "Username",
                        hint: "example: john",
                        hintColor: Colors.grey,
                        externalTextColor: Colors.black,
                        prefixIconColor: AppColors.primaryColor,
                        controller: _nameController,
                        validator: signupState.validateName,

                        // validator: (val) {
                        //   if (val!.isEmpty) {
                        //     return '*This field is required';
                        //   }

                        //   return null;
                        // },
                      ),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      Util.inputField2(
                        isExternalLabel: true,
                        useExternalText: true,
                        isPrefix: false,
                        isCompulsory: false,
                        fontSizeExternal: 14,
                        borderRadius: 5,
                        borderColor: AppColors.greyColor,
                        bgColor: Colors.white,
                        externalText: "Phone number",
                        hint: "example: 08012345678",
                        inputType: TextInputType.number,
                        hintColor: Colors.grey,
                        externalTextColor: Colors.black,
                        prefixIconColor: AppColors.primaryColor,
                        controller: _phoneController,
                        validator: signupState.validatePhone,
                      ),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      Util.inputField2(
                        isExternalLabel: true,
                        useExternalText: true,
                        isPrefix: false,
                        isCompulsory: false,
                        fontSizeExternal: 14,
                        borderRadius: 5,
                        borderColor: AppColors.greyColor,
                        bgColor: Colors.white,
                        externalText: "Email address",
                        hint: "example: john@gmail.com",
                        hintColor: Colors.grey,
                        externalTextColor: Colors.black,
                        prefixIconColor: AppColors.primaryColor,
                        controller: _emailController,
                        validator: signupState.validateEmail,
                      ),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      Consumer(builder: (context, ref, _) {
                        final isVisibility =
                            ref.watch(passwordNotifier).visibility;
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
                          externalText: "Password",
                          hint: "******",
                          hintColor: Colors.grey,
                          prefixIconColor: AppColors.primaryColor,
                          controller: _passwordController,
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
                              isVisibility
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          isIcon: true,
                        );
                      }),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      Consumer(builder: (context, ref, _) {
                        final isVisible =
                            ref.watch(passwordNotifier).confirmVisibility;
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
                          externalText: "Retype password",
                          hint: "******",
                          hintColor: Colors.grey,
                          prefixIconColor: AppColors.primaryColor,
                          controller: _confirmPasswordController,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return '*This field is required';
                            }
                            if (val != _passwordController.text) {
                              return 'Password does not match';
                            }
                            return null;
                          },
                          suffixWidget: IconButton(
                            onPressed: () => ref
                                .read(passwordNotifier.notifier)
                                .toggleConfirmPasswordVisibility(),
                            icon: Icon(
                              isVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          isIcon: true,
                        );
                      }),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      Consumer(builder: (context, ref, _) {
                        final loadState = ref.watch(signupNotifier).loadState;

                        final accountType =
                            ref.watch(onboardController).accountType;

                        //loadState: NetworkState.loading
                        return AppButton(
                          isIcon: true,
                          isLoading: loadState == NetworkState.loading,
                          text: 'Register',
                          onPressed: () async {
                            FocusScope.of(context).unfocus();

                            if (_rkey.currentState!.validate()) {
                              signupState.signUp(
                                _emailController.text,
                                _passwordController.text,
                                _nameController.text,
                                _phoneController.text,
                              );

                              _passwordController.clear();
                              _confirmPasswordController.clear();
                            }
                            // navigate(context, const SignInPage());
                          },
                        );
                      }),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: Theme.of(context).textTheme.labelMedium,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              navigate(context, const SignInPage());
                            },
                            child: Text(
                              "Login here",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ));
    });
  }
}
