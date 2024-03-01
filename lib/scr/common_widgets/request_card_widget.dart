import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jenos/scr/common_widgets/custom_widget.dart';
import 'package:jenos/scr/common_widgets/navigation.dart';
import 'package:jenos/scr/constant/app_assets.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/constant/app_size.dart';
import 'package:jenos/scr/core/util/util.dart';
import 'package:jenos/scr/features/request/view/order_detail.dart';
import 'package:jenos/scr/features/request/view/status_update.dart';

class RequestOrderCardWIdget extends StatelessWidget {
  final request;
  const RequestOrderCardWIdget({super.key, this.request});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
                ClipOval(
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(25),
                    child: request['itemImage'] != null
                        ? Image.network(
                            request['itemImage']!,
                            fit: BoxFit.cover,
                          )
                        : Image.asset("assets/images/pixelBg.jpeg"),
                  ),
                ),
                const SizedBox(
                  width: AppSize.defaultPadding / 2,
                ),
                SizedBox(
                  width: size.width * 0.3,
                  child: Text(
                    "Pizza-Hut",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Text(
              Util.showFormattedDateString(request['createdAt'], context),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w600, color: AppColors.greyColor),
            ),
          ],
        ),
        const SizedBox(
          height: AppSize.defaultPadding,
        ),
        requestRowTextWidget(context, desc: request['senderName']),
        requestRowTextWidget(
          context,
          title: "Pickup Date:",
          desc: Util.showFormattedDateString(request['pickUpDate'], context),
          icon: Assets.calendar,
        ),
        requestRowTextWidget(
          context,
          title: "Pickup Time:",
          desc: Util.showFormattedTimeVal(request['pickUpDate'], context),
          icon: Assets.clock,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            requestCardBtn(onTap: () {
              navigate(context, OrderDetailsPage(request: request));
            }),
            const SizedBox(
              width: AppSize.defaultPadding,
            ),
            requestCardBtn(
                title: "Update Status", //request['status'],
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
              borderRadius: BorderRadius.circular(10)),
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
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Text(
              desc,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
