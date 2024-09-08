import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:page_transition/page_transition.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:glowify/app/modules/navbar/views/navbar_view.dart';
import 'package:glowify/app/modules/onboarding/views/onboarding_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              child: Image.asset(
                'assets/images/GLOWIFY.png',
                height: 150,
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Made With',
                  style: TextStyle(
                    fontSize: 16,
                    color: whiteBackground1Color,
                  ),
                ),
                Text(
                  'Nara team',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: whiteBackground1Color,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
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

class SplashRedirectView extends StatelessWidget {
  const SplashRedirectView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkOnboardingStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.data == true) {
            return const NavbarView();
          } else {
            return const OnboardingView();
          }
        }
      },
    );
  }

  Future<bool> _checkOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? hasCompletedOnboarding = prefs.getBool('hasCompletedOnboarding');

    if (hasCompletedOnboarding == null || hasCompletedOnboarding == false) {
      return false;
    }

    User? user = FirebaseAuth.instance.currentUser;
    return user != null;
  }
}
