import 'package:get/get.dart';

import '../controllers/booking_history_controller.dart';
import '../controllers/booking_history_detail_controller.dart';

class RiwayatBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RiwayatBookingController>(
      () => RiwayatBookingController(),
    );
    Get.lazyPut<BookingHistoryDetailController>(
      () => BookingHistoryDetailController(),
    );
  }
}
