import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jenos/scr/common_widgets/appbbutton.dart';
import 'package:jenos/scr/common_widgets/custom_widget.dart';
import 'package:jenos/scr/constant/app_assets.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/constant/app_size.dart';
import 'package:jenos/scr/core/util/util.dart';

class AccountDetails extends StatefulWidget {
  const AccountDetails({super.key});

  @override
  State<AccountDetails> createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  File? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidget.customAppbar(context,
          title: "Account details", isArrow: true),
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
            fontSizeExternal: 14,
            borderRadius: 5,
            borderColor: AppColors.greyColor,
            bgColor: Colors.white,
            externalText: "Bank name",
            hint: "Eg. Union bank",
            hintColor: Colors.grey,
            externalTextColor: Colors.black,
            prefixIconColor: AppColors.primaryColor,
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
            externalText: "Account name",
            hint: "Adamu john",
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
            externalText: "Account number",
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
              externalText: "Account type",
              hint: "Saving",
              hintColor: Colors.grey,
              externalTextColor: Colors.black,
              prefixIconColor: AppColors.primaryColor,
              suffixWidget: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: SvgPicture.asset(
                  Assets.chevronDown,
                  colorFilter:
                      const ColorFilter.mode(AppColors.dark, BlendMode.srcIn),
                ),
              ),
              onTap: () {},
              ),
          const SizedBox(
            height: AppSize.defaultPadding * 2,
          ),
          AppButton(
            text: 'Update details',
            onPressed: () async {},
          ),
        ],
      ),
    );
  }
}
