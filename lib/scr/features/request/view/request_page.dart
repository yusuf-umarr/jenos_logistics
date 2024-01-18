import 'package:flutter/material.dart';
import 'package:jenos/scr/common_widgets/request_card_widget.dart';
import 'package:jenos/scr/constant/app_size.dart';
import 'package:jenos/scr/common_widgets/custom_widget.dart';

class RequestPage extends StatelessWidget {
  const RequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidget.customAppbar(context,title: "Request Order"),
      body: Padding(
        padding: const EdgeInsets.all(
          AppSize.defaultPadding,
        ),
        child: ListView(
          children: const [
            RequestOrderCardWIdget(),
            RequestOrderCardWIdget(),
            RequestOrderCardWIdget(),
            RequestOrderCardWIdget(),
          ],
        ),
      ),
    );
  }
}
