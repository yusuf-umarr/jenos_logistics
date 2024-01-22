import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jenos/scr/common_widgets/custom_widget.dart';
import 'package:jenos/scr/constant/app_assets.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/constant/app_size.dart';

class NotificationDetail extends StatelessWidget {
  const NotificationDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidget.customAppbar(context, title: "Notification"),
      body: ListView(
        padding: const EdgeInsets.all(AppSize.defaultPadding),
        children: [
          Container(
            padding: const EdgeInsets.all(AppSize.defaultPadding),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(Assets.clock),
                        const SizedBox(
                          width: AppSize.defaultPadding / 2,
                        ),
                        Text(
                          "Reminder",
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(
                          width: AppSize.defaultPadding / 3,
                        ),
                        Text(
                          "21 min. ago",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: AppColors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.cancel,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                //
                const SizedBox(
                  height: AppSize.defaultPadding,
                ),

                Text(
                  "Dear Kayode,\n\nWe hope this message finds you in good spirits. We are pleased to inform you that you have been assigned a delivery task with Jenos Way Logistics. Please find the details of your assignment in your requests section. Thank you for your commitment and hard work. We appreciate your experience and loyalty.\n\nBest regards,\n\nJenos Way Logistics Inc.",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
