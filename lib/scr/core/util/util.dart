import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jenos/scr/constant/app_colors.dart';

File imageUpload = File("");

class Util {
  static Widget inputField2({
    String? hint,
    IconData? icon,
    IconData? prefixIcon,
    bool isIcon = false,
    bool isPrefix = false,
    bool isExternalLabel = true,
    bool readOnly = false,
    bool enable = true,
    double? size,
    double fontSize = 13,
    double fontSizeExternal = 14,
    TextEditingController? controller,
    TextInputType inputType = TextInputType.text,
    double borderRadius = 5,
    bool isPassword = false,
    double marginLeft = 5,
    double paddingLeft = 10,
    double paddingRight = 15,
    TextAlign textAlign = TextAlign.start,
    double prefixIconSize = 20,
    double suffixIconSize = 20,
    Color prefixIconColor = AppColors.primaryColor,
    Color suffixIconColor = const Color(0xff22004E),
    bool isInputFrame = true,
    int max = 1,
    bool useExternalText = true,
    String externalText = "",
    String readOnlyText = "",
    double externalTextBottomMargin = 5,
    double inputFieldPadding = 0,
    Function(String val)? onChanged,
    Function()? onSuffixIconClick,
    Function()? onTap,
    bool hasBorder = true,
    Color borderColor = const Color(0xffD9D9D9),
    double elevation = 0,
    Color bgColor = Colors.white,
    Color externalTextColor = Colors.black,
    bool isCompulsory = false,
    String compulsoryText = "*",
    Color compulsoryColor = Colors.red,
    double compulsoryFontSize = 16,
    bool isDropDown = false,
    List<String> dropDownList = const ['Select'],
    Color readOnlyTextColor = Colors.black54,
    FontWeight readOnlyFontWeight = FontWeight.w400,
    EdgeInsets readOnlyPadding =
        const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    Widget? suffixWidget,
    Color hintColor = Colors.grey,
    FontWeight hintFont = FontWeight.w400,
    double hintFontSize = 13,
    dynamic validator,
    void Function(dynamic)? dropDownOnChanged,
    Function()? onClick,
    bool isDropDownSearch = true,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        isExternalLabel
            ? Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: marginLeft),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: FittedBox(
                          alignment: Alignment.centerLeft,
                          fit: BoxFit.scaleDown,
                          child: Text(
                            useExternalText ? externalText : hint!,
                            style: TextStyle(
                              color: externalTextColor,
                              fontSize: fontSizeExternal,
                            ),
                          )),
                    ),
                    isCompulsory
                        ? Text(
                            compulsoryText,
                            style: TextStyle(
                              color: compulsoryColor,
                              fontSize: compulsoryFontSize,
                            ),
                          )
                        : const SizedBox(height: 0, width: 0)
                  ],
                ),
              )
            : const SizedBox(
                height: 0,
                width: 0,
              ),
        isExternalLabel
            ? SizedBox(
                height: externalTextBottomMargin,
              )
            : const SizedBox(
                height: 0,
                width: 0,
              ),
        Container(
          decoration: hasBorder
              ? BoxDecoration(
                  border: Border.all(color: borderColor, width: 0.3),
                  borderRadius: BorderRadius.circular(borderRadius),
                  color: bgColor,
                )
              : const BoxDecoration(),
          child: Padding(
            padding: EdgeInsets.all(inputFieldPadding),
            child: Material(
              elevation: elevation,
              borderRadius: BorderRadius.circular(borderRadius),
              color: bgColor,
              child: Row(
                children: [
                  isPrefix
                      ? InkWell(
                          onTap: onClick,
                          child: Container(
                            margin: const EdgeInsets.only(
                              left: 10,
                            ),
                            //color: bgColor,
                            child: InkWell(
                              onTap: onClick,
                              child: Icon(
                                prefixIcon,
                                color: prefixIconColor,
                                size: prefixIconSize,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(
                          width: 5,
                        ),
                  Expanded(
                    child: GestureDetector(
                      onTap: onTap,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: paddingLeft, right: paddingRight),
                        decoration: BoxDecoration(
                          // border: Border.all(width: 1, color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(borderRadius),
                          //color: bgColor,
                        ),
                        child: SizedBox(
                          width: size,
                          child: TextFormField(
                            // onTap: onTap,
                            enabled: enable,
                            obscureText: isPassword,
                            controller: controller,
                            keyboardType: inputType,
                            textAlign: textAlign,
                            readOnly: readOnly,
                            onChanged: onChanged,
                            validator: validator,
                            maxLines: max,
                            style: TextStyle(
                                fontSize: fontSize, color: Colors.black87),
                            decoration: InputDecoration(
                              hintText: isExternalLabel
                                  ? useExternalText
                                      ? hint
                                      : ""
                                  : hint,
                              hintStyle: TextStyle(
                                color: hintColor,
                                fontWeight: hintFont,
                                fontSize: hintFontSize,
                              ),
                              suffixIconConstraints: isIcon
                                  ? const BoxConstraints(
                                      maxWidth: 50,
                                    )
                                  : const BoxConstraints(maxWidth: 26),
                              suffixIcon: InkWell(
                                onTap: onSuffixIconClick,
                                child: isIcon
                                    ? Icon(
                                        icon,
                                        color: suffixIconColor,
                                        size: suffixIconSize,
                                      )
                                    : const SizedBox(
                                        width: 0,
                                        height: 0,
                                      ),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: suffixWidget ??
                        const SizedBox(
                          width: 0,
                          height: 0,
                        ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  static showSnackBar(BuildContext context, String text,
      {color = AppColors.primaryColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  static getSingleMerchant(List data, String userId) {
    var merchant;
    for (var ele in data) {
      if (userId == ele["_id"]) {
        // log("user found ${ele}");

        merchant = ele;
      }
    }

    return merchant;
  }

  static Future<File> myUploadImage() async {
    final imagePicker = ImagePicker();
    XFile? image;

    var file = File("");

    image = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 25);

    if (image != null) {
      file = File(image!.path);
    }

    try {
      return file;
    } catch (e) {
      return File("");
    }
  }

  static showFormattedTime(String dateTimeString, context) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    dateTime = dateTime.toLocal();

    String formattedDateTime = DateFormat("h:mma").format(dateTime);
    String formattedDate = DateFormat.yMMMd().format(dateTime);

    String today = DateFormat.yMMMd().format(DateTime.now());
    String dateText = formattedDate == today ? 'Today' : formattedDate;

    return Text(
      '$dateText, $formattedDateTime',
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.greyColor,
            fontSize: 10,
          ),
    );
  }

  // //02 Nov. 2023
  static showFormattedTimeString(String dateTimeString, context) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    dateTime = dateTime.toLocal();

    String formattedDateTime = DateFormat("h:mma").format(dateTime);
    String formattedDate = DateFormat.yMMMd().format(dateTime);

    String today = DateFormat.yMMMd().format(DateTime.now());
    String dateText = formattedDate == today ? 'Today' : formattedDate;

    return '$dateText, $formattedDateTime';
  }

  static showFormattedTimeVal(String dateTimeString, context) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    dateTime = dateTime.toLocal();

    String formattedDateTime = DateFormat("h:mma").format(dateTime);

    return formattedDateTime;
  }

  static showFormattedDateString(String dateTimeString, context) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    dateTime = dateTime.toLocal();

    String formattedDate =
        DateFormat("dd MMM. yyyy").format(dateTime); // Adjusted date format

    String today = DateFormat.yMMMd().format(DateTime.now());
    String dateText = formattedDate == today ? 'Today' : formattedDate;

    return dateText;
  }

  static String? validateName(value) {
    if (value == null || value.isEmpty) {
      return '*This field is required';
    }
    return null;
  }

  static Widget cardBtn({
    String title = "View Detail",
    Color textColor = AppColors.white,
    Color bgColor = AppColors.primaryColor,
    Function()? onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          width: 133,
          decoration: BoxDecoration(
              color: bgColor,
              border: Border.all(color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }

  static FutureBuilder<dynamic> customFuturBuilder(ref, child) {
    return FutureBuilder<dynamic>(
      future: ref,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData || snapshot.data != null) {
          return child;
        } else {
          return const SizedBox();

          // Placeholder when there are no loans
        }
      },
    );
  }

    static formatTimeAgo(time) {
    DateTime dateTime = DateTime.parse(time);

    DateTime now = DateTime.now();

    Duration difference = now.difference(dateTime);

    if (difference.inDays >= 7) {
      return 'a week ago';
    } else if (difference.inDays >= 1) {
      return " day ago";
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} hour ago';
    } else {
      int minutesDifference = difference.inMinutes;

      String formattedTimeDifference = '$minutesDifference min. ago';

      return formattedTimeDifference;
    }
  }

    static callNumber(number) async {
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }

}
