import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jenos/scr/constant/app_colors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final double? width;
  final double? height;
  final double? fontSize;
  final bool? hasImage;
  final bool isIcon;
  final IconData? icon;
  final String? imagePath;
  final BorderRadius? borderRadius;
  final bool isLoading;
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.textColor,
    this.borderColor,
    this.width,
    this.icon,
    this.height,
    this.hasImage = false,
    this.isIcon = false,
    this.imagePath,
    this.borderRadius,
    this.fontSize,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return MaterialButton(
      color: color ?? AppColors.primaryColor,
      onPressed: onPressed,
      minWidth: size.width,
      height: height ?? 55,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(15),
        side: BorderSide(color: borderColor ?? Colors.transparent),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 10,
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Text(
                    text,
                    style: GoogleFonts.poppins(
                        color: textColor ?? AppColors.white,
                        fontSize: fontSize ?? 15),
                  ),
            isIcon
                ? const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 18,
                  )
                : const SizedBox(width: 10),
          ],
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
