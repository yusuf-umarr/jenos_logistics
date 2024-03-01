import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/core/routes/routes.dart';
import 'package:jenos/scr/core/theme/theme.dart';
import 'package:jenos/scr/features/bottom_bar/views/auth_check.dart';
import 'package:jenos/scr/features/onboarding/controller/onboard_controller.dart';
import 'package:jenos/scr/features/onboarding/screens/onboarding_main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String usedApp = prefs.getString("usedApp") ?? "";

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    ProviderScope(
      child: MyApp(
        usedApp: usedApp,
      ),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  final String? usedApp;
  const MyApp({super.key, this.usedApp});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  var accountType;

  @override
  void initState() {
    ref.read(onboardController.notifier).getAccountType();
    accountType = ref.read(onboardController).accountType;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  var accountType =  ref.watch(onboardController).accountType;

    return MaterialApp(
      title: 'Jenos merchant & customer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      onGenerateRoute: (settings) => ongenerateRoute(settings),
      home: (widget.usedApp != "")
          ? AuthCheckScreen(accountType: accountType)
          : const OnboardingMainScreen(),
      // home: SignInPage(),
    );
  }
}
