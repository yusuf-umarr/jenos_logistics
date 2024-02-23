import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jenos/scr/common_widgets/appbbutton.dart';
import 'package:jenos/scr/common_widgets/custom_widget.dart';
import 'package:jenos/scr/constant/app_assets.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/constant/app_size.dart';
import 'package:jenos/scr/core/util/util.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  File? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidget.customAppbar(context,
          title: "Change password", isArrow: true),
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
            externalText: "Old password",
            hint: "*******",
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
            externalText: "New password",
            hint: "******",
            hintColor: Colors.grey,
            externalTextColor: Colors.black,
            prefixIconColor: AppColors.primaryColor,

            // controller: _auth.firstName,
          ),
          const SizedBox(
            height: AppSize.defaultPadding / 2,
          ),
          Text(
            "Must be a minimum of 8 characters long, and must contain at least one special character, at least one uppercase letter and at least one numerical digit.",
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontWeight: FontWeight.w500, color: AppColors.grey),
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
            externalText: "Confirm new password",
            hint: "******",
            hintColor: Colors.grey,
            externalTextColor: Colors.black,
            prefixIconColor: AppColors.primaryColor,
          ),
          const SizedBox(
            height: AppSize.defaultPadding * 1.5,
          ),
          const SizedBox(
            height: AppSize.defaultPadding * 2,
          ),
          AppButton(
            text: 'Update password',
            onPressed: () async {},
          ),
        ],
      ),
    );
  }
}
