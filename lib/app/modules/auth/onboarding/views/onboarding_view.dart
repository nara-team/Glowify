import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends StatelessWidget {

  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
  final OnboardingController controller = Get.put(OnboardingController());
    return Scaffold(
      backgroundColor: whiteBackground1Color,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.errorMessage.isNotEmpty) {
            return Center(child: Text(controller.errorMessage.value));
          } else if (controller.onboardingItems.isEmpty) {
            return const Center(child: Text("No data available"));
          } else {
            return IntroductionScreen(
              globalBackgroundColor: whiteBackground1Color,
              pages: controller.onboardingItems.map((item) {
                return PageViewModel(
                  title: item.title,
                  body: item.subtitle,
                  image: Center(
                    child: SvgPicture.network(
                      item.imagePath,
                      height: MediaQuery.of(context).size.height * 0.3,
                      fit: BoxFit.cover,
                      placeholderBuilder: (context) => const CircularProgressIndicator(),
                    ),
                  ),
                  decoration: PageDecoration(
                    titleTextStyle: bold.copyWith(
                      fontSize: 22,
                      color: blackColor,
                    ),
                    bodyTextStyle: const TextStyle(
                      fontSize: regularSize,
                      color: blackColor,
                    ),
                    imagePadding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.1),
                    contentMargin: const EdgeInsets.symmetric(horizontal: 16),
                    pageColor: whiteBackground1Color,
                  ),
                );
              }).toList(),
              onDone: () {
                debugPrint('Done button clicked');
                _completeOnboarding();
              },
              onSkip: () {
                _completeOnboarding();
              },
              showSkipButton: true,
              skip: const Text(
                "Skip",
                style: TextStyle(
                  color: abuMedColor,
                  fontSize: mediumSize,
                ),
              ),
              next: const Icon(
                Icons.arrow_forward,
                color: blackColor,
              ),
              done: Text(
                "Selesai",
                style: bold.copyWith(
                  color: blackColor,
                  fontSize: mediumSize,
                ),
              ),
              dotsDecorator: DotsDecorator(
                size: const Size(12.0, 12.0),
                color: abuLightColor,
                activeSize: const Size(24.0, 12.0),
                activeColor: primaryColor,
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                spacing: const EdgeInsets.symmetric(horizontal: 3.0),
              ),
            );
          }
        }),
      ),
    );
  }

  Future<void> _completeOnboarding() async {
    Get.offAllNamed('/login');
  }
}
