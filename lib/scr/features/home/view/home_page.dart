import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/constant/app_assets.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/constant/app_size.dart';
import 'package:jenos/scr/common_widgets/custom_widget.dart';
import 'package:jenos/scr/common_widgets/home_header_widget.dart';
import 'package:jenos/scr/features/bottom_bar/controller/bottom_bar_controller.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
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
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomWidget.customAppbar(context, title: "Dashboard"),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.defaultPadding,
        ).copyWith(
          bottom: 20,
        ),
        child: ListView(
          children: [
            SizedBox(
              height: size.height * 0.02,
            ),
            const HomeHeaderWidget(),

            // PopUp //////////////
            isShowPop
                ? CustomWidget.homePopCard(context, size, () {
                    setState(() {
                      isShowPop = false;
                    });
                  }, () {
                    ref.read(navBarController.notifier).setNavbarIndex(3);
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
                      height: 175,
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
                                color: AppColors.white),
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
                height: 175,
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
                  return CustomWidget.homeTripCard(
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
            CustomWidget.seeAllWidget(context, onTap: () {}),

            SizedBox(
              height: size.height * 0.05,
            ),

            CustomWidget.recentTripCard(context)

            //
          ],
        ),
      ),
    );
  }
}
