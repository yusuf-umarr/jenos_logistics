import 'package:flutter/material.dart';
import 'package:jenos/scr/common_widgets/custom_widget.dart';
import 'package:jenos/scr/common_widgets/notification_card.dart';
import 'package:jenos/scr/constant/app_size.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomWidget.customAppbar(context,
          title: "Notification", isArrow: true),
      body: ListView(
        padding: const EdgeInsets.all(AppSize.defaultPadding),
        children: [
          NotificationCard(size: size),
          NotificationCard(size: size),
          NotificationCard(size: size),
        ],
      ),
    );
  }
}
