import 'package:flutter/material.dart';
import 'package:jenos/scr/constant/app_assets.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/constant/app_size.dart';
import 'package:jenos/scr/common_widgets/navigation.dart';
import 'package:jenos/scr/features/auth/pages/signup_page.dart';
import 'package:jenos/scr/features/onboarding/screens/get_started_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widgets/onboarding_widget.dart';

class OnboardingMainScreen extends StatefulWidget {
  const OnboardingMainScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingMainScreen> createState() => _OnboardingMainScreenState();
}

class _OnboardingMainScreenState extends State<OnboardingMainScreen> {
  final controller = PageController(initialPage: 0);
  int currentIndex = 0;
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSize.defaultPadding / 2),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      navigate(context, const GetStartedScreen());
                    },
                    child: Text(
                      "Skip",
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 500,
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  controller: controller,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                      isLastPage = index == 2;
                    });
                  },
                  children: pages,
                ),
              ),

              Center(
                child: SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    axisDirection: Axis.horizontal,
                    effect: ExpandingDotsEffect(
                        dotHeight: 8,
                        radius: 8,
                        dotWidth: 8,
                        activeDotColor: AppColors.primaryColor,
                        dotColor: AppColors.greyColor.withOpacity(0.3),
                        paintStyle: PaintingStyle.fill)),
              ),
              const SizedBox(
                height: 60,
              ),
              //Spacer(),

              GestureDetector(
                onTap: () {
                  isLastPage
                      ? Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GetStartedScreen()))
                      : controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: AppColors.white,
                    size: 25,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> pages = <Widget>[
    const OnboardingWidget(
      onboardingImage: Assets.onBoardOne,
      onboardingText1: "Navigate Logistics, Simplify Success",
      onboardingText2:
          'Empowering businesses through smart logistics - your path to efficient supply chain management.',
    ),
    const OnboardingWidget(
      onboardingImage: Assets.onBoardTwo,
      onboardingText1: 'Delivering Efficiency,One Tap at a Time.',
      onboardingText2:
          'Welcome aboard! Experience the future of logistics management, right at your fingertips.',
    ),
    const OnboardingWidget(
        onboardingImage: Assets.onBoardThree,
        onboardingText1: 'Seamless Shipments,Effortless Solutions.',
        onboardingText2:
            'Your journey begins here with our intuitive logistics management app.'),
  ];
}
