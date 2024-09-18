import 'package:get/get.dart';
import 'package:glowify/app/modules/beranda/home/controllers/beranda_controller.dart';
import 'package:glowify/app/modules/chat/controllers/chat_controller.dart';
import 'package:glowify/app/modules/chat/controllers/chatroom_controller.dart';
import 'package:glowify/app/modules/profil/setting/controllers/profil_controller.dart';
import 'package:glowify/app/modules/tutorial/controllers/tutorial_controller.dart';

class NavbarController extends GetxController {
  var tabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut<TutorialController>(() => TutorialController());
    Get.lazyPut<BerandaController>(() => BerandaController());
    Get.lazyPut<ChatController>(
      () => ChatController(),
    );
    Get.lazyPut<ProfilController>(() => ProfilController());
    Get.lazyPut<ChatroomController>(
      () => ChatroomController(),
    );
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }
}
