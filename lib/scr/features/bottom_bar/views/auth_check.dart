
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/features/auth/pages/signin_page.dart';
import 'package:jenos/scr/features/bottom_bar/controller/bottom_bar_controller.dart';
import 'package:jenos/scr/features/bottom_bar/views/bottom_bar.dart';



class AuthCheckScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: StreamBuilder<bool>(
        stream: ref.read(navBarController.notifier).validateToken()
            .asStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return  Center(
              child: CircularProgressIndicator( color: AppColors.primaryColor,),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final bool isTokenValid = snapshot.data ?? false;

            if (isTokenValid) {
              return  BottomBar();
            } else {
              return const SignInPage();
            }
          }
        },
      ),
    );
  }
}


/*
    Future.delayed(const Duration(milliseconds: 500), () {
            showTopSnackBar(
              Overlay.of(context),
              const CustomSnackBar.error(
                message: "Login Expires",
              ),
            );
          });
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/login', (Route<dynamic> route) => false);
          });
*/