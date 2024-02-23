import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/common_widgets/appbbutton.dart';
import 'package:jenos/scr/common_widgets/navigation.dart';
import 'package:jenos/scr/core/util/enums.dart';
import 'package:jenos/scr/features/auth/pages/signin_page.dart';
import 'package:jenos/scr/features/auth/pages/signup_page.dart';
import 'package:jenos/scr/features/onboarding/controller/onboard_controller.dart';

class GetStartedScreen extends ConsumerStatefulWidget {
  const GetStartedScreen({super.key});

  @override
  ConsumerState<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends ConsumerState<GetStartedScreen> {
  int selectedValue = 0;
  List<String> accountType = ['Individual Driver', 'Enterprise Driver'];
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xffFAFAFA),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.2,
                ),
                SvgPicture.asset("assets/images/get_started.svg"),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: Text(
                    "Get Started!",
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: SizedBox(
                    child: Text(
                      "Your journey begins here !",
                      style: Theme.of(context).textTheme.labelMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                AppButton(
                  height: 55,
                  text: 'Get Started',
                  onPressed: () async {
                    showModalBottomSheet<void>(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50)),
                      ),
                      builder: (BuildContext context) {
                        return showModal(context);
                      },
                    );
                  },
                  color: AppColors.primaryColor,
                  textColor: Colors.white,
                ),
                const SizedBox(height: 30),
                AppButton(
                    height: 55,
                    text: 'Login',
                    borderColor: AppColors.primaryColor,
                    onPressed: () async {
                      navigate(context, const SignInPage());
                    },
                    color: Colors.white,
                    textColor: AppColors.primaryColor),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showModal(context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(20).copyWith(top: 40),
            height: 380,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Account Type Selection",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Tailored Solutions for Every Journey: Choose Your Account Type Today!",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.black),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: accountType.map((String option) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            onTap: () {
                              setState(() {
                                if (option == "Individual Driver") {
                                  selectedValue = 0;
                                  ref
                                      .read(onboardController.notifier)
                                      .setAccountType(AccountType.individual);
                                } else {
                                  selectedValue = 1;
                                  ref
                                      .read(onboardController.notifier)
                                      .setAccountType(AccountType.enterprise);
                                }
                              });
                            },
                            title: Text(
                              option,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                              textAlign: TextAlign.start,
                            ),
                            trailing: Radio(
                              activeColor: AppColors.primaryColor,
                              value: accountType.indexOf(option),
                              groupValue: selectedValue,
                              onChanged: (int? value) {
                                setState(() {
                                  if (option == "Individual Driver") {
                                    selectedValue = 0;
                                    ref
                                        .read(onboardController.notifier)
                                        .setAccountType(AccountType.individual);
                                  } else {
                                    selectedValue = 1;
                                    ref
                                        .read(onboardController.notifier)
                                        .setAccountType(AccountType.enterprise);
                                  }
                                });
                                // setState(() {
                                //   selectedValue = value!;
                                // });
                              },
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    AppButton(
                        height: 55,
                        isIcon: true,
                        text: 'Proceed',
                        onPressed: () async {
                          if (selectedValue == 0) {
                            navigate(context, const SignupPage());
                          } else {
                            navigate(context, const SignInPage());
                          }
                        },
                        color: AppColors.primaryColor,
                        textColor: Colors.white),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 10,
            top: 5,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.cancel,
                color: AppColors.primaryColor,
              ),
            ),
          )
        ],
      );
    });
  }
}
