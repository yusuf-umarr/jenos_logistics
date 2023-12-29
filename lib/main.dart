import 'package:flutter/material.dart';
import 'package:jenos/scr/core/theme.dart';
import 'package:jenos/scr/features/onboarding/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jenos',
      debugShowCheckedModeBanner:false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}

