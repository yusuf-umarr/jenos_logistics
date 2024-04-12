import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/common_widgets/appbbutton.dart';
import 'package:jenos/scr/common_widgets/custom_widget.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/constant/app_size.dart';
import 'package:jenos/scr/core/util/enums.dart';
import 'package:jenos/scr/core/util/util.dart';
import 'package:jenos/scr/features/profile/controller/user_profile/profile_controller.dart';
import 'package:jenos/scr/features/profile/controller/user_profile/profile_state.dart';

class ContactService extends StatefulWidget {
  const ContactService({super.key});

  @override
  State<ContactService> createState() => _ContactServiceState();
}

class _ContactServiceState extends State<ContactService> {
  final _rkey = GlobalKey<FormState>();

  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();

    super.dispose();
  }

  File? image;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Consumer(builder: (context, ref, _) {
      ref.listen<ProfileState>(profileController, (prev, state) {
        if (state.loadState == NetworkState.error) {
          Util.showSnackBar(
            context,
            state.message.toString(),
            color: Colors.red,
          );
        } else if (state.loadState == NetworkState.success) {
          Util.showSnackBar(
            context,
            "Done",
            color: AppColors.primaryColor,
          );

          Timer(const Duration(seconds: 3), () {
            ref.read(profileController.notifier).getUserData();

            Navigator.of(context).pop();
          });
        }
      });
      return Scaffold(
        appBar: CustomWidget.customAppbar(context,
            title: "Contact service", isArrow: true),
        body: Form(
          key: _rkey,
          child: ListView(
            padding: const EdgeInsets.all(AppSize.defaultPadding),
            children: [
              const SizedBox(
                height: AppSize.defaultPadding,
              ),
              Util.inputField2(
                externalText: "Name",
                hint: "",
                controller: ref.watch(profileController).nameController,
                validator: (val) {
                  if (val!.isEmpty) {
                    return '*This field is required';
                  }
                  return null;
                },
                isIcon: true,
              ),
              const SizedBox(
                height: AppSize.defaultPadding * 1.5,
              ),
              Util.inputField2(
                externalText: "Email",
                hint: "",
                controller: ref.watch(profileController).emailController,
                validator: (val) {
                  if (val!.isEmpty) {
                    return '*This field is required';
                  }
                  return null;
                },
                isIcon: true,
              ),
              const SizedBox(
                height: AppSize.defaultPadding * 1.5,
              ),
              Util.inputField2(
                max: 5,
                externalText: "Message",
                hint: "Type here...",
                controller: _messageController,
                validator: (val) {
                  if (val!.isEmpty) {
                    return '*This field is required';
                  }
                  return null;
                },
                isIcon: true,
              ),
              const SizedBox(
                height: AppSize.defaultPadding * 1.5,
              ),
              const SizedBox(
                height: AppSize.defaultPadding * 2,
              ),
              Consumer(builder: (context, ref, _) {
                final loadState = ref.watch(profileController).loadState;

                final personalNotifier = ref.read(profileController.notifier);

                //loadState: NetworkState.loading
                return AppButton(
                  isLoading: loadState == NetworkState.loading,
                  text: 'Proceed',
                  onPressed: () async {
                    FocusScope.of(context).unfocus();

                    if (_rkey.currentState!.validate()) {
                      personalNotifier.conatctSerivce(_messageController.text);

                     
                    }
                    // navigate(context, const SignInPage());
                  },
                );
              }),
            ],
          ),
        ),
      );
    });
  }
}
