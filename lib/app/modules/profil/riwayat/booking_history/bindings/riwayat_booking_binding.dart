import 'package:get/get.dart';

import '../controllers/riwayat_booking_controller.dart';

class RiwayatBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RiwayatBookingController>(
      () => RiwayatBookingController(),
    );
  }
}
