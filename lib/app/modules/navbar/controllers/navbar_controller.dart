import 'package:get/get.dart';
import 'package:glowify/app/modules/beranda/controllers/beranda_controller.dart';
import 'package:glowify/app/modules/profil/controllers/profil_controller.dart';
import 'package:glowify/app/modules/tutorial/controllers/tutorial_controller.dart';

class NavbarController extends GetxController {
  var tabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut<TutorialController>(() => TutorialController());
    Get.lazyPut<ProfilController>(() => ProfilController());
    Get.lazyPut<BerandaController>(() => BerandaController());
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }
}
