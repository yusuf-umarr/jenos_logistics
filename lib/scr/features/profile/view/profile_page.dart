import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jenos/scr/common_widgets/custom_widget.dart';
import 'package:jenos/scr/constant/app_assets.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/constant/app_size.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomWidget.customAppbar(context, title: "Profile", isArrow: true),
      body: ListView(
        padding: const EdgeInsets.all(AppSize.defaultPadding),
        children: [
          Stack(
            children: [
              Positioned(
                  child: Image.asset(
                Assets.profileCard,
                fit: BoxFit.cover,
              )),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSize.defaultPadding,
                      vertical: AppSize.defaultPadding / 2),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CustomWidget.imagAvatar(),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Kayode Kola",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.white),
                              ),
                              Text(
                                "@MrK",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: AppSize.defaultPadding,
                      ),
                      profilePhoneCard(
                        context,
                        img: Assets.phoneMissed,
                        text: "09043568734",
                        fontWeight: FontWeight.bold,
                      ),
                      profilePhoneCard(
                        context,
                        img: Assets.officeBuilding,
                        text: "GIGM Logistics",
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget profilePhoneCard(BuildContext context,
      {String img = "",
      String text = "",
      FontWeight fontWeight = FontWeight.w300}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Container(
              padding: const EdgeInsets.all(5),
              height: 30,
              width: 30,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.white),
              child: SvgPicture.asset(img)),
          const SizedBox(
            width: AppSize.defaultPadding,
          ),
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: fontWeight, color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
