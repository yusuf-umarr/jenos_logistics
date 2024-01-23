import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/common_widgets/custom_widget.dart';
import 'package:jenos/scr/common_widgets/my_trips_card.dart';
import 'package:jenos/scr/common_widgets/navigation.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/constant/app_size.dart';
import 'package:jenos/scr/features/trip/controller/onboard_controller.dart';
import 'package:jenos/scr/features/trip/view/trip_route_page.dart';

class TripsPage extends ConsumerStatefulWidget {
  const TripsPage({super.key});

  @override
  ConsumerState<TripsPage> createState() => _TripsPageState();
}

class _TripsPageState extends ConsumerState<TripsPage> {
  List tripType = [
    {"id": 0, "name": "Active"},
    {"id": 1, "name": "Completed"},
    {"id": 2, "name": "Declined"},
  ];

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    // print("width:$width");
    return Scaffold(
      appBar: CustomWidget.customAppbar(context, title: "My trips"),
      body: ListView(
        padding: const EdgeInsets.all(AppSize.defaultPadding),
        children: [
          Text(
            "My trips",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 40,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tripType.length,
                itemBuilder: (context, int index) {
                  final trip = tripType[index];
                  return Container(
                    margin: const EdgeInsets.only(right: 15),
                    child: CustomWidget.commonBtn(
                        horizontalPadding: width > 400 ? 25 : 17,
                        title: trip['name'],
                        bgColor: selectedIndex == trip['id']
                            ? AppColors.primaryColor
                            : AppColors.white,
                        textColor: selectedIndex == trip['id']
                            ? AppColors.white
                            : AppColors.primaryColor,
                        onTap: () {
                          setState(() {
                            selectedIndex = trip['id'];
                          });
                        }),
                  );
                }),
          ),
          const SizedBox(
            height: 20,
          ),
          tripsTypesWidget(),
        ],
      ),
    );
  }

  tripsTypesWidget() {
    if (selectedIndex == 0) {
      return Column(
        children: [
          MyTripsCard(
            onTap: () async {
              // await ref.read(tripController.notifier).getCurrentLocation();
              if (mounted) {
                navigate(context, const TripRoutePage());
              }
            },
            date: "Today, 02:05pm",
          ),
          MyTripsCard(
            onTap: () {
              navigate(context, const TripRoutePage());
            },
            itemName: "Burger",
            date: "Today, 01:05pm",
          ),
          MyTripsCard(
            onTap: () {
              navigate(context, const TripRoutePage());
            },
            date: "Yesterday, 02:05pm",
          )
        ],
      );
    } else if (selectedIndex == 1) {
      return Column(
        children: [
          MyTripsCard(
            onTap: () {
              navigate(context, const TripRoutePage());
            },
            itemName: "Cake",
            date: "Today, 04:00pm",
          ),
          MyTripsCard(
            onTap: () {
              navigate(context, const TripRoutePage());
            },
            date: "Today, 02:00pm",
          ),
          MyTripsCard(
            onTap: () {
              navigate(context, const TripRoutePage());
            },
            date: "Yesterday, 03:15pm",
          )
        ],
      );
    }

    return Column(
      children: [
        MyTripsCard(
          onTap: () {
            navigate(context, const TripRoutePage());
          },
          date: "Today, 12:05pm",
        ),
        MyTripsCard(
          onTap: () {
            navigate(context, const TripRoutePage());
          },
          date: "Today, 02:30pm",
        ),
      ],
    );
  }
}
