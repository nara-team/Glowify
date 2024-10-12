import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/app/modules/auth/onboarding/views/onboarding_view.dart';
import 'package:glowify/app/modules/navbar/views/navbar_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenController extends GetxController {}

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
