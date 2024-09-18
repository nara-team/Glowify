import 'package:get/get.dart';
import 'package:glowify/app/modules/auth/login/controllers/login_controller.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingController>(
      () => OnboardingController(),
    );
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
  }
}
