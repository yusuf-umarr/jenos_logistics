import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/common_widgets/navigation.dart';
import 'package:jenos/scr/constant/app_assets.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/common_widgets/custom_widget.dart';
import 'package:jenos/scr/core/util/enums.dart';
import 'package:jenos/scr/features/bottom_bar/controller/bottom_bar_controller.dart';
import 'package:jenos/scr/features/notification/view/notification_page.dart';
import 'package:jenos/scr/features/onboarding/controller/onboard_controller.dart';
import 'package:jenos/scr/features/profile/controller/user_profile/pprofile_controller.dart';
import 'package:jenos/scr/features/profile/view/profile_page.dart';
import 'package:jenos/scr/features/trip/controller/trips_controller.dart';

class HomeHeaderWidget extends ConsumerStatefulWidget {
  const HomeHeaderWidget({
    super.key,
  });

  @override
  ConsumerState<HomeHeaderWidget> createState() => _HomeHeaderWidgetState();
}

class _HomeHeaderWidgetState extends ConsumerState<HomeHeaderWidget> {
  bool isOnline = true;
  @override
  Widget build(BuildContext context) {
    final personalNotifier = ref.watch(profileController);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipOval(
              child: SizedBox.fromSize(
                  size: const Size.fromRadius(25),
                  child: personalNotifier.imagePath != null
                      ? Image.network(
                          personalNotifier.imagePath!,
                          fit: BoxFit.cover,
                        )
                      : Image.asset("assets/images/profileImg.jpg")),
            ),
            const SizedBox(
              width: 10,
            ),
            Consumer(builder: (context, ref, _) {
              final accountType = ref.watch(onboardController).accountType;
              final personalNotifier = ref.watch(profileController);
              final Size size = MediaQuery.of(context).size;

              if (accountType == AccountType.individual) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width * 0.35,
                      child: Text(
                        personalNotifier.nameController.text,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.dark,
                            fontSize: 14),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Online",
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.dark,
                                    fontSize: 12,
                                  ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Transform.scale(
                          scale: 0.4,
                          child: CupertinoSwitch(
                            value: isOnline,
                            activeColor: AppColors.green,
                            onChanged: (val) {
                              if (isOnline) {
                                //off
                                log("isOnline to Offff");
                                ref
                                    .read(tripController.notifier)
                                    .updateRiderAvailability("off", context);
                              } else {
                                //on
                                // log("isOnline to oNN");
                                ref
                                    .read(tripController.notifier)
                                    .updateRiderAvailability("on", context);
                              }
                              setState(() {
                                isOnline = val;
                              });

                              // log("isOnline:$isOnline");
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width * 0.35,
                    child: Text(
                      personalNotifier.nameController.text,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.dark,
                          fontSize: 14),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              );
            }),
          ],
        ),
        Row(
          children: [
            Row(
              children: [
                CustomWidget.headerCard(Assets.bell, onTap: () {
                  navigate(
                      context,
                      const NotificationPage(
                        isArrowBack: true,
                      ));
                }),
                const SizedBox(width: 10),
              ],
            ),
            Consumer(builder: (context, ref, _) {
              final accountType = ref.watch(onboardController).accountType;

              if (accountType == AccountType.individual) {
                return CustomWidget.headerCard(Assets.user, onTap: () {
                  navigate(context, const ProfilePage());
                });
              }

              return CustomWidget.headerCard(Assets.tripIcon, onTap: () {
                ref.read(navBarController.notifier).setNavbarIndex(2);

                // navigate(context, const RequestPage());
              });
            }),
          ],
        ),
      ],
    );
  }
}
