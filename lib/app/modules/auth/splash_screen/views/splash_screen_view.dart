import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:page_transition/page_transition.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AnimatedSplashScreen(
      duration: 1500,
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 6,
            child: Center(
              child: SvgPicture.asset(
                'assets/images/GLOWIFY.svg',
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Made With',
                  style: bold.copyWith(
                    fontSize: mediumSize,
                    color: whiteBackground1Color,
                  ),
                ),
                Text(
                  'Nara team',
                  style: regular.copyWith(
                    fontSize: mediumSize,
                    color: whiteBackground1Color,
                  ),
                ),
              ],
            ),
          ),
          const Gap(30),
        ],
      ),
      backgroundColor: primaryColor,
      splashIconSize: double.infinity,
      nextScreen: const SplashRedirectView(),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
    );
  }
}
