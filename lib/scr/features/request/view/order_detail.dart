import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/common_widgets/appbbutton.dart';
import 'package:jenos/scr/common_widgets/custom_widget.dart';
import 'package:jenos/scr/common_widgets/navigation.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/constant/app_size.dart';
import 'package:jenos/scr/core/util/util.dart';
import 'package:jenos/scr/features/bottom_bar/controller/bottom_bar_controller.dart';
import 'package:jenos/scr/features/bottom_bar/views/bottom_bar.dart';

class OrderDetailsPage extends ConsumerStatefulWidget {
  final request;
  const OrderDetailsPage({super.key, this.request});

  @override
  ConsumerState<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends ConsumerState<OrderDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomWidget.customAppbar(
        context,
        title: "Order details",
        isArrow: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSize.defaultPadding),
        children: [
          Text(
            "Pizza hut",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            "${Util.showFormattedDateString(widget.request['createdAt'], context)}| ${Util.showFormattedTimeVal(widget.request['pickUpDate'], context)}",
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontWeight: FontWeight.w500, color: AppColors.grey),
          ),
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
            name: widget.request['senderName'],
            email: "benjamin@gmail.com",
            phone: widget.request['phone'],
          ),
          //Receiver particular
          CustomWidget.particularCard(
            context,
            headerText: "Receiver's particulars",
            name: widget.request['receiverName'],
            email: "benjamin@gmail.com",
            phone: "090234546575",
          ),
          //delievry detail

          CustomWidget.deliveryCard(
            context,
            headerText: "Delivery details",
            pickUpLocation: "1 Ikeja Str.Lagos",
            pickUptime: "12:10pm",
            pickUpDate: "Oct.27,2023",
            dropOffDate: "Oct.27,2023",
            dropOffLocation: "25, Oshodi, Lagos",
            packageSize: "Medium size",
          ),

          //payment method

          CustomWidget.paymentMethodCard(
            context,
            headerText: "Payment method",
            amount: "10,000",
          ),

          Row(
            children: [
              Expanded(
                child: SizedBox(
                  width: 130,
                  child: AppButton(
                      text: "Accept",
                      onPressed: () {
                        navigate(context, const BottomBar());
                        ref.read(navBarController.notifier).setNavbarIndex(2);
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
                    onPressed: () {},
                    color: AppColors.white,
                    textColor: AppColors.primaryColor,
                    borderColor: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: AppSize.defaultPadding * 4,
          )
        ],
      ),
    );
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
            "Item Image",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(
            height: AppSize.defaultPadding,
          ),
          SizedBox(
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
}
