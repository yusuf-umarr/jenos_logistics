import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/features/bottom_bar/controller/bottom_bar_controller.dart';
import 'package:jenos/scr/features/bottom_bar/views/bottom_bar.dart';
import 'package:jenos/scr/features/onboarding/screens/get_started_screen.dart';

class AuthCheckScreen extends ConsumerStatefulWidget {
  final accountType;
  const AuthCheckScreen({this.accountType});
  @override
  ConsumerState<AuthCheckScreen> createState() => _AuthCheckScreenState();
}

class _AuthCheckScreenState extends ConsumerState<AuthCheckScreen> {
  @override

  @override
  Widget build(
    BuildContext context,
  ) {

    return Scaffold(
      body: StreamBuilder<bool>(
        stream: ref.read(navBarController.notifier).validateToken().asStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child:
                  // Text("loading....")
                  CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final bool isTokenValid = snapshot.data ?? false;

            // log("isTokenValid:$isTokenValid");

            if (isTokenValid) {
              return BottomBar(accountType: widget.accountType);
            } else {
              return const GetStartedScreen();
            }
          }
        },
      ),
    );
  }
}
