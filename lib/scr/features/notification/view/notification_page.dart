import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/common_widgets/custom_widget.dart';
import 'package:jenos/scr/common_widgets/notification_card.dart';
import 'package:jenos/scr/constant/app_size.dart';
import 'package:jenos/scr/features/profile/controller/user_profile/pprofile_controller.dart';

class NotificationPage extends ConsumerStatefulWidget {
  final bool isArrowBack;
  const NotificationPage({super.key, required this.isArrowBack});

  @override
  ConsumerState<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends ConsumerState<NotificationPage> {
  @override
  void initState() {
    ref.read(profileController.notifier).getNotifications();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final provider = ref.watch(profileController);
    return Scaffold(
        appBar: CustomWidget.customAppbar(context,
            title: "Notification", isArrow: widget.isArrowBack),
        body: ListView.builder(
            padding: const EdgeInsets.all(AppSize.defaultPadding),
            itemCount: provider.appNotificationList!.length,
            itemBuilder: (context, int index) {
              final noti = provider.appNotificationList![index];
              return NotificationCard(index: noti);
            })

        // ListView(
        //   padding: const EdgeInsets.all(AppSize.defaultPadding),
        //   children: [
        //     NotificationCard(size: size),
        //     NotificationCard(size: size),
        //     NotificationCard(size: size),
        //   ],
        // ),
        );
  }
}
