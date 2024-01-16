// ignore_for_file: public_member_api_docs, sort_constructors_first
/// This class defines the BottomBar
/// @author  Yusuf umar
/// @version 1.0
/// @since   2023-07-19
///

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/features/auth/controller/user/user_data_notifier.dart';
import 'package:jenos/scr/features/bottom_bar/controller/bottom_bar_controller.dart';

class BottomBar extends ConsumerStatefulWidget {
  static const String routeName = '/navbar';

  @override
  ConsumerState<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends ConsumerState<BottomBar> {
  @override
  void initState() {
    getData();
    // initOneSIgnal();
    super.initState();
  }

  void getData() async {
    if (mounted) {
      await ref.read(userDataNotifier.notifier).getUserData();

   
    }
  }



  List<Widget> pages = [
    Container(),
    Container(),
     Container(),
     Container(),
  ];

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: () async {
          // DateTime now = DateTime.now();

          // if (provider.currentIndex != 0) {
          //   provider.setNavbarIndex(0);

          //   return false;
          // } else {
          //   return false;
          // }

          return false;
        },
        child:
            // debugPrint("val.isErrorToken:${val.isErrorToken}");
            Scaffold(
          body: pages[ref.watch(navBarController).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: ref.watch(navBarController).currentIndex,
            selectedItemColor: AppColors.primaryColor,
            // selectedItemColor: primaryColor,
            unselectedItemColor: Colors.black54,
            backgroundColor: Colors.white,
            showUnselectedLabels: true,
            selectedFontSize: 10.0,
            unselectedFontSize: 10.0,
            elevation: 5,
            onTap: (index) {
              ref.read(navBarController.notifier).setNavbarIndex(index);
              // provider.setNavbarIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                  size: 26,
                ),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.forum_outlined,
                  size: 26,
                ),
                label: 'Forum',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.timer_rounded,
                  size: 26,
                ),
                label: 'Notification',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 26,
                ),
                label: 'Profile',
              ),
            ],
          ),
        ));
  }

  //
}
