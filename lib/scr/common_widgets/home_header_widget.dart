import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/common_widgets/navigation.dart';
import 'package:jenos/scr/constant/app_assets.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/common_widgets/custom_widget.dart';
import 'package:jenos/scr/core/enums.dart';
import 'package:jenos/scr/features/notification/view/notification_page.dart';
import 'package:jenos/scr/features/onboarding/controller/onboard_controller.dart';
import 'package:jenos/scr/features/profile/view/profile_page.dart';

class HomeHeaderWidget extends StatefulWidget {
  const HomeHeaderWidget({
    super.key,
  });

  @override
  State<HomeHeaderWidget> createState() => _HomeHeaderWidgetState();
}

class _HomeHeaderWidgetState extends State<HomeHeaderWidget> {
  bool isOnline = true;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CustomWidget.imagAvatar(isBorder: true),
            const SizedBox(
              width: 20,
            ),
            Consumer(builder: (context, ref, _) {
              final accountType = ref.watch(onboardController).accountType;

              if (accountType == AccountType.individual) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "B2B Logistics",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.dark,
                          fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
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
                          textAlign: TextAlign.center,
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
                              setState(() {
                                isOnline = val;
                              });
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
                  Text(
                    "Kayode Ola",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.dark,
                        fontSize: 14),
                    textAlign: TextAlign.center,
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
            CustomWidget.headerCard(Assets.bell, onTap: () {
              navigate(context, const NotificationPage());
            }),
            const SizedBox(width: 10),
            CustomWidget.headerCard(Assets.user, onTap: () {
              navigate(context, const ProfilePage());
            }),
          ],
        ),
      ],
    );
  }
}
