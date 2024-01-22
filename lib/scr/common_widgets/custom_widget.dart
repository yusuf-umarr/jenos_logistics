import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jenos/scr/constant/app_assets.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/constant/app_size.dart';

class CustomWidget {
  static AppBar customAppbar(
    BuildContext context, {
    String title = "",
    bool isArrow = false,
  }) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isArrow
              ? InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: SvgPicture.asset(Assets.arrowBack))
              : const SizedBox(
                  width: 40,
                ),
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: 20)),
          const SizedBox(
            width: 40,
          )
        ],
      ),
      centerTitle: true,
      backgroundColor: AppColors.scaffoldBackground,
      elevation: 0,
    );
  }

  static Widget headerCard(String img, {onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.greyColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset(img),
        ),
      ),
    );
  }

  static Container imagAvatar({
    String image = "assets/images/profileImage.png",
    bool isBorder = false,
    double size = 50,
  }) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isBorder ? Colors.yellow : Colors.transparent,
        ),
      ),
      child: Image.asset(
        image,
      ),
    );
  }

  static homeTripCard(
    BuildContext context,
    String name,
    String desc,
    String icon,
    String price,
    Color color,
    Color iconColor,
  ) {
    return Container(
      height: 159,
      width: 145,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 30),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.dark,
                    ),
              ),
              Text(
                price,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.dark,
                    fontSize: 25),
              ),
              Text(
                desc,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.dark,
                      fontSize: 14,
                    ),
              ),
            ],
          ),
          Positioned(
            bottom: 15,
            right: 3,
            child: Container(
              height: 25,
              width: 25,
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
              ),
              child: SvgPicture.asset(
                icon,
                height: 15,
                colorFilter: ColorFilter.mode(
                  iconColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
//

  static homePopCard(BuildContext context, size, onTap) {
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.05,
        ),
        Stack(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 25,
              ),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Optimize Your Logistics Experience",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.dark,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Complete Your Profile Settings to\nSeamlessly Place and Receive\nOrders.",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "Complete Setting Now",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.white, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              right: 0,
              child: IconButton(
                  onPressed: onTap,
                  icon: const Icon(
                    Icons.cancel_outlined,
                    color: AppColors.primaryColor,
                  )),
            )
          ],
        ),
      ],
    );
  }
//

  static Stack carouselSliderWidget(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: const DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                "assets/images/homeImg.png",
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 155,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black26,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 20,
          child: Text(
            "Festive Discount",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold, color: AppColors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  static Container recentTripCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CustomWidget.imagAvatar(
                isBorder: false,
                image: "assets/images/pizza.png",
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pizza-Hut",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.dark,
                          fontSize: 12,
                        ),
                  ),
                  Text(
                    "Today,7:10pm",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColors.greyColor,
                          fontSize: 10,
                        ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Completed",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.dark,
                      fontSize: 12,
                    ),
              ),
              Text(
                "15.12.2023",
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.greyColor,
                      fontSize: 10,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Column detailCard(
    BuildContext context, {
    String title = "",
    String desc = "",
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          desc,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.w500, color: AppColors.grey),
        ),
      ],
    );
  }

  static Container particularCard(
    BuildContext context, {
    String headerText = "",
    String name = "",
    String email = "",
    String phone = "",
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSize.defaultPadding),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSize.defaultPadding)
                .copyWith(bottom: 0),
            child: Text(
              headerText,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const Divider(),
          const SizedBox(
            height: AppSize.defaultPadding,
          ),
          Padding(
            padding:
                const EdgeInsets.all(AppSize.defaultPadding).copyWith(top: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CustomWidget.detailCard(context,
                          title: "Full name", desc: name),
                    ),
                    Expanded(
                      child: CustomWidget.detailCard(context,
                          title: "Phone number", desc: phone),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppSize.defaultPadding,
                ),
                CustomWidget.detailCard(context, title: "Email", desc: email),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Container paymentMethodCard(
    BuildContext context, {
    String headerText = "",
    String amount = "",
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSize.defaultPadding),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSize.defaultPadding)
                .copyWith(bottom: 0),
            child: Text(
              headerText,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const Divider(),
          const SizedBox(
            height: AppSize.defaultPadding,
          ),
          Padding(
            padding:
                const EdgeInsets.all(AppSize.defaultPadding).copyWith(top: 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    payIconCard(
                      icon: Assets.creditCard,
                    ),
                    CustomWidget.detailCard(context,
                        title: "Instant payment", desc: "Bank transfer"),
                    payIconCard(
                        icon: Assets.badgeCheck, color: AppColors.green),
                  ],
                ),
                const SizedBox(
                  height: AppSize.defaultPadding,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CustomWidget.detailCard(context,
                          title: "Payer", desc: "Receiver"),
                    ),
                    Expanded(
                      child: CustomWidget.detailCard(context,
                          title: "Amount", desc: "NGN $amount"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Container payIconCard(
      {Color color = AppColors.primaryColor, String icon = ""}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          shape: BoxShape.circle, color: AppColors.scaffoldBackground),
      child: SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(
          color,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  static Container deliveryCard(
    BuildContext context, {
    String headerText = "",
    String pickUpLocation = "",
    String pickUptime = "",
    String pickUpDate = "",
    String dropOffDate = "",
    String dropOffLocation = "",
    String packageSize = "",
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSize.defaultPadding),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSize.defaultPadding)
                .copyWith(bottom: 0),
            child: Text(
              headerText,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const Divider(),
          const SizedBox(
            height: AppSize.defaultPadding,
          ),
          Padding(
            padding:
                const EdgeInsets.all(AppSize.defaultPadding).copyWith(top: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CustomWidget.detailCard(context,
                          title: "Pick-up location", desc: pickUpLocation),
                    ),
                    Expanded(
                      child: CustomWidget.detailCard(context,
                          title: "Pick-up time", desc: pickUptime),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppSize.defaultPadding,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CustomWidget.detailCard(context,
                          title: "Pick-up date", desc: pickUpDate),
                    ),
                    Expanded(
                      child: CustomWidget.detailCard(context,
                          title: "Drop-off date", desc: dropOffDate),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppSize.defaultPadding,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CustomWidget.detailCard(context,
                          title: "Drop-off location", desc: dropOffLocation),
                    ),
                    Expanded(
                      child: CustomWidget.detailCard(context,
                          title: "Package size", desc: packageSize),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget commonBtn({
    String title = "View Detail",
    Color textColor = AppColors.white,
    Color bgColor = AppColors.primaryColor,
    double horizontalPadding = 15,
    double fontSize = 13,
    Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding:
            EdgeInsets.symmetric(vertical: 10, horizontal: horizontalPadding),
        decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(color: textColor, fontSize: fontSize),
        ),
      ),
    );
  }

  static Stack walletBalanceCard(BuildContext context, {String balance = ""}) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: AppSize.defaultPadding),
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Text(
                "Total balance",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: AppSize.defaultPadding / 2,
              ),
              Text(
                "N $balance",
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w900, fontSize: 30),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          bottom: 0,
          child: Image.asset(
            Assets.walletIconLeft,
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Image.asset(
            Assets.walletIconRight,
          ),
        ),
      ],
    );
  }

  static   Row seeAllWidget(BuildContext context,
      {String title = "Recent Trip activity", String desc = "See all", onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.dark,
                fontSize: 12,
              ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Text(
                desc,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                      fontSize: 12,
                    ),
              ),
              const Icon(
                Icons.keyboard_arrow_right,
                color: AppColors.primaryColor,
                size: 15,
              )
            ],
          ),
        ),
      ],
    );
  }

}
