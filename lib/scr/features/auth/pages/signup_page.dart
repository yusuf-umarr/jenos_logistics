import 'package:flutter/material.dart';
import 'package:jenos/scr/constant/app_assets.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/core/util.dart';
import 'package:jenos/scr/common_widgets/appbbutton.dart';
import 'package:jenos/scr/common_widgets/navigation.dart';
import 'package:jenos/scr/features/auth/controller/password_visibility/password_notifier.dart';
import 'package:jenos/scr/features/auth/controller/signup/signup_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/features/auth/pages/signin_page.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signupState = ref.read(signupNotifier.notifier);
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
                  height: size.height * 0.1,
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
                  externalText: "Full name",
                  hint: "example: john",
                  hintColor: Colors.grey,
                  externalTextColor: Colors.black,
                  prefixIconColor: AppColors.primaryColor,
                  // controller: _auth.firstName,
                  onChanged: (val) {
                    setState(() {
                      // _auth.firstName.text = val;
                    });
                  },
                  // onSuffixIconClick: () {},
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
                  hintColor: Colors.grey,
                  externalTextColor: Colors.black,
                  prefixIconColor: AppColors.primaryColor,
                  // controller: _auth.firstName,
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
                    validator: signupState.validatePassword,
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
                    // controller: _auth.password,
                    validator: signupState.validatePassword,
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
                SizedBox(
                  height: size.height * 0.025,
                ),
                AppButton(
                  isIcon: true,
                  text: 'Register',
                  onPressed: () async {
                    navigate(context, const SignInPage());
                  },
                ),
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
      ],
    ));
  }
}
