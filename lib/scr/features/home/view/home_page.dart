import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jenos/scr/constant/app_assets.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/constant/app_size.dart';
import 'package:jenos/scr/custom_widgets/custom_header.dart';
import 'package:jenos/scr/custom_widgets/home_header_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var dataList = [
    {
      "text": "Spend time each day\nFocusing on your mental\nhealth",
      "image": "assets/images/dash-image.png",
    },
    {
      "text": "Allow yourself the\nopportunity to meet\na trained therapist.",
      "image": "assets/images/consult_therapist_image.png",
    },
  ];

  List<Map<String, dynamic>> assetsList = [
    {
      "name": "Total Assets",
      "price": "N10,000",
      "desc": "Generated",
      "icon": Assets.creditCard,
      "color": AppColors.cardOne,
      "iconColor": Colors.green,
    },
    {
      "name": "Total Trips",
      "price": "500",
      "desc": "Trips",
      "icon": Assets.tripIcon,
      "color": AppColors.cardTwo,
      "iconColor": AppColors.dark,
    },
    {
      "name": "Completed Trips",
      "price": "300",
      "desc": "Trips",
      "icon": Assets.locationMarker,
      "color": AppColors.cardThree,
      "iconColor": AppColors.dark,
    },
    {
      "name": "Active Trips",
      "price": "300",
      "desc": "Trips",
      "icon": Assets.badgeCheck,
      "color": AppColors.cardFour,
      "iconColor": Colors.green,
    },
  ];

  bool isShowPop = true;
  int _current = 0;
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    final List imageSliders = dataList;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomHeader.customAppbar(context, "Dashboard"),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.defaultPadding,
        ).copyWith(
          bottom: 20,
        ),
        child: ListView(
          children: [
            SizedBox(
              height: size.height * 0.005,
            ),
            const HomeHeaderWidget(),

            // PopUp //////////////
            isShowPop
                ? CustomHeader.homePopCard(context, size, () {
                    setState(() {
                      isShowPop = false;
                    });
                  })
                : const SizedBox.shrink(),

            // PopUp //////////////
            SizedBox(
              height: size.height * 0.05,
            ),

            CarouselSlider.builder(
              itemCount: dataList.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) {
                print("itemIndex:$itemIndex");
                final data = dataList[itemIndex];
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
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: dataList.asMap().entries.map((entry) {
                          return Container(
                            width: 9.0,
                            height: 9.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Colors.white).withOpacity(
                                    _current == entry.key ? 0.9 : 0.4)),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                );
              },
              options: CarouselOptions(
                height: 155,
                aspectRatio: 16 / 9,
                viewportFraction: 1,
                autoPlay: true,
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            // Row(
            //   children: [
            //     homeTripCard(context),
            //     homeTripCard(context),
            //   ],
            // )

            SizedBox(
              height: 350,
              child: GridView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 170,
                  crossAxisSpacing: 17,
                  childAspectRatio: 1,
                ),
                itemCount: assetsList.length,
                itemBuilder: (context, index) {
                  final card = assetsList[index];
                  return CustomHeader.homeTripCard(
                    context,
                    card['name']!,
                    card['desc']!,
                    card['icon']!,
                    card['price']!,
                    card['color']!,
                    card['iconColor'],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent Trip activity",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.dark,
                        fontSize: 12,
                      ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Text(
                        "See all",
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
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
            ),

            SizedBox(
              height: size.height * 0.05,
            ),

            Container(
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
                      CustomHeader.imagAvatar(
                        isBorder: false,
                        image: "assets/images/pizza.png",
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pizza-Hut",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.dark,
                                  fontSize: 12,
                                ),
                          ),
                          Text(
                            "Today,7:10pm",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
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
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.dark,
                                  fontSize: 12,
                                ),
                      ),
                      Text(
                        "15.12.2023",
                        textAlign: TextAlign.end,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.greyColor,
                                  fontSize: 10,
                                ),
                      ),
                    ],
                  ),
                ],
              ),
            )

            //
          ],
        ),
      ),
    );
  }
}
