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
import 'package:jenos/scr/features/auth/controller/user/user_data_notifier.dart';
import 'package:jenos/scr/features/bottom_bar/controller/bottom_bar_controller.dart';
import 'package:jenos/scr/features/home/view/home_page.dart';
import 'package:jenos/scr/features/request/view/request_page.dart';
import 'package:jenos/scr/features/trip/controller/onboard_controller.dart';
import 'package:jenos/scr/features/trip/view/trip_page.dart';
import 'package:jenos/scr/features/wallet/view/wallat_page.dart';

class BottomBar extends ConsumerStatefulWidget {
  static const String routeName = '/navbar';

  @override
  ConsumerState<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends ConsumerState<BottomBar> {
  @override
  void initState() {
    getData();
      ref.read(tripController.notifier).getCurrentLocation();
    super.initState();
  }

  void getData() async {
    if (mounted) {
      await ref.read(userDataNotifier.notifier).getUserData();
    }
  }

  List<Widget> pages = [
    const HomePage(),
    const RequestPage(),
    const TripsPage(),
    const WalletPage(),
  ];

  List iconList = [
    {
      "id": 0,
      "name": "Home",
      "icon": Assets.home,
    },
    {
      "id": 1,
      "name": "Request",
      "icon": Assets.requests,
    },
    {
      "id": 2,
      "name": "Trips",
      "icon": Assets.trips,
    },
    {
      "id": 3,
      "name": "Wallet",
      "icon": Assets.wallet,
    },
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
