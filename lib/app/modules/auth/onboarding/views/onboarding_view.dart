import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/app/theme/sized_theme.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBackground1Color,
      body: Padding(
        padding: PaddingCustom().paddingHorizontal(16),
        child: IntroductionScreen(
          globalBackgroundColor: whiteBackground1Color,
          pages: [
            PageViewModel(
              title: "Deteksi Kesehatan Kulit Wajah",
              body:
                  "Masalah kesehatan kulit wajah dapat dipengaruhi oleh polusi, gaya hidup, dan paparan sinar matahari. Glowify menggunakan teknologi AI untuk mendeteksi kondisi kulit wajah secara akurat.",
              image: Center(
                  child: SvgPicture.asset(
                "assets/images/face_detection_onboard.svg",
                height: MediaQuery.of(context).size.height * 0.3,
                fit: BoxFit.cover,
              )),
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
            ),
            PageViewModel(
              title: "Konsultasi Profesional",
              body:
                  "Jika ada masalah terdeteksi, Anda dapat langsung berkonsultasi dengan dokter kulit profesional melalui platform kami. Glowify mempermudah akses ke perawatan kulit yang berkualitas.",
              image: Center(
                  child: SvgPicture.asset(
                "assets/images/konsultasi_dokter_onboard.svg",
                height: MediaQuery.of(context).size.height * 0.3,
                fit: BoxFit.cover,
              )),
              decoration: PageDecoration(
                titleTextStyle: bold.copyWith(fontSize: 22, color: blackColor),
                bodyTextStyle: const TextStyle(
                  fontSize: regularSize,
                  color: blackColor,
                ),
                imagePadding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1),
                contentMargin: const EdgeInsets.symmetric(horizontal: 16),
                pageColor: whiteBackground1Color,
              ),
            ),
            PageViewModel(
              title: "Teknologi Canggih",
              body:
                  "Glowify memanfaatkan algoritma deep learning untuk analisis citra kulit wajah. Dengan akurasi deteksi sebesar 90%, aplikasi ini menjamin hasil yang andal untuk perawatan kulit Anda.",
              image: Center(
                  child: Image.asset(
                "assets/images/onboarding_3.jpg",
                height: MediaQuery.of(context).size.height * 0.3,
                fit: BoxFit.cover,
              )),
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
