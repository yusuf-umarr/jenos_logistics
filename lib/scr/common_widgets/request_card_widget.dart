import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jenos/scr/common_widgets/custom_widget.dart';
import 'package:jenos/scr/common_widgets/navigation.dart';
import 'package:jenos/scr/constant/app_assets.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/constant/app_size.dart';
import 'package:jenos/scr/features/request/view/order_detail.dart';
import 'package:jenos/scr/features/request/view/status_update.dart';

class RequestOrderCardWIdget extends StatelessWidget {
  const RequestOrderCardWIdget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSize.defaultPadding),
      padding: const EdgeInsets.all(AppSize.defaultPadding).copyWith(
        bottom: AppSize.defaultPadding,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(
          AppSize.defaultPadding,
        ),
      ),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CustomWidget.imagAvatar(
                  isBorder: false,
                  image: "assets/images/pizza.png",
                ),
                const SizedBox(
                  width: AppSize.defaultPadding / 2,
                ),
                Text(
                  "Pizza-Hut",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Text(
              "Today, 12:15pm",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w600, color: AppColors.greyColor),
            ),
          ],
        ),
        const SizedBox(
          height: AppSize.defaultPadding,
        ),
        requestRowTextWidget(
          context,
        ),
        requestRowTextWidget(
          context,
          title: "Pickup Date:",
          desc: "Oct. 26, 2023",
          icon: Assets.calendar,
        ),
        requestRowTextWidget(
          context,
          title: "Pickup Time:",
          desc: "02:00 pm",
          icon: Assets.clock,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            requestCardBtn(onTap: () {
              navigate(context, const OrderDetailsPage());
            }),
            const SizedBox(
              width: AppSize.defaultPadding,
            ),
            requestCardBtn(
                title: "Status",
                bgColor: AppColors.white,
                textColor: AppColors.primaryColor,
                onTap: () {
                  navigate(context, const StatusUpdatePage());
                }),
          ],
        )
      ]),
    );
  }

  Widget requestCardBtn({
    String title = "View Detail",
    Color textColor = AppColors.white,
    Color bgColor = AppColors.primaryColor,
    Function()? onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          width: 133,
          decoration: BoxDecoration(
              color: bgColor,
              border: Border.all(color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(15)),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }

  requestRowTextWidget(
    BuildContext context, {
    String icon = Assets.userIcon,
    String title = "Requester's name:",
    String desc = "Nweke Jonathan",
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                icon,
                height: 15,
                colorFilter: const ColorFilter.mode(
                  AppColors.greyText,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w500, color: AppColors.greyText),
              ),
            ],
          ),
          Text(
            desc,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}
