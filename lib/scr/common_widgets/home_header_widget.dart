import 'package:flutter/material.dart';
import 'package:jenos/scr/common_widgets/navigation.dart';
import 'package:jenos/scr/constant/app_assets.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/common_widgets/custom_widget.dart';
import 'package:jenos/scr/features/notification/view/notification_page.dart';
import 'package:jenos/scr/features/profile/view/profile_page.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({
    super.key,
  });

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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "B2B Logistics",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.dark,
                      fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      "Online",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.dark,
                            fontSize: 12,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 15,
                      width: 15,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
