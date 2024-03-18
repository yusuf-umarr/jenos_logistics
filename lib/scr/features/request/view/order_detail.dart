import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/common_widgets/appbbutton.dart';
import 'package:jenos/scr/common_widgets/custom_widget.dart';
import 'package:jenos/scr/common_widgets/navigation.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/constant/app_size.dart';
import 'package:jenos/scr/core/util/enums.dart';
import 'package:jenos/scr/core/util/util.dart';
import 'package:jenos/scr/features/bottom_bar/controller/bottom_bar_controller.dart';
import 'package:jenos/scr/features/bottom_bar/views/bottom_bar.dart';
import 'package:jenos/scr/features/request/controller/request_controller.dart';
import 'package:jenos/scr/features/request/controller/request_state.dart';
import 'package:jenos/scr/features/trip/controller/trips_controller.dart';

class OrderDetailsPage extends ConsumerStatefulWidget {
  final request;
  final bool isFromTrip;
  const OrderDetailsPage({super.key, this.request, this.isFromTrip = false});

  @override
  ConsumerState<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends ConsumerState<OrderDetailsPage> {
  final TextEditingController otpController = TextEditingController();
  final _rkey = GlobalKey<FormState>();

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("==========================:====================");
    log("request detail:${widget.request}");
    final Size size = MediaQuery.of(context).size;
    return Consumer(builder: (context, ref, _) {
      // final accountType = ref.watch(requestController).accountType;

      ref.listen<RequestState>(requestController, (prev, state) {
        if (state.loadState == NetworkState.error) {
          Util.showSnackBar(
            context,
            state.message != "" ? state.message.toString() : "Server error",
            color: Colors.red,
          );
        } else if (state.loadState == NetworkState.success) {
          Util.showSnackBar(
            context,
            state.message.toString(),
            color: Colors.green,
          );
          Future.delayed(const Duration(seconds: 3), () {
            navigate(context, const BottomBar());
            ref.read(navBarController.notifier).setNavbarIndex(2);
          });
        }
      });
      return Scaffold(
        appBar: CustomWidget.customAppbar(
          context,
          title: "Details",
          isArrow: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(AppSize.defaultPadding),
          children: [
            !widget.isFromTrip
                ? Text(
                    "${Util.showFormattedDateString(widget.request['createdAt'], context)}| ${Util.showFormattedTimeVal(widget.request['pickUpDate'], context)}",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w500, color: AppColors.grey),
                  )
                : const SizedBox(),
            const SizedBox(
              height: AppSize.defaultPadding,
            ),
            //image card
            imageCard(context, size),
            const SizedBox(
              height: AppSize.defaultPadding,
            ),
            //Requester particular
            CustomWidget.particularCard(
              context,
              headerText: "Requester's particulars",
              name: widget.isFromTrip
                  ? widget.request['requestId']['senderName']
                  : widget.request['senderName'],
              email: widget.isFromTrip
                  ? ""
                  : widget.request['createdBy']['email'] ?? "",
              phone: widget.isFromTrip
                  ? widget.request['requester']['phoneNumber']
                  : widget.request['requesterPhone'] ?? "",
              onTap: () {
                Util.callNumber(
                    " ${widget.isFromTrip ? widget.request['requester']['phoneNumber'] : widget.request['senderPhone'] ?? "0"}");
              },
              isWidget: true,
            ),
            //Receiver particular
            CustomWidget.particularCard(
              context,
              headerText: "Receiver's particulars",
              name: widget.isFromTrip
                  ? widget.request['requestId']['receiverName']
                  : widget.request['receiverName'],
              email: widget.request['receiverEmail'] ?? "",
              phone: widget.isFromTrip
                  ? widget.request['requestId']['receiverPhone']
                  : widget.request['receiverPhone'],
              onTap: () {
                Util.callNumber(
                    " ${widget.isFromTrip ? widget.request['requester']['receiverPhone'] : widget.request['receiverPhone'] ?? "0"}");
              },
              isWidget: true,
            ),
            //delievry detail

            CustomWidget.deliveryCard(
              context,
              headerText: "Addresses & Date details",
              pickUpLocation: widget.isFromTrip
                  ? widget.request['requestId']['pickUpAddress']
                  : widget.request['pickUpAddress'],
              pickUptime: widget.isFromTrip
                  ? widget.request['requestId']['pickUpTime']
                  : widget.request['pickUpTime'],
              pickUpDate: widget.isFromTrip
                  ? "${Util.showFormattedDateString(widget.request['requestId']['pickUpDate'], context)}"
                  // widget.request['requestId']['pickUpDate']
                  : "${Util.showFormattedDateString(widget.request['pickUpDate'], context)}",
              dropOffDate: widget.isFromTrip
                  ? widget.request['requestId']['requestType']
                  : widget.request['requestType'],
              dropOffLocation: widget.isFromTrip
                  ? widget.request['requestId']['deliveryAddress']
                  : widget.request['deliveryAddress'],
              packageSize: "Medium size",
            ),

            //payment method

            CustomWidget.paymentMethodCard(context,
                headerText: "Payment method",
                amount: widget.isFromTrip
                    ? widget.request['requestId']['amount'].toString()
                    : widget.request['amount'].toString(),
                paymentType: widget.isFromTrip
                    ? widget.request['requestId']['paymentType']
                    : widget.request['paymentType']),

            if (widget.isFromTrip)
              Column(
                children: [
                  !widget.request['endTrip']
                      ? Consumer(builder: (context, ref, _) {
                          final loadState = ref.watch(tripController).loadState;

                          return AppButton(
                              isLoading: loadState == NetworkState.loading,
                              text: widget.request['startTrip']
                                  ? "End trip"
                                  : "Start trip",
                              onPressed: () {
                                log("trip id:${widget.request['_id']}");
                                if (widget.request['startTrip']) {
                                  //end trip

                                  showModalBottomSheet<void>(
                                    isScrollControlled: true,
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(50),
                                          topRight: Radius.circular(50)),
                                    ),
                                    builder: (BuildContext context) {
                                      return showModal(
                                          context, widget.request, size);
                                    },
                                  );
                                } else {
                                  //start trip
                                  ref.read(tripController.notifier).startTrip(
                                      widget.request['_id'], context);
                                }

                                //

                                Future.delayed(const Duration(seconds: 3), () {
                                  navigate(context, const BottomBar());
                                  ref
                                      .read(navBarController.notifier)
                                      .setNavbarIndex(2);
                                });
                              });
                        })
                      : const SizedBox(),
                ],
              )
            else
              widget.request['status'] == "pending"
                  ? Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: 130,
                            child: Consumer(builder: (context, ref, _) {
                              final state =
                                  ref.watch(requestController).loadState;

                              return AppButton(
                                  isLoading: state == NetworkState.loading,
                                  text: "Accept",
                                  onPressed: () {
                                    ref
                                        .read(requestController.notifier)
                                        .updateRequest("accepted",
                                            widget.request['_id'], context);
                                  });
                            }),
                          ),
                        ),
                        const SizedBox(
                          width: AppSize.defaultPadding * 3,
                        ),
                        Expanded(
                          child: SizedBox(
                            width: 130,
                            child: AppButton(
                              text: "Decline",
                              onPressed: () {
                                log("widget.request:${widget.request['_id']}");
                              },
                              color: AppColors.white,
                              textColor: AppColors.primaryColor,
                              borderColor: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    )
                  : AppButton(
                      text: "Go to trips",
                      onPressed: () {
                        navigate(context, const BottomBar());
                        ref.read(navBarController.notifier).setNavbarIndex(2);
                      }),

            const SizedBox(
              height: AppSize.defaultPadding * 4,
            )
          ],
        ),
      );
    });
  }

  Container imageCard(BuildContext context, Size size) {
    return Container(
      padding: const EdgeInsets.all(AppSize.defaultPadding),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.isFromTrip
                ? widget.request['requestId']['title'] ?? ""
                : widget.request['title'] ?? "",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(
            height: AppSize.defaultPadding,
          ),

          widget.isFromTrip
              ? SizedBox(
                  height: size.height * 0.15,
                  child: widget.request['requestId']['itemImage'] != null
                      ? Image.network(
                          widget.request['requestId']['itemImage']!,
                          fit: BoxFit.cover,
                          width: size.width,
                        )
                      : Image.asset(
                          "assets/images/pixelBg.jpeg",
                          fit: BoxFit.cover,
                          width: size.width,
                        ),
                )
              : SizedBox(
                  height: size.height * 0.15,
                  child: widget.request['itemImage'] != null
                      ? Image.network(
                          widget.request['itemImage']!,
                          fit: BoxFit.cover,
                          width: size.width,
                        )
                      : Image.asset(
                          "assets/images/pixelBg.jpeg",
                          fit: BoxFit.cover,
                          width: size.width,
                        ),
                )
          // Image.asset(
          //   "assets/images/pizzaa.png",
          //   fit: BoxFit.cover,
          // )
        ],
      ),
    );
  }

  showModal(context, trip, Size size) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Form(
        key: _rkey,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(20).copyWith(top: 40),
              height: MediaQuery.of(context).viewInsets.bottom == 0
                  ? size.height * 0.47
                  : size.height * 0.78,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "End trip",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Enter the 4-digit OTP code sent to the receiver to end the trip",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.black),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 20),
                      Util.inputField2(
                        externalText: "Otp code",
                        hint: "****",
                        inputType: TextInputType.number,
                        controller: otpController,
                        validator: Util.validateName,
                      ),
                      const SizedBox(height: 40),
                      AppButton(
                          height: 55,
                          isIcon: true,
                          text: 'Proceed',
                          onPressed: () async {
                            FocusScope.of(context).unfocus();

                            if (_rkey.currentState!.validate()) {
                              ref.read(tripController.notifier).endTrip(
                                  trip['_id'], otpController.text, context);
                              Navigator.of(context).pop();
                            }
                          },
                          color: AppColors.primaryColor,
                          textColor: Colors.white),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              right: 10,
              top: 5,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.cancel,
                  color: AppColors.primaryColor,
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
