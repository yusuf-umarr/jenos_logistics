import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/common_widgets/request_card_widget.dart';
import 'package:jenos/scr/constant/app_size.dart';
import 'package:jenos/scr/common_widgets/custom_widget.dart';
import 'package:jenos/scr/features/request/controller/request_notifier.dart';

class RequestPage extends ConsumerWidget {
  const RequestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final requestNoti = ref.watch(requestNotifier);

    return Scaffold(
      appBar: CustomWidget.customAppbar(context,title: "Request Order"),
      body: Padding(
        padding: const EdgeInsets.all(
          AppSize.defaultPadding,
        ),
        child: ListView.builder(
          itemCount:requestNoti.requestData.length ,
          itemBuilder: (context, int index){
            final request = requestNoti.requestData[index];
            return  RequestOrderCardWIdget(request:request);
          })
        
        // ListView(
        //   children: const [
        //     RequestOrderCardWIdget(),
        //     RequestOrderCardWIdget(),
        //     RequestOrderCardWIdget(),
        //     RequestOrderCardWIdget(),
        //   ],
        // ),
      ),
    );
  }
}
