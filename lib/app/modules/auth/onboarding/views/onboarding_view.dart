import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: "Deteksi Kesehatan Kulit Wajah",
              body:
                  "Masalah kesehatan kulit wajah dapat dipengaruhi oleh polusi, gaya hidup, dan paparan sinar matahari. Glowify menggunakan teknologi AI untuk mendeteksi kondisi kulit wajah secara akurat.",
              image: Center(
                  child: Image.asset(
                "assets/images/onboard_1.jpg",
                height: MediaQuery.of(context).size.height * 0.3,
                fit: BoxFit.cover,
              )),
              decoration: PageDecoration(
                titleTextStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                bodyTextStyle:
                    const TextStyle(fontSize: 14, color: Colors.black54),
                imagePadding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1),
                contentMargin: const EdgeInsets.symmetric(horizontal: 16),
                pageColor: Colors.white, // Set background color for this page
              ),
            ),
            PageViewModel(
              title: "Konsultasi Profesional",
              body:
                  "Jika ada masalah terdeteksi, Anda dapat langsung berkonsultasi dengan dokter kulit profesional melalui platform kami. Glowify mempermudah akses ke perawatan kulit yang berkualitas.",
              image: Center(
                  child: Image.asset(
                "assets/images/onboard_2.jpg",
                height: MediaQuery.of(context).size.height * 0.3,
                fit: BoxFit.cover,
              )),
              decoration: PageDecoration(
                titleTextStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                bodyTextStyle:
                    const TextStyle(fontSize: 14, color: Colors.black54),
                imagePadding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1),
                contentMargin: const EdgeInsets.symmetric(horizontal: 16),
                pageColor: Colors.white, // Set background color for this page
              ),
            ),
            PageViewModel(
              title: "Teknologi Canggih",
              body:
                  "Glowify memanfaatkan algoritma deep learning untuk analisis citra kulit wajah. Dengan akurasi deteksi sebesar 90%, aplikasi ini menjamin hasil yang andal untuk perawatan kulit Anda.",
              image: Center(
                  child: Image.asset(
                "assets/images/onboard_3.jpg",
                height: MediaQuery.of(context).size.height * 0.3,
                fit: BoxFit.cover,
              )),
              decoration: PageDecoration(
                titleTextStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                bodyTextStyle:
                    const TextStyle(fontSize: 14, color: Colors.black54),
                imagePadding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1),
                contentMargin: const EdgeInsets.symmetric(horizontal: 16),
                pageColor: Colors.white, // Set background color for this page
              ),
            ),
          ],
          onDone: () {
            debugPrint('Done button clicked');
            _completeOnboarding();
          },
          onSkip: () {
            _completeOnboarding();
          },
          showSkipButton: true,
          skip: Text(
            "Skip",
            style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
          ),
          next: Icon(
            Icons.arrow_forward,
            color: Colors.black87,
          ),
          done: Text(
            "Selesai",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontSize: 16),
          ),
          dotsDecorator: DotsDecorator(
            size: const Size(12.0, 12.0),
            color: Colors.grey.shade300,
            activeSize: const Size(24.0, 12.0),
            activeColor: primaryColor,
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          ),
        ),
      ),
    );
  }

  Future<void> _completeOnboarding() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('hasCompletedOnboarding', true);
      Get.offAllNamed('/login');
    } catch (e) {
      debugPrint('Error during navigation: $e');
    }
  }
}
