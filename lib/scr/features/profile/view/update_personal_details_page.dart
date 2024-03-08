import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jenos/scr/common_widgets/appbbutton.dart';
import 'package:jenos/scr/common_widgets/custom_widget.dart';
import 'package:jenos/scr/constant/app_assets.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/constant/app_size.dart';
import 'package:jenos/scr/core/util/enums.dart';
import 'package:jenos/scr/core/util/flush_bar.dart';
import 'package:jenos/scr/core/util/util.dart';
import 'package:jenos/scr/features/profile/controller/user_profile/pprofile_controller.dart';
import 'package:jenos/scr/features/profile/controller/user_profile/profile_state.dart';
import 'package:jenos/scr/features/profile/widget/profile_picture_widget.dart';

class UpdatePersonalDetailPage extends ConsumerStatefulWidget {
  const UpdatePersonalDetailPage({super.key});

  @override
  ConsumerState<UpdatePersonalDetailPage> createState() =>
      _UpdatePersonalDetailPageState();
}

class _UpdatePersonalDetailPageState
    extends ConsumerState<UpdatePersonalDetailPage> {
  File? image;
  @override
  Widget build(BuildContext context) {
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
            state.message.toString(),
            color: Colors.green,
          );

          Timer(const Duration(seconds: 3), () {
            ref.read(profileController.notifier).getUserData();

            Navigator.of(context).pop();
          });
        }
      });
      return Scaffold(
        appBar: CustomWidget.customAppbar(context,
            title: "Personal details", isArrow: true),
        body: ListView(
          padding: const EdgeInsets.all(AppSize.defaultPadding),
          children: [
            // Stack(
            //   children: [
            //     Center(
            //       child: ClipOval(
            //         child: SizedBox.fromSize(
            //           size: const Size.fromRadius(65),
            //           child: image == null
            //               ? Image.asset("assets/images/profilePics.png")
            //               : Image.file(File(image!.path), fit: BoxFit.cover),
            //         ),
            //       ),
            //     ),
            //     Positioned(
            //       right: 0,
            //       bottom: 10,
            //       left: 100,
            //       child: GestureDetector(
            //           onTap: () async {},
            //           child: Container(
            //               height: 40,
            //               width: 40,
            //               padding: const EdgeInsets.all(10),
            //               decoration: const BoxDecoration(
            //                   shape: BoxShape.circle, color: AppColors.white),
            //               child: SvgPicture.asset(Assets.camera))),
            //     )
            //   ],
            // ),

            ProfilePictureWidget(),
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
              externalText: "Full name",
              hint: "John obi",
              hintColor: Colors.grey,
              externalTextColor: Colors.black,
              prefixIconColor: AppColors.primaryColor,
              controller: ref.watch(profileController).nameController,
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
              externalText: "Phone number",
              hint: "Eg:09064782522",
              hintColor: Colors.grey,
              externalTextColor: Colors.black,
              prefixIconColor: AppColors.primaryColor,
              controller: ref.watch(profileController).phoneController,
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
              externalText: "Address",
              hint: "Nweke rd, lagos state",
              hintColor: Colors.grey,
              externalTextColor: Colors.black,
              prefixIconColor: AppColors.primaryColor,
              controller: ref.watch(profileController).addrController,
              // controller: _auth.firstName,
            ),
            const SizedBox(
              height: AppSize.defaultPadding * 3,
            ),
            Consumer(builder: (context, ref, _) {
              final loadState = ref.watch(profileController).loadState;
              return AppButton(
                isLoading: loadState == NetworkState.loading,
                text: 'Update profile ',
                onPressed: () async {
                  ref.read(profileController.notifier).updateProfile(
                        ref.watch(profileController).nameController.text,
                        ref.watch(profileController).phoneController.text,
                        ref.watch(profileController).addrController.text,
                      );
                },
              );
            }),
          ],
        ),
      );
    });
  }
}
