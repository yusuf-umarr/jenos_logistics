import 'package:flutter/material.dart';
import 'package:jenos/scr/constant/app_assets.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/core/util.dart';
import 'package:jenos/scr/common_widgets/appbbutton.dart';
import 'package:jenos/scr/common_widgets/navigation.dart';
import 'package:jenos/scr/features/auth/controller/password_visibility/password_notifier.dart';
import 'package:jenos/scr/features/auth/controller/signin/signin_notifier.dart';
import 'package:jenos/scr/features/auth/controller/signup/signup_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/features/auth/pages/signin_page.dart';
import 'package:jenos/scr/features/auth/pages/signup_page.dart';
import 'package:jenos/scr/features/bottom_bar/views/bottom_bar.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
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
    return Scaffold(
        body: Stack(
      children: [
        Image.asset(
          Assets.appBg,
        ),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                  // controller: _auth.firstName,
                ),
                SizedBox(
                  height: size.height * 0.025,
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
                    externalText: "Password",
                    hint: "******",
                    hintColor: Colors.grey,
                    prefixIconColor: AppColors.primaryColor,
                    // controller: _auth.password,
                    validator: signinState.validatePassword,
                    suffixWidget: IconButton(
                      onPressed: () => ref
                          .read(passwordNotifier.notifier)
                          .togglePasswordVisibility(), //toggleConfirmPasswordVisibility
                      icon: Icon(
                        isVisibility ? Icons.visibility : Icons.visibility_off,
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
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: AppColors.primaryColor,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.025,
                ),
                AppButton(
                  isIcon: true,
               
                  text: 'Login ',
                  onPressed: () async {
                    navigate(context, BottomBar());
                  },
                
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
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
      ],
    ));
  }
}
