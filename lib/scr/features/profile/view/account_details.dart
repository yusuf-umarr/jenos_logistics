import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/common_widgets/appbbutton.dart';
import 'package:jenos/scr/common_widgets/custom_widget.dart';
import 'package:jenos/scr/constant/app_size.dart';
import 'package:jenos/scr/core/util/enums.dart';
import 'package:jenos/scr/core/util/util.dart';
import 'package:jenos/scr/features/profile/controller/user_profile/profile_controller.dart';

class AccountDetails extends ConsumerStatefulWidget {
  const AccountDetails({super.key});

  @override
  ConsumerState<AccountDetails> createState() => _AccountDetailsState();
}

class _AccountDetailsState extends ConsumerState<AccountDetails> {
  final _rkey = GlobalKey<FormState>();

  File? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidget.customAppbar(context,
          title: "Account details", isArrow: true),
      body: Form(
        key: _rkey,
        child: ListView(
          padding: const EdgeInsets.all(AppSize.defaultPadding),
          children: [
            const SizedBox(
              height: AppSize.defaultPadding,
            ),
            Util.inputField2(
              externalText: "Bank name",
              hint: "Eg. Union bank",
              controller: ref.watch(profileController).bankNameController,
              validator: Util.validateName,
            ),
            const SizedBox(
              height: AppSize.defaultPadding * 1.5,
            ),
            Util.inputField2(
              externalText: "Account name",
              hint: "Adamu john",
              controller: ref.watch(profileController).acctNameController,
              validator: Util.validateName,
            ),
            const SizedBox(
              height: AppSize.defaultPadding * 1.5,
            ),
            Util.inputField2(
              externalText: "Account number",
              hint: "Eg:164782522",
              controller: ref.watch(profileController).acctNumberController,
              validator: Util.validateName,
            ),
            const SizedBox(
              height: AppSize.defaultPadding * 1.5,
            ),
            const SizedBox(
              height: AppSize.defaultPadding * 2,
            ),
            Consumer(builder: (context, ref, _) {
              final loadState = ref.watch(profileController).loadState;
              return AppButton(
                isLoading: loadState == NetworkState.loading,
                text: 'Save ',
                onPressed: () async {
                  if (_rkey.currentState!.validate()) {
                    ref.read(profileController.notifier).updateBankDetails(
                        ref.watch(profileController).bankNameController.text,
                        ref.watch(profileController).acctNumberController.text,
                        ref.watch(profileController).acctNameController.text,
                        context);
                  }
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
