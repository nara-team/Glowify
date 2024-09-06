import 'package:get/get.dart';
import '../controllers/pusat_bantuan_controller.dart';

class PusatBantuanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PusatBantuanController>(
      () => PusatBantuanController(),
    );
  }
}
