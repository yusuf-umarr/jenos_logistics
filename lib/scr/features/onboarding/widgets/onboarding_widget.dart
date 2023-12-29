// import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class OnboardingWidget extends StatefulWidget {
  final String onboardingImage;
  final String onboardingText1;
  final String onboardingText2;

  const OnboardingWidget({
    required this.onboardingImage,
    required this.onboardingText1,
    required this.onboardingText2,
    Key? key,
  }) : super(key: key);

  @override
  State<OnboardingWidget> createState() => _OnboardingWidgetState();
}

class _OnboardingWidgetState extends State<OnboardingWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                widget.onboardingImage, width: 296, height: 220,
                //fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: Text(
                  widget.onboardingText1,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: SizedBox(
                  // height: uiHelper.getMappedHeight(78),
                  child: Text(
                    widget.onboardingText2,
                    style: Theme.of(context).textTheme.labelMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
