import 'package:flutter/material.dart';
import 'package:jenos/scr/common_widgets/custom_widget.dart';
import 'package:jenos/scr/constant/app_size.dart';

class PersonalDetailPage extends StatelessWidget {
  const PersonalDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidget.customAppbar(context,
          title: "Personal details", isArrow: true),
      body: ListView(
        padding: const EdgeInsets.all(AppSize.defaultPadding),
        children: [
          
        ],
      ),
    );
  }
}
