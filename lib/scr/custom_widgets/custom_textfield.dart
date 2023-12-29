import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    required this.icon,
    required this.prefixIcon,
    required this.isIcon,
    required this.isPrefix,
    required this.isExternalLabel,
    required this.readOnly,
    required this.size,
    required this.fontSize,
    required this.fontSizeExternal,
    required this.controller,
    required this.inputType,
    required this.borderRadius,
    required this.isPassword,
    required this.marginLeft,
    required this.paddingLeft,
    required this.paddingRight,
    required this.textAlign,
    required this.prefixIconSize,
    required this.suffixIconSize,
    required this.prefixIconColor,
    required this.suffixIconColor,
    required this.isInputFrame,
    required this.max,
    required this.useExternalText,
    required this.externalText,
    required this.readOnlyText,
    required this.externalTextBottomMargin,
    required this.inputFieldPadding,
    required this.onChanged,
    required this.onSuffixIconClick,
    required this.hasBorder,
    required this.borderColor,
    required this.elevation,
    required this.bgColor,
    required this.externalTextColor,
    required this.isCompulsory,
    required this.compulsoryText,
    required this.compulsoryColor,
    required this.compulsoryFontSize,
    required this.isDropDown,
    required this.dropDownList,
    required this.readOnlyTextColor,
    required this.readOnlyFontWeight,
    required this.readOnlyPadding,
    required this.suffixWidget,
    required this.hintColor,
    required this.hintFont,
    required this.hintFontSize,
    required this.validator,
    required this.dropDownOnChanged,
    required this.onClick,
    required this.isDropDownSearch,
  });

  final String? hint;
  final IconData? icon;
  final IconData? prefixIcon;
  final bool isIcon;
  final bool isPrefix;
  final bool isExternalLabel;
  final bool readOnly;
  final double? size;
  final double fontSize;
  final double fontSizeExternal;
  final TextEditingController? controller;
  final TextInputType inputType;
  final double borderRadius;
  final bool isPassword;
  final double marginLeft;
  final double paddingLeft;
  final double paddingRight;
  final TextAlign textAlign;
  final double prefixIconSize;
  final double suffixIconSize;
  final Color prefixIconColor;
  final Color suffixIconColor;
  final bool isInputFrame;
  final int max;
  final bool useExternalText;
  final String externalText;
  final String readOnlyText;
  final double externalTextBottomMargin;
  final double inputFieldPadding;
  final Function(String val)? onChanged;
  final Function()? onSuffixIconClick;
  final bool hasBorder;
  final Color borderColor;
  final double elevation;
  final Color bgColor;
  final Color externalTextColor;
  final bool isCompulsory;
  final String compulsoryText;
  final Color compulsoryColor;
  final double compulsoryFontSize;
  final bool isDropDown;
  final List<String> dropDownList;
  final Color readOnlyTextColor;
  final FontWeight readOnlyFontWeight;
  final EdgeInsets readOnlyPadding;
  final Widget? suffixWidget;
  final Color hintColor;
  final FontWeight hintFont;
  final double hintFontSize;
  final dynamic validator;
  final void Function(dynamic p1)? dropDownOnChanged;
  final Function()? onClick;
  final bool isDropDownSearch;

  @override
  Widget build(BuildContext context) {
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
                         style: TextStyle(color: externalTextColor, fontSize: fontSizeExternal,),
                        
                        ),
                      ),
                    ),
                    isCompulsory
                        ?
                        Text(
                         compulsoryText,
                         style: TextStyle(color: compulsoryColor, fontSize: compulsoryFontSize,),
                        
                        )
                        
                        
                        //  TextView(
                        //     text: compulsoryText,
                        //     fontSize: compulsoryFontSize,
                        //     txtColor: compulsoryColor,
                        //   )
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
                        child: readOnly
                            ? InkWell(
                                onTap: onClick,
                                child: Container(
                                  padding: readOnlyPadding,
                                  alignment: Alignment.centerLeft,
                                  child:    Text(
                         readOnlyText,
                         maxLines: 5,
                         style: TextStyle(color: readOnlyTextColor, fontSize: fontSize, fontWeight: readOnlyFontWeight,),
                        
                        )
                                  
                                  // TextView(
                                  //   text: readOnlyText,
                                  //   fontSize: fontSize,
                                  //   txtColor: readOnlyTextColor,
                                  //   fontWeight: readOnlyFontWeight,
                                  //   maxLine: 5,
                                  // ),
                                ),
                              )
                            : TextFormField(
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
                  suffixWidget ??
                      const SizedBox(
                        width: 0,
                        height: 0,
                      )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
