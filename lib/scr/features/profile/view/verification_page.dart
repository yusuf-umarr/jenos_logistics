import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jenos/scr/common_widgets/appbbutton.dart';
import 'package:jenos/scr/common_widgets/custom_widget.dart';
import 'package:jenos/scr/constant/app_assets.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/constant/app_size.dart';
import 'package:jenos/scr/core/util/util.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  File? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidget.customAppbar(context,
          title: "Verification", isArrow: true),
      body: ListView(
        padding: const EdgeInsets.all(AppSize.defaultPadding),
        children: [
          const SizedBox(
            height: AppSize.defaultPadding,
          ),
          Util.inputField2(
            isExternalLabel: true,
            useExternalText: true,
            isPrefix: false,
            isCompulsory: false,
            enable: false,
            fontSizeExternal: 14,
            borderRadius: 5,
            borderColor: AppColors.greyColor,
            bgColor: Colors.white,
            externalText: "Upload a valid identity card",
            hint: "Chose a file",
            hintColor: Colors.grey,
            externalTextColor: Colors.black,
            prefixIconColor: AppColors.primaryColor,
            suffixWidget: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SvgPicture.asset(Assets.cloudUpload),
            ),
            onTap: () {
              // print("chose a file");
            },
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Supported file types: JPEG, PNG or PDF",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.grey,
                fontSize: 10,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: AppSize.defaultPadding * 1.5,
          ),
          Util.inputField2(
            isExternalLabel: true,
            useExternalText: true,
            isPrefix: false,
            isCompulsory: false,
            fontSizeExternal: 14,
            borderRadius: 5,
            borderColor: AppColors.greyColor,
            bgColor: Colors.white,
            externalText: "Bike plate number",
            hint: "Eg:Lag 23 k",
            hintColor: Colors.grey,
            externalTextColor: Colors.black,
            prefixIconColor: AppColors.primaryColor,

            // controller: _auth.firstName,
          ),
          const SizedBox(
            height: AppSize.defaultPadding * 1.5,
          ),
          Util.inputField2(
            isExternalLabel: true,
            useExternalText: true,
            isPrefix: false,
            isCompulsory: false,
            fontSizeExternal: 14,
            borderRadius: 5,
            borderColor: AppColors.greyColor,
            bgColor: Colors.white,
            externalText: "Bike licence",
            hint: "Eg:164782522",
            hintColor: Colors.grey,
            externalTextColor: Colors.black,
            prefixIconColor: AppColors.primaryColor,

            // controller: _auth.firstName,
          ),
          const SizedBox(
            height: AppSize.defaultPadding * 1.5,
          ),
          Util.inputField2(
              isExternalLabel: true,
              useExternalText: true,
              isPrefix: false,
              isCompulsory: false,
              enable: false,
              fontSizeExternal: 14,
              borderRadius: 5,
              borderColor: AppColors.greyColor,
              bgColor: Colors.white,
              externalText: "Issue date",
              hint: "20 Aug. 2023",
              hintColor: Colors.grey,
              externalTextColor: Colors.black,
              prefixIconColor: AppColors.primaryColor,
              suffixWidget: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: SvgPicture.asset(
                  Assets.calendar,
                  colorFilter:
                      const ColorFilter.mode(AppColors.dark, BlendMode.srcIn),
                ),
              ),
              onTap: () {}),
          const SizedBox(
            height: AppSize.defaultPadding * 1.5,
          ),
          Util.inputField2(
              isExternalLabel: true,
              useExternalText: true,
              isPrefix: false,
              isCompulsory: false,
              fontSizeExternal: 14,
              borderRadius: 5,
              borderColor: AppColors.greyColor,
              bgColor: Colors.white,
              externalText: "Expiry date",
              hint: "20 Aug. 2025",
              hintColor: Colors.grey,
              externalTextColor: Colors.black,
              prefixIconColor: AppColors.primaryColor,
              suffixWidget: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: SvgPicture.asset(
                  Assets.calendar,
                  colorFilter:
                      const ColorFilter.mode(AppColors.dark, BlendMode.srcIn),
                ),
              ),
              onTap: () {}),
          const SizedBox(
            height: AppSize.defaultPadding * 2,
          ),
          AppButton(
            text: 'Save ',
            onPressed: () async {},
          ),
        ],
      ),
    );
  }
}
