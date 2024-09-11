import 'package:get/get.dart';
import '../controllers/detailtutorial_controller.dart';
import '../controllers/tutorial_controller.dart';

class TutorialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TutorialController>(
      () => TutorialController(),
    );
    Get.lazyPut<TutorialDetailController>(
      () => TutorialDetailController(),
    );
  }
}
