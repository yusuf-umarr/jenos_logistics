import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jenos/scr/common_widgets/custom_widget.dart';
import 'package:jenos/scr/common_widgets/navigation.dart';
import 'package:jenos/scr/constant/app_assets.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/constant/app_size.dart';
import 'package:jenos/scr/core/util/util.dart';
import 'package:jenos/scr/features/trip/view/status_update.dart';

class MyTripsCard extends StatelessWidget {
  final String date;
  final String? itemName;
  final Function()? endTripTap;
  final Function()? updateTap;
  final bool isShowTopDate;
  const MyTripsCard(
      {super.key,
      required this.date,
      this.itemName,
      this.endTripTap,
      this.updateTap,
      this.isShowTopDate = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isShowTopDate
            ? Column(
                children: [
                  Text(
                    date,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              )
            : const SizedBox.shrink(),
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: AppSize.defaultPadding),
              padding:
                  const EdgeInsets.symmetric(vertical: AppSize.defaultPadding),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(
                  AppSize.defaultPadding,
                ),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSize.defaultPadding),
                      child: Row(
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    itemName ?? "Pizza-Hut",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  Text(
                                    "Nweke Jonathan",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.greyColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            "N 3,000",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryColor),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSize.defaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Trip",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(Assets.tripLine),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "20 Okota palace, lagos state",
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                    "15 Okota palace, lagos state",
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Util.cardBtn(
                                  title: "End trip", //request['status'],
                                  // bgColor: AppColors.white,
                                  // textColor: AppColors.primaryColor,
                                  onTap: () {
                                    // navigate(context, const StatusUpdatePage());
                                  }),
                              const SizedBox(
                                width: 30,
                              ),
                              Util.cardBtn(
                                  title: "Update trip", //request['status'],

                                  onTap: () {
                                    navigate(context, const StatusUpdatePage());
                                  }),
                            ],
                          )
                        ],
                      ),
                    ),
                  ]),
            ),
            !isShowTopDate
                ? Positioned(
                    bottom: 15,
                    right: 5,
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.cancel,
                          color: AppColors.primaryColor,
                        )))
                : const SizedBox()
          ],
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
