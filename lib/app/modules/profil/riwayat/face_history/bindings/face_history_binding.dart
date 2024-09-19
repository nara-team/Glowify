import 'package:get/get.dart';

import '../controllers/face_history_controller.dart';

class FaceHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FaceHistoryController>(
      () => FaceHistoryController(),
    );
  }
}
