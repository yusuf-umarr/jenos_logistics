import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jenos/scr/common_widgets/custom_widget.dart';
import 'package:jenos/scr/common_widgets/navigation.dart';
import 'package:jenos/scr/constant/app_assets.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/constant/app_size.dart';
import 'package:jenos/scr/features/profile/view/personal_details_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool enableNotification = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomWidget.customAppbar(context, title: "Profile", isArrow: true),
      body: ListView(
        padding: const EdgeInsets.all(AppSize.defaultPadding),
        children: [
          CustomWidget.profileHeaderCard(
            context,
            name: "Kayode ade",
            userName: "MrK",
            phone: "09043568909",
            logisticsName: "GIGM Logistics",
          ),
          const SizedBox(
            height: AppSize.defaultPadding,
          ),

          Container(
            margin: const EdgeInsets.only(bottom: AppSize.defaultPadding),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.white),
            child: Column(
              children: [
                CustomWidget.profileTile(
                  context,
                  img: Assets.userIcon,
                  title: "Edit profile information",
                  desc: "Update your profile",
                  onTap: () {
                    navigate(context, const PersonalDetailPage());
                  },
                ),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppSize.defaultPadding),
                  child: Divider(
                    color: AppColors.grey,
                  ),
                ),
                CustomWidget.profileTile(
                  context,
                  img: Assets.userIcon,
                  title: "KYC/ Verification",
                  desc: "Confirm your identity",
                  onTap: () {},
                ),
              ],
            ),
          ),
          //
          Container(
            margin: const EdgeInsets.only(bottom: AppSize.defaultPadding),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.white),
            child: Column(
              children: [
                CustomWidget.profileTile(
                  context,
                  img: Assets.cash,
                  title: "Account details",
                  desc: "Update your bank details",
                  onTap: () {},
                ),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppSize.defaultPadding),
                  child: Divider(
                    color: AppColors.grey,
                  ),
                ),
                CustomWidget.profileTile(
                  context,
                  img: Assets.lockClosed,
                  title: "Security",
                  desc: "Secure your account",
                  onTap: () {},
                ),
              ],
            ),
          ),
          //
          Container(
            margin: const EdgeInsets.only(bottom: AppSize.defaultPadding),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.white),
            child: Column(
              children: [
                CustomWidget.profileTile(
                  context,
                  img: Assets.share,
                  title: "Referral",
                  desc: "Invite your friends",
                  onTap: () {},
                ),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppSize.defaultPadding),
                  child: Divider(
                    color: AppColors.grey,
                  ),
                ),
                CustomWidget.profileTile(
                  context,
                  img: Assets.bell,
                  title: "Enable notification",
                  desc: "Stay in the loop",
                  onTap: () {},
                  icon: Transform.scale(
                    scale: 0.7,
                    child: CupertinoSwitch(
                      value: enableNotification,
                      activeColor: AppColors.primaryColor,
                      onChanged: (val) {
                        setState(() {
                          enableNotification = val;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          //
          Container(
            margin: const EdgeInsets.only(bottom: AppSize.defaultPadding),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.white),
            child: Column(
              children: [
                CustomWidget.profileTile(
                  context,
                  img: Assets.logout,
                  title: "Log-out",
                  desc: "Take a break",
                  onTap: () {},
                ),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppSize.defaultPadding),
                  child: Divider(
                    color: AppColors.grey,
                  ),
                ),
                CustomWidget.profileTile(
                  context,
                  img: Assets.logout,
                  iconColor: Colors.red,
                  title: "Delete account",
                  desc: "Delete and exit",
                  onTap: () {},
                ),
              ],
            ),
          )
          //
        ],
      ),
    );
  }
}
