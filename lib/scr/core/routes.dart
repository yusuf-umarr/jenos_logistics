import 'package:flutter/cupertino.dart';
import 'package:jenos/scr/features/auth/pages/signin_page.dart';
import 'package:jenos/scr/features/auth/pages/signup_page.dart';
import 'package:jenos/scr/features/onboarding/screens/splash_screen.dart';

abstract class AppRoutes {
  static const String requestDetails = '/requestDetails';
  static const String login = '/login';
  static const String spalshScreen = '/spalshScreen';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgotpassword';
  static const String createPassword = '/createPassword';
  static const String verifyEmail = '/verifyEmail';
  static const String startMenstrualTracker = '/startMenstrualTracker';
  static const String menstrualQuestionnaire = '/menstrualQuestionnaire';
  static const String bottomNav = '/bottomNav';
  static const String sleepQuestionnaire = '/sleepQuestionnaire';
  static const String videoCallScreen = '/videoScreen';
  static const String sessionTabScreen = '/sessionTabScreen';
}



Route<dynamic> ongenerateRoute(RouteSettings settings) {
  Widget? page;
  CupertinoPageRoute? pageRoute;
  switch (settings.name) {
    case AppRoutes.spalshScreen:
      pageRoute =
          CupertinoPageRoute(builder: (context) => const SplashScreen());
      break;

    case AppRoutes.login:
      page = const SignInPage();
      break;

    // case AppRoutes.bottomNav:
    //   page = const Bott();
    //   break;

    case AppRoutes.signup:
      page = const SignupPage();
      break;

    // case AppRoutes.forgotPassword:
    //   page = const ForgotPasswordScreen();
    //   break;
    // case AppRoutes.verifyEmail:
    //   page = const VerifyEmailScreen();
    //   break;


  
  }
  return page != null
      ? CupertinoPageRoute(builder: (context) => page!)
      : pageRoute!;
}
