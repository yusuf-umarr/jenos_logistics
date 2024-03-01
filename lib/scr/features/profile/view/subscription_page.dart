// import 'package:flutter/material.dart';
// import 'package:jenos/scr/common_widgets/appbbutton.dart';
// import 'package:jenos/scr/common_widgets/custom_widget.dart';
// import 'package:jenos/scr/constant/app_colors.dart';
// import 'package:jenos/scr/constant/app_size.dart';

// class SubscriptionPage extends StatefulWidget {
//   const SubscriptionPage({super.key});

//   @override
//   State<SubscriptionPage> createState() => _SubscriptionPageState();
// }

// class _SubscriptionPageState extends State<SubscriptionPage> {
//   List subscriptionList = [
//     {
//       "id": 0,
//       "name": "LTE",
//       "deliveries": "20 Deliveries",
//       "type": "Jenos Lite",
//       "period": "Monthly",
//     },
//     {
//       "id": 1,
//       "name": "PLUS",
//       "deliveries": "30 Deliveries",
//       "type": "Jenos Plus",
//       "period": "Monthly",
//     },
//     {
//       "id": 2,
//       "name": "MEGA",
//       "deliveries": "12 Deliveries",
//       "type": "Jenos Mega",
//       "period": "Monthly",
//     },
//   ];

//   int selectedItem = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomWidget.customAppbar(context,
//           title: "Subscription", isArrow: true),
//       body: Padding(
//         padding: const EdgeInsets.all(AppSize.defaultPadding),
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                   itemCount: subscriptionList.length,
//                   itemBuilder: (context, index) {
//                     final sub = subscriptionList[index];
//                     return CustomWidget.subscriptionCard(context,
//                         textOne: sub['name'],
//                         textTwo: sub['deliveries'],
//                         textThree: sub['type'],
//                         bgColor: selectedItem == sub['id']
//                             ? AppColors.primaryColor
//                             : AppColors.white,
//                         textColor: selectedItem == sub['id']
//                             ? AppColors.white
//                             : AppColors.grey,
//                         textFour: sub['period'], onTap: () {
//                       setState(() {
//                         selectedItem = sub['id'];
//                       });
//                     });
//                   }),
//             ),
//             const SizedBox(
//               height: AppSize.defaultPadding,
//             ),
//             Text(
//               "Jenos Plus Specific features",
//               style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                     fontWeight: FontWeight.bold,
//                   ),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               "Suitable for small business or merchants who  make more than 30 deliveries on a monthly basis. Subscribe for this plan and enjoy a 45.00% discount on your 12 bookings",
//               style: Theme.of(context)
//                   .textTheme
//                   .bodySmall!
//                   .copyWith(color: Colors.black),
//               textAlign: TextAlign.start,
//             ),
//             const SizedBox(
//               height: AppSize.defaultPadding,
//             ),
//             AppButton(
//               text: "Subscribe",
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
