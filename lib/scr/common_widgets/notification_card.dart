import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jenos/scr/common_widgets/custom_widget.dart';
import 'package:jenos/scr/constant/app_assets.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/constant/app_size.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: AppSize.defaultPadding / 3),
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: const BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: AppSize.defaultPadding / 2,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(Assets.clock),
                    const SizedBox(
                      width: AppSize.defaultPadding / 2,
                    ),
                    Text(
                      "Reminder",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(
                      width: AppSize.defaultPadding,
                    ),
                    Text(
                      "21 min. ago",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: AppColors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppSize.defaultPadding,
                ),
                SizedBox(
                  width: size.width * 0.8,
                  child: Text(
                    "We're delighted to inform you that you that you have received a delivery request.",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.defaultPadding,
                ),
                CustomWidget.commonBtn(
                    horizontalPadding: 15,
                    title: "View details",
                    bgColor: AppColors.primaryColor,
                    textColor: AppColors.white,
                    onTap: () {}),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: AppSize.defaultPadding,
        ),
        const Divider(
          color: AppColors.grey,
        )
      ],
    );
  }
}
