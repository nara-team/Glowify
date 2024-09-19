import 'package:get/get.dart';
import '../controllers/informasi_akun_controller.dart';

class InformasiAkunBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InformasiAkunController>(
      () => InformasiAkunController(),
    );
  }
}
