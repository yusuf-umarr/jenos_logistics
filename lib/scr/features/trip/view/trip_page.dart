import 'dart:developer';

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
import 'package:jenos/scr/features/request/view/order_detail.dart';
import 'package:jenos/scr/features/trip/controller/trips_controller.dart';

class TripsPage extends ConsumerStatefulWidget {
  final AccountType accountType;
  const TripsPage({
    super.key,
    required this.accountType,
  });

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
    // getAccountType();
    ref.read(tripController.notifier).getTrips();
    super.initState();
  }

  // String accountType = "";

  // getAccountType() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   accountType = prefs.getString('accountType') ?? "individual";
  // }

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
            tripsHeaderWidget(context, width),
            tripsTypesBottomWidget(tripsProvider),
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

  tripsHeaderWidget(BuildContext context, double width) {
    if (widget.accountType == AccountType.individual) {
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
    } else {
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
  }

  tripsTypesBottomWidget(tripsProvider) {
    if (selectedIndex == 0) {
      return Expanded(
        child: ListView.builder(
            itemCount: tripsProvider.tripsData.length,
            itemBuilder: (context, int index) {
              final trip = tripsProvider.tripsData[index];

              if (!trip['endTrip']) {
                //ongoing/active trip
                return MyTripsCard(
                  pickUpAddress: trip['trackingInfo']['pickUpAddress'],
                  dropOffAddr: trip['trackingInfo']['dropOffAddress'],
                  price: trip['requestId']['amount'].toString(),
                  startTrip: trip['startTrip'],
                  itemImage: trip['requestId']['itemImage'],
                  tripText: tripsProvider.loadState == NetworkState.loading
                      ? "Loading..."
                      : trip['startTrip']
                          ? "End trip"
                          : "Start trip",
                  date:
                      Util.showFormattedTimeString(trip['createdAt'], context),
                  viewDetailTap: () {
                    navigate(context,
                        OrderDetailsPage(request: trip, isFromTrip: true));
                  },
                  startTripTap: () {
                    if (trip['startTrip']) {
                      //end trip

                      ref
                          .read(tripController.notifier)
                          .endTrip(trip['_id'], context);
                    } else {
                      //start trip
                      ref
                          .read(tripController.notifier)
                          .startTrip(trip['_id'], context);
                    }
                  },
                );
              }
              return const Center(
                child: Text("Opp! no active trip!!!"),
              );
            }),
      );
    } else if (selectedIndex == 1) {
      return Expanded(
        child: ListView.builder(
            itemCount: tripsProvider.tripsData.length,
            itemBuilder: (context, int index) {
              final trip = tripsProvider.tripsData[index];

              if (trip['endTrip']) {
                //completed trip
                return MyTripsCard(
                  pickUpAddress: trip['trackingInfo']['pickUpAddress'],
                  dropOffAddr: trip['trackingInfo']['dropOffAddress'],
                  price: trip['requestId']['amount'].toString(),
                  startTrip: trip['startTrip'],
                  endTrip: trip['endTrip'],
                  itemImage: trip['requestId']['itemImage'],
                  tripText: tripsProvider.loadState == NetworkState.loading
                      ? "Loading..."
                      : trip['startTrip']
                          ? "End trip"
                          : "Start trip",
                  date:
                      Util.showFormattedTimeString(trip['createdAt'], context),
                  viewDetailTap: () {
                    navigate(context,
                        OrderDetailsPage(request: trip, isFromTrip: true));
                  },
                  startTripTap: () {
                    if (trip['startTrip']) {
                      //end trip

                      ref
                          .read(tripController.notifier)
                          .endTrip(trip['_id'], context);
                    } else {
                      //start trip
                      ref
                          .read(tripController.notifier)
                          .startTrip(trip['_id'], context);
                    }

                    // navigate(context, const StatusUpdatePage());
                  },
                );
              }
              return const SizedBox();
            }),
      );
    }

    return Expanded(
      child: ListView.builder(
          itemCount: tripsProvider.tripsData.length,
          itemBuilder: (context, int index) {
            final trip = tripsProvider.tripsData[index];

            // if (!trip['endTrip']) {
            //   return

            //   MyTripsCard(
            //     pickUpAddress: trip['trackingInfo']['pickUpAddress'],
            //     dropOffAddr: trip['trackingInfo']['dropOffAddress'],
            //     price: trip['requestId']['amount'].toString(),
            //     startTrip: trip['startTrip'],
            //     itemImage: trip['requestId']['itemImage'],
            //     tripText:
            //         tripsProvider.loadState == NetworkState.loading
            //             ? "Loading..."
            //             : trip['startTrip']
            //                 ? "End trip"
            //                 : "Start trip",
            //     date: Util.showFormattedTimeString(
            //         trip['createdAt'], context),
            //     viewDetailTap: () {
            //       navigate(
            //           context,
            //           OrderDetailsPage(
            //               request: trip, isFromTrip: true));
            //     },
            //     startTripTap: () {
            //       if (trip['startTrip']) {
            //         //end trip

            //         ref
            //             .read(tripController.notifier)
            //             .endTrip(trip['_id'], context);
            //       } else {
            //         //start trip
            //         ref
            //             .read(tripController.notifier)
            //             .startTrip(trip['_id'], context);
            //       }

            //       // navigate(context, const StatusUpdatePage());
            //     },
            //   );
            // }
            return const SizedBox();
          }),
    );
  }
}
