import 'package:get/get.dart';
import 'package:glowify/app/modules/profil/riwayat/detection_history/controllers/detection_history_controller.dart';

import '../controllers/detection_history_detail_controller.dart';


class FaceHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FaceHistoryController>(
      () => FaceHistoryController(),
    );
    Get.lazyPut<DetectionHistoryDetailController>(
      () => DetectionHistoryDetailController(),
    );
  }
}
