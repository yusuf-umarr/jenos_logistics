import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/common_widgets/request_card_widget.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/constant/app_size.dart';
import 'package:jenos/scr/common_widgets/custom_widget.dart';
import 'package:jenos/scr/features/request/controller/request_notifier.dart';

class RequestPage extends ConsumerStatefulWidget {
  const RequestPage({super.key});

  @override
  ConsumerState<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends ConsumerState<RequestPage> {
  @override
  void initState() {
    ref.read(requestNotifier.notifier).getRiderRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidget.customAppbar(context, title: "Request Order"),
      body: Padding(
        padding: const EdgeInsets.all(
          AppSize.defaultPadding,
        ),
        child: Builder(builder: (context) {
          final requestNoti = ref.watch(requestNotifier);

              requestNoti.requestData.sort((a, b) {
            DateTime dateTimeA = DateTime.parse(a['createdAt']);
            DateTime dateTimeB = DateTime.parse(b['createdAt']);
            return dateTimeB.compareTo(dateTimeA); // Descending order
          });
          // log("requestNoti.requestData:${requestNoti.requestData.length}");

          if (requestNoti.requestData.isNotEmpty) {
            return ListView.builder(
                itemCount: requestNoti.requestData.length,
                itemBuilder: (context, int index) {
                  final request = requestNoti.requestData[index];

                  if (requestNoti.requestData[index]['createdBy'] != null) {
                    return RequestOrderCardWIdget(request: request);
                  }
                  return const SizedBox();
                });
          } else {
            return Center(
              child: Text(
                "Opp! no request! check back later",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w600, color: AppColors.dark),
              ),
            );
          }
        }),
      ),
    );
  }
}
