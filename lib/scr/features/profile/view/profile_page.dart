import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/common_widgets/appbbutton.dart';
import 'package:jenos/scr/common_widgets/custom_widget.dart';
import 'package:jenos/scr/common_widgets/navigation.dart';
import 'package:jenos/scr/constant/app_assets.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/constant/app_size.dart';
import 'package:jenos/scr/features/auth/pages/signin_page.dart';
import 'package:jenos/scr/features/onboarding/controller/onboard_controller.dart';
import 'package:jenos/scr/features/profile/controller/personal_info/personal_info_notifier.dart';
import 'package:jenos/scr/features/profile/view/account_details.dart';
import 'package:jenos/scr/features/profile/view/change_password.dart';
import 'package:jenos/scr/features/profile/view/update_personal_details_page.dart';
import 'package:jenos/scr/features/profile/view/verification_page.dart';
import 'package:jenos/scr/features/trip/controller/trips_controller.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  bool enableNotification = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomWidget.customAppbar(context, title: "Profile", isArrow: true),
      body: ListView(
        padding: const EdgeInsets.all(AppSize.defaultPadding),
        children: [
          Consumer(builder: (context, ref, _) {
            // final profile = ref.watch(userDataNotifier);
            final personalNotifier = ref.watch(personalInfoNotifier);

            return CustomWidget.profileHeaderCard(
              profileImg: ClipOval(
                child: SizedBox.fromSize(
                    size: const Size.fromRadius(25),
                    child: personalNotifier.imagePath != null
                        ? Image.network(
                            personalNotifier.imagePath!,
                            fit: BoxFit.cover,
                          )
                        : Image.asset("assets/images/profileImg.jpg")),
              ),
              context,
              name: personalNotifier.nameController.text,
              userName: "MrK",
              phone: personalNotifier.phoneController.text,
              logisticsName: personalNotifier.nameController.text,
            );
          }),
          const SizedBox(
            height: AppSize.defaultPadding,
          ),

          Consumer(builder: (context, ref, _) {
            final accountType = ref.watch(onboardController).accountType;
            return Container(
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
                      ref.read(personalInfoNotifier.notifier).getUserData();
                      ref.read(personalInfoNotifier.notifier).resetState();

                      navigate(context, const UpdatePersonalDetailPage());
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSize.defaultPadding),
                    child: Divider(
                      color: AppColors.grey,
                    ),
                  ),
                  CustomWidget.profileTile(
                    context,
                    img: Assets.userIcon,
                    title: "KYC/ Verification",
                    desc: "Confirm your identity",
                    onTap: () {
                      navigate(context, const VerificationPage());
                    },
                  ),
                ],
              ),
            );
          }),
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
                  onTap: () {
                    navigate(context, const AccountDetails());
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
                  img: Assets.lockClosed,
                  title: "Security",
                  desc: "Secure your account",
                  onTap: () {
                    navigate(context, const ChangePassword());
                  },
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
                  onTap: () {
                    showModalBottomSheet<void>(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50)),
                      ),
                      builder: (BuildContext context) {
                        return modalPopUp(
                          context,
                          title: "Log-out",
                          desc:
                              "Want to take a break from\nJenosWay Logistics?",
                          onTap: () async {
                            ref.read(tripController.notifier).clearData();
                            ref
                                .read(personalInfoNotifier.notifier)
                                .logOut(context);
                          },
                        );
                      },
                    );
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
                  img: Assets.logout,
                  iconColor: Colors.red,
                  title: "Delete account",
                  desc: "Delete and exit",
                  onTap: () {
                    showModalBottomSheet<void>(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50)),
                      ),
                      builder: (BuildContext context) {
                        return modalPopUp(
                          context,
                          title: "Delete acoount",
                          desc:
                              "Note: Deleting your account will wipe out all\nyour details in the system. It is an reversible\naction!",
                          onTap: () async {
                            navigate(context, const SignInPage());
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          )
          //
        ],
      ),
    );
  }

  modalPopUp(context, {String title = "", String desc = "", onTap}) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(20).copyWith(top: 40),
            height: 380,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: AppSize.defaultPadding * 3,
                    ),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      desc,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.grey, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 50),
                    AppButton(
                        height: 55,
                        isIcon: true,
                        text: title,
                        onPressed: onTap,
                        color: AppColors.primaryColor,
                        textColor: Colors.white),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 10,
            top: 5,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.cancel,
                color: AppColors.primaryColor,
              ),
            ),
          )
        ],
      );
    });
  }
}
