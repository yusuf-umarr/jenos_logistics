import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jenos/scr/constant/app_assets.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/core/util/enums.dart';
import 'package:jenos/scr/core/util/util.dart';
import 'package:jenos/scr/common_widgets/appbbutton.dart';
import 'package:jenos/scr/features/auth/controller/signin/signin_notifier.dart';
import 'package:jenos/scr/features/auth/controller/signin/signin_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/features/auth/controller/signup/signup_notifier.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  static const String routeName = '/forgot-password';

  const ForgotPassword({super.key});

  @override
  ConsumerState<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
  final _rkey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signinState = ref.read(signinNotifier.notifier);
    final Size size = MediaQuery.of(context).size;
    return Consumer(builder: (context, ref, _) {
      ref.listen<SigninState>(signinNotifier, (prev, state) {
        if (state.loadState == NetworkState.error) {
          // Util.showSnackBar(
          //   context,
          //   state.message != "" ? state.message.toString() : "Server unavailable, please try again",
          //   color: Colors.red,
          // );
        } else if (state.loadState == NetworkState.success) {
          Timer(const Duration(seconds: 1), () {});
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
                      "Forgot your",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 30,
                          ),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      "Password",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: AppColors.primaryColor,
                            fontSize: 30,
                          ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Text(
                      "Please enter your email address in the field below",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 15,
                          ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Util.inputField2(
                      externalText: "Email",
                      hint: "john@gmail.com",
                      controller: _emailController,
                      validator: signinState.validateEmail,
                    ),
                    SizedBox(
                      height: size.height * 0.09,
                    ),
                    Consumer(builder: (context, ref, _) {
                      final loadState = ref.watch(signupNotifier).loadState;

                      return AppButton(
                        isIcon: true,
                        isLoading: loadState == NetworkState.loading,
                        text: 'Proceed ',
                        onPressed: () async {
                          FocusScope.of(context).unfocus();

                          if (_rkey.currentState!.validate()) {
                            ref.read(signupNotifier.notifier).forgotPassword(
                                  _emailController.text,
                                  context,
                                );
                          }
                        },
                      );
                    }),
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
