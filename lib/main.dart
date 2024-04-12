import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/core/helper/notification_service.dart';
import 'package:jenos/scr/core/routes/routes.dart';
import 'package:jenos/scr/core/theme/theme.dart';
import 'package:jenos/scr/features/bottom_bar/views/auth_check.dart';
import 'package:jenos/scr/features/onboarding/controller/onboard_controller.dart';
import 'package:jenos/scr/features/onboarding/screens/onboarding_main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jenos/firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  log('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService.initializeNotification();

  String? fcmToken = await FirebaseMessaging.instance.getToken();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String usedApp = prefs.getString("usedApp") ?? "";
  await prefs.setString("fcmToken", fcmToken!);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    ProviderScope(
      child: MyApp(usedApp: usedApp),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  final String? usedApp;
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  const MyApp({super.key, this.usedApp});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  var accountType;

  @override
  void initState() {
    initFCM();
    ref.read(onboardController.notifier).getAccountType();
    accountType = ref.read(onboardController).accountType;

    super.initState();
  }

  void initFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) async {
      log("message done success======");
      log("event.notification!.body 111:${event.notification!.body}");

      // Future.delayed(Duration(seconds: 1), () async {
      await NotificationService.showNotification(
          title: event.notification!.title!,
          body: event.notification!.body!,
          payload: {
            "navigate": "true",
          },
          actionButtons: [
            NotificationActionButton(
              key: 'check',
              label: 'Preview',
              actionType: ActionType.Default,
              color: Colors.green,
            )
          ]);
      // });
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      log('Message clicked!  now===========');
    });
  }

//
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: MyApp.navigatorKey,
      title: 'Jenos rider',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      onGenerateRoute: (settings) => ongenerateRoute(settings),
      home: (widget.usedApp != "")
          ? AuthCheckScreen(
              accountType: accountType,
            )
          : const OnboardingMainScreen(),
      // home: SignInPage(),
    );
  }
}
