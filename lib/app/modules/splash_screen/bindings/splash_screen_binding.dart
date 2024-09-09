import 'package:get/get.dart';
import 'package:glowify/app/modules/navbar/controllers/navbar_controller.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashScreenController>(
      () => SplashScreenController(),
    );
    Get.lazyPut<NavbarController>(
      () => NavbarController(),
    );
  }
}
