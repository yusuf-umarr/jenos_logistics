import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:jenos/scr/common_widgets/custom_widget.dart';
import 'package:jenos/scr/common_widgets/my_trips_card.dart';
import 'package:jenos/scr/common_widgets/navigation.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/constant/app_size.dart';
import 'package:jenos/scr/core/util/enums.dart';
import 'package:jenos/scr/core/util/util.dart';
import 'package:jenos/scr/features/trip/view/status_update.dart';
import 'package:jenos/scr/features/trip/controller/trips_controller.dart';
import 'package:jenos/scr/features/trip/view/trip_route_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  void initState() {
    getAccountType();
    ref.read(tripController.notifier).getTrips();
    super.initState();
  }

  String accountType = "";

  getAccountType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accountType = prefs.getString('accountType') ?? "individual";
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final tripsProvider = ref.watch(tripController);

    // print("width:$width");
    return Scaffold(
      appBar: CustomWidget.customAppbar(context, title: "My trips"),
      body: Padding(
        padding: const EdgeInsets.all(AppSize.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            tripsHeaderWidget(context, width, accountType),

            Expanded(
              child: ListView.builder(
                  itemCount: tripsProvider.tripsData.length,
                  itemBuilder: (context, int index) {
                    final trip = tripsProvider.tripsData[index];
                    return MyTripsCard(
                      updateTap: () {
                        navigate(context, const StatusUpdatePage());
                      },
                      date: Util.showFormattedTimeString(
                          trip['createdAt'], context),
                    );
                  }),
            )
            // tripsTypesWidget(tripsProvider.tripsData!),
          ],
        ),
      ),
    );
  }

  formatTime(time) {
    DateTime dateTime = DateTime.parse(time);

    // Format the datetime object
    String formattedDate = DateFormat("'Today,' hh:mma").format(dateTime);

    return formattedDate;
  }

  tripsHeaderWidget(BuildContext context, double width, accountType) {
    if (accountType == "individual") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
        ],
      );
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        "Assigned trips",
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  // tripsTypesWidget(List trips) {
  //   if (selectedIndex == 0) {
  //     return Expanded(
  //       child: ListView.builder(
  //           itemCount: trips.length,
  //           itemBuilder: (context, int index) {
  //             final trip = trips[index];
  //             return MyTripsCard(
  //               onTap: () {
  //                 // navigate(context, const TripRoutePage());
  //               },
  //               date: Util.showFormattedTimeString(trip['createdAt'], context),
  //             );
  //           }),
  //     );

  //     // Column(
  //     //   children: trips.map((e) {
  //     // return   MyTripsCard(
  //     //   onTap: () {
  //     //     navigate(context, const TripRoutePage());
  //     //   },
  //     //   date: "Yesterday, 02:05pm",
  //     // );
  //     //   }).toList()

  //     // );
  //   } else if (selectedIndex == 1) {
  //     return Column(
  //       children: [
  //         MyTripsCard(
  //           onTap: () {
  //             navigate(context, const TripRoutePage());
  //           },
  //           itemName: "Cake",
  //           date: "Today, 04:00pm",
  //         ),
  //         MyTripsCard(
  //           onTap: () {
  //             navigate(context, const TripRoutePage());
  //           },
  //           date: "Today, 02:00pm",
  //         ),
  //         MyTripsCard(
  //           onTap: () {
  //             navigate(context, const TripRoutePage());
  //           },
  //           date: "Yesterday, 03:15pm",
  //         )
  //       ],
  //     );
  //   }

  //   return Column(
  //     children: [
  //       MyTripsCard(
  //         onTap: () {
  //           navigate(context, const TripRoutePage());
  //         },
  //         date: "Today, 12:05pm",
  //       ),
  //       MyTripsCard(
  //         onTap: () {
  //           navigate(context, const TripRoutePage());
  //         },
  //         date: "Today, 02:30pm",
  //       ),
  //     ],
  //   );
  // }
}
