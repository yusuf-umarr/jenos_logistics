// ignore_for_file: public_member_api_docs, sort_constructors_first
/// This class defines the BottomBar
/// @author  Yusuf umar
/// @version 1.0
/// @since   2023-12-19
///

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jenos/scr/constant/app_assets.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/core/util/enums.dart';
import 'package:jenos/scr/features/bottom_bar/controller/bottom_bar_controller.dart';
import 'package:jenos/scr/features/home/controller/home_controller.dart';
import 'package:jenos/scr/features/home/view/home_page.dart';
import 'package:jenos/scr/features/notification/view/notification_page.dart';
import 'package:jenos/scr/features/onboarding/controller/onboard_controller.dart';
import 'package:jenos/scr/features/profile/controller/user_profile/pprofile_controller.dart';
import 'package:jenos/scr/features/profile/view/profile_page.dart';
import 'package:jenos/scr/features/request/controller/request_notifier.dart';
import 'package:jenos/scr/features/request/view/request_page.dart';
import 'package:jenos/scr/features/trip/controller/trips_controller.dart';
import 'package:jenos/scr/features/trip/view/trip_page.dart';
import 'package:jenos/scr/features/wallet/view/wallat_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomBar extends ConsumerStatefulWidget {
  const BottomBar({super.key, this.accountType});

  final accountType;

  static const String routeName = '/bottom-bar';
  @override
  ConsumerState<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends ConsumerState<BottomBar> {
  @override
  void initState() {
    getData();
    setPages();
    super.initState();
  }

  //   getAccountType() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   accountType = prefs.getString('accountType') ?? "individual";
  // }

  List<Widget> pages = [];
  List iconList = [];

  void getData() async {
    if (mounted) {
      await ref.read(onboardController.notifier).getAccountType();
      ref.read(homeController.notifier).getShowPop();
      await ref.read(profileController.notifier).getUserData();
      ref.read(requestNotifier.notifier).getRiderRequest();
      ref.read(tripController.notifier).getTrips();
      ref.read(tripController.notifier).getRiderAnalysis();
    }
  }

  void setPages() async {
    final accountType = ref.read(onboardController).accountType;

    pages = [
      const HomePage(),
      accountType == AccountType.individual
          ? const RequestPage()
          : const NotificationPage(isArrowBack: false),
      // const RequestPage(),
      TripsPage(accountType: accountType),
      accountType == AccountType.individual
          ? const WalletPage()
          : const ProfilePage(),
    ];

    iconList = [
      {
        "id": 0,
        "name": "Home",
        "icon": Assets.home,
      },
      {
        "id": 1,
        "name":
            accountType == AccountType.individual ? "Request" : "Notification",
        "icon": accountType == AccountType.individual
            ? Assets.requests
            : Assets.bell,
      },
      // {
      //   "id": 1,
      //   "name": "Request",
      //   "icon": Assets.requests,
      // },
      {
        "id": 2,
        "name": "Trips",
        "icon": Assets.trips,
      },
      {
        "id": 3,
        "name": accountType == AccountType.individual ? "Wallet" : "Profile",
        "icon":
            accountType == AccountType.individual ? Assets.wallet : Assets.user,
      },
    ];
  }

  // List<Widget> pages = [
  //   const HomePage(),
  //   const RequestPage(),
  //   const TripsPage(),
  //   const WalletPage(),
  // ];

  // List iconList = [
  //   {
  //     "id": 0,
  //     "name": "Home",
  //     "icon": Assets.home,
  //   },
  //   {
  //     "id": 1,
  //     "name": "Request",
  //     "icon": Assets.requests,
  //   },
  //   {
  //     "id": 2,
  //     "name": "Trips",
  //     "icon": Assets.trips,
  //   },
  //   {
  //     "id": 3,
  //     "name": "Wallet",
  //     "icon": Assets.wallet,
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          ref.read(navBarController.notifier).setNavbarIndex(0);

          return false;
        },
        child: Scaffold(
          body: pages[ref.watch(navBarController).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: ref.watch(navBarController).currentIndex,
              selectedItemColor: AppColors.primaryColor,
              unselectedItemColor: Colors.black54,
              backgroundColor: Colors.white,
              showUnselectedLabels: true,
              selectedFontSize: 10.0,
              unselectedFontSize: 10.0,
              elevation: 5,
              onTap: (index) {
                ref.read(navBarController.notifier).setNavbarIndex(index);
              },
              items: iconList.map<BottomNavigationBarItem>((e) {
                return BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    e['icon'],
                    colorFilter: ColorFilter.mode(
                      ref.watch(navBarController).currentIndex == e["id"]
                          ? AppColors.primaryColor
                          : Colors.black54,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: e['name'],
                );
              }).toList()),
        ));
  }

  //
}
