import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jenos/scr/common_widgets/custom_widget.dart';
import 'package:jenos/scr/constant/app_assets.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/constant/app_size.dart';
import 'package:jenos/scr/core/util/util.dart';

class MyTripsCard extends StatelessWidget {
  final String date;
  final String? itemName;
  final String? receiverName;
  final String? itemImage;
  final String? tripText;
  final String? price;
  final String? pickUpAddress;
  final String? dropOffAddr;
  final Function()? viewDetailTap;
  final Function()? startTripTap;
  final bool isShowTopDate;
  final bool startTrip;
  final bool endTrip;
  const MyTripsCard(
      {super.key,
      required this.date,
      required this.price,
      required this.pickUpAddress,
      required this.tripText,
      required this.dropOffAddr,
      required this.receiverName,
      this.itemName,
      this.itemImage,
      this.viewDetailTap,
      this.startTripTap,
      required this.startTrip,
      this.endTrip = false,
      this.isShowTopDate = true});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
                              // CustomWidget.imagAvatar(
                              //   isBorder: false,
                              //   image: "assets/images/pizza.png",
                              // ),
                              itemImage != null
                                  ? Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      child: Image.network(
                                        itemImage!,
                                        width: 50, height: 50,
                                        fit: BoxFit.cover,
                                        // width: size.width,
                                      ),
                                    )
                                  : Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      child: Image.asset(
                                        "assets/images/pixelBg.jpeg",
                                        fit: BoxFit.cover,
                                        // width: size.width,
                                      ),
                                    ),
                              const SizedBox(
                                width: AppSize.defaultPadding / 2,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: size.width * 0.4,
                                    child: Text(
                                      itemName ?? "Pizza-Hut",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.4,
                                    child: Text(
                                      receiverName!,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.grey,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            "# $price",
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
                                  SizedBox(
                                    width: size.width * 0.6,
                                    child: Text(
                                      pickUpAddress!,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  SizedBox(
                                    width: size.width * 0.6,
                                    child: Text(
                                      dropOffAddr!,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
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
                                  title: "View detail",
                                  textColor: startTrip
                                      ? AppColors.primaryColor
                                      : AppColors.white,
                                  bgColor: startTrip
                                      ? AppColors.white
                                      : AppColors.primaryColor,
                                  onTap: viewDetailTap),
                              const SizedBox(
                                width: 30,
                              ),
                              endTrip
                                  ? const Expanded(
                                      child: SizedBox(
                                      width: 20,
                                    ))
                                  : Util.cardBtn(
                                      bgColor: startTrip
                                          ? AppColors.primaryColor
                                          : AppColors.white,
                                      textColor: startTrip
                                          ? AppColors.white
                                          : AppColors.primaryColor,
                                      title: tripText!,
                                      onTap: startTripTap),
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
