import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final Color? borderColor;
  final double? width;
  final double? height;
  final double? fontSize;
  final bool? hasImage;
  final bool? isIcon;
  final IconData? icon;
  final String? imagePath;
  final BorderRadius? borderRadius;
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
    required this.textColor,
    this.borderColor,
    this.width,
    this.icon,
    this.height,
    this.hasImage = false,
    this.isIcon = false,
    this.imagePath,
    this.borderRadius,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return MaterialButton(
      color: color,
      onPressed: onPressed,
      minWidth: size.width,
      height: height,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(25),
        side: BorderSide(color: borderColor ?? Colors.transparent),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: hasImage == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isIcon == true
                      ? Icon(
                          icon,
                          size: 20,
                          color: Colors.white,
                        )
                      : SvgPicture.asset(
                          imagePath ?? "",
                          width: 20,
                          height: 20,
                        ),
                  const SizedBox(width: 10),
                  Text(
                    text,
                    style: GoogleFonts.poppins(
                        color: textColor, fontSize: fontSize ?? 16),
                  ),
                ],
              )
            : Text(
                text,
                style: GoogleFonts.poppins(
                    color: textColor, fontSize: fontSize ?? 16),
              ),
      ),
    );
  }
}

class LoadingButton extends StatelessWidget {
  final BorderRadius? borderRadius;
  final Color color;
  final double? width;
  final double? height;
  final Color? borderColor;

  const LoadingButton({
    super.key,
    this.borderRadius,
    required this.color,
    this.width,
    this.height,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: color,
      onPressed: () {},
      minWidth: width,
      height: height,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(30),
        side: BorderSide(color: borderColor ?? Colors.transparent),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(color),
        ),
      ),
    );
  }
}
