import 'package:flutter/cupertino.dart';
import 'package:jenos/scr/features/auth/pages/signin_page.dart';
import 'package:jenos/scr/features/auth/pages/signup_page.dart';
import 'package:jenos/scr/features/bottom_bar/views/bottom_bar.dart';
import 'package:jenos/scr/features/notification/view/notification_page.dart';
import 'package:jenos/scr/features/onboarding/screens/get_started_screen.dart';
import 'package:jenos/scr/features/onboarding/screens/splash_screen.dart';

abstract class AppRoutes {
  static const String login = '/login';
  static const String spalshScreen = '/spalshScreen';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgotpassword';
  static const String bottomNav = '/bottom-bar';
  static const String getStarted = '/get-started';
  static const String notification = '/notification';
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
    case AppRoutes.notification:
      page = const NotificationPage(isArrowBack:true);
      break;
    case AppRoutes.bottomNav:
      page = BottomBar();
      break;
    case AppRoutes.getStarted:
      page = const GetStartedScreen();
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
