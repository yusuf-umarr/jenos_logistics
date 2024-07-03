/*
Pinput(
    onCompleted: (pin) => print(pin),
  );
*/

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:jenos/scr/constant/app_assets.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/core/util/enums.dart';
import 'package:jenos/scr/common_widgets/appbbutton.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/features/auth/controller/signup/signup_notifier.dart';
import 'package:pinput/pinput.dart';

class VerifyOtp extends ConsumerStatefulWidget {
  static const String routeName = '/verify-otp';

  const VerifyOtp({super.key});

  @override
  ConsumerState<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends ConsumerState<VerifyOtp> {
  final _rkey = GlobalKey<FormState>();

  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const fillColor = Colors.white;
    const borderColor = Color(0xFF918D8D);

    final defaultPinTheme = PinTheme(
      margin: const EdgeInsets.only(right: 5),
      width: 42,
      height: 48,
      textStyle: const TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primaryColor),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: fillColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
    );
    final Size size = MediaQuery.of(context).size;
    return Consumer(builder: (context, ref, _) {
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
                      "Verify your",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 30,
                          ),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      "Otp",
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
                      "Please enter the otp sent to the provided email below",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 15,
                          ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Pinput(
                          pinputAutovalidateMode:
                              PinputAutovalidateMode.onSubmit,
                          // focusNode: focusNode,
                          defaultPinTheme: defaultPinTheme,
                          submittedPinTheme: submittedPinTheme,
                          focusedPinTheme: focusedPinTheme,
                          validator: (s) {
                            if (s!.length < 4) {
                              return "Incorrect pin";
                            } else {
                              return null;
                            }
                          },
                          onCompleted: (pin) => log(pin),
                          controller: _otpController,
                        ),
                      ],
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
                            log("getting called");
                            ref.read(signupNotifier.notifier).verifyOtp(
                                  _otpController.text,
                                  context,
                                );
                          } else {
                            log("not getting called");
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
