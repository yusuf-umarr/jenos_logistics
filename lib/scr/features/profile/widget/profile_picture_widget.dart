import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jenos/scr/constant/app_assets.dart';
import 'package:jenos/scr/core/util/enums.dart';
import 'package:jenos/scr/core/util/util.dart';
import 'package:jenos/scr/features/onboarding/controller/onboard_controller.dart';
import 'package:jenos/scr/features/profile/controller/personal_info/personal_info_notifier.dart';

class ProfilePictureWidget extends ConsumerStatefulWidget {
  const ProfilePictureWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfilePictureWidget> createState() =>
      _ProfilePictureWidgetState();
}

class _ProfilePictureWidgetState extends ConsumerState<ProfilePictureWidget> {
  File imageUpload = File("");

  var imageFile;

  void selectImages(context, accountType) async {
    print("called 1");
    imageUpload = await Util.myUploadImage();
    imageFile = imageUpload;

    imageFile = imageUpload;

    log("call 2 ${imageFile}");
    setState(() {});

    if (imageFile != null) {
      // log("get called here-----======");

      ref.read(personalInfoNotifier.notifier).uploadProfileImage(
            imageUpload,
            isMerchant: accountType == AccountType.individual,
          );

      // Map image = {"image": imageUpload.path};

      // uploadImage(file: image);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final auth = context.watch<AuthProvider>();
    final accountType = ref.watch(onboardController).accountType;

    final profile = ref.watch(personalInfoNotifier);

    return Stack(
      children: [
        Center(
          child: ClipOval(
            child: SizedBox.fromSize(
              size: const Size.fromRadius(65),
              child: profile.imagePath != null
                  ? Image.network(
                      profile.imagePath!,
                      fit: BoxFit.cover,
                    )
                  : imageFile == null
                      ? Image.asset("assets/images/profileImg.jpg")
                      : Image.file(File(imageUpload.path),
                          // : Image.file(File(auth.imageUpload.path),
                          fit: BoxFit.cover
                          ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 10,
          left: 100,
          child: GestureDetector(
              onTap: () async {
                selectImages(context, accountType);
              },
              child: SvgPicture.asset(Assets.camera)),
        )
      ],
    );
  }
}
