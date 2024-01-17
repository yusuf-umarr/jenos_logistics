import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jenos/scr/constant/app_colors.dart';

class CustomHeader {
  static AppBar customAppbar(BuildContext context, String title) {
    return AppBar(
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      centerTitle: true,
      backgroundColor: AppColors.background,
      elevation: 0,
    );
  }

  static Container headerCard(String img) {
    return Container(
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
    );
  }

  static Container imagAvatar(
      {String image = "assets/images/profileImage.png",
      bool isBorder = false}) {
    return Container(
      height: 50,
      width: 50,
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
                color: AppColors.scaffoldBackground,
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
                vertical: 15,
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
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "Complete Setting Now",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.scaffoldBackground,
                          ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              right: 0,
              child: IconButton(
                  onPressed: onTap,
                  icon: Icon(
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

static   Stack carouselSliderWidget(BuildContext context) {
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
                          .copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.scaffoldBackground),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              );
  }

}
