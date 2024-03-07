import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jenos/scr/constant/app_assets.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/core/util/enums.dart';
import 'package:jenos/scr/core/util/util.dart';
import 'package:jenos/scr/common_widgets/appbbutton.dart';
import 'package:jenos/scr/common_widgets/navigation.dart';
import 'package:jenos/scr/features/auth/controller/password_visibility/password_notifier.dart';
import 'package:jenos/scr/features/auth/controller/signin/signin_notifier.dart';
import 'package:jenos/scr/features/auth/controller/signin/signin_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/features/auth/pages/signup_page.dart';
import 'package:jenos/scr/features/bottom_bar/controller/bottom_bar_controller.dart';
import 'package:jenos/scr/features/onboarding/controller/onboard_controller.dart';

class SignInPage extends ConsumerStatefulWidget {
  static const String routeName = '/login';

  const SignInPage({super.key});

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final _rkey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signinState = ref.read(signinNotifier.notifier);
    final Size size = MediaQuery.of(context).size;
    return Consumer(builder: (context, ref, _) {
      final accountType = ref.watch(onboardController).accountType;

      ref.listen<SigninState>(signinNotifier, (prev, state) {
        if (state.loadState == NetworkState.error) {
       
          Util.showSnackBar(
            context,
            state.message != "" ? state.message.toString() : "Server error",
            color: Colors.red,
          );
        } else if (state.loadState == NetworkState.success) {
          Timer(const Duration(seconds: 1), () {
            // ref.read(userDataNotifier.notifier).getUserData();

            //  Navigator.pushNamedAndRemoveUntil(
            //               context, BottomBar.routeName, (route) => false);
            ref.read(navBarController.notifier).setNavbarIndex(0);

            Navigator.of(context).pushNamedAndRemoveUntil(
                '/bottom-bar', (Route<dynamic> route) => false);
          });
        }
      });
      return Scaffold(
          body: Stack(
        children: [
          Image.asset(
            Assets.appBg,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Form(
                key: _rkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.25,
                    ),
                    Text(
                      "Resume your",
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
                      externalText: "Email",
                      hint: "john@gmail.com",
                      hintColor: Colors.grey,
                      externalTextColor: Colors.black,
                      prefixIconColor: AppColors.primaryColor,
                      controller: _emailController,
                      validator: signinState.validateEmail,
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
                        validator: signinState.validatePassword,
                        suffixWidget: IconButton(
                          onPressed: () => ref
                              .read(passwordNotifier.notifier)
                              .togglePasswordVisibility(), //toggleConfirmPasswordVisibility
                          icon: Icon(
                            isVisibility
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        isIcon: true,
                        // onSuffixIconClick: () {},
                      );
                    }),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    GestureDetector(
                      onTap: () {
                        navigate(context, const SignupPage());
                      },
                      child: Text(
                        "Forgot password",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                color: AppColors.primaryColor,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    Consumer(builder: (context, ref, _) {
                      final loadState = ref.watch(signinNotifier).loadState;

                      return AppButton(
                        isIcon: true,
                        isLoading: loadState == NetworkState.loading,
                        text: 'Login ',
                        onPressed: () async {
                          FocusScope.of(context).unfocus();

                          if (_rkey.currentState!.validate()) {
                            signinState.signIn(
                              _emailController.text,
                              _passwordController.text,
                            );

                            _passwordController.clear();
                          }
                          // navigate(context, BottomBar());
                        },
                      );
                    }),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    if (accountType == AccountType.individual)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don’t have any account?",
                            style: Theme.of(context).textTheme.labelMedium,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              navigate(context, const SignupPage());
                            },
                            child: Text(
                              "Register here",
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
      ));
    });
  }
}
