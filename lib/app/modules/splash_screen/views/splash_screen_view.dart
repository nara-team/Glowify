import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:page_transition/page_transition.dart';

import 'package:get/get.dart';
import 'package:glowify/app/modules/login/views/login_view.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Image.asset(
          imgPath('logotext3x.png'),
        ),
        backgroundColor: Colors.white,
        duration: 1500,
        pageTransitionType: PageTransitionType.fade,
        nextScreen: const LoginView());
  }
}
