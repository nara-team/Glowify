import 'package:get/get.dart';
import 'package:glowify/app/modules/booking/controllers/buatjanji_controller.dart';

import '../controllers/bookingdetail_controller.dart';
import '../controllers/booking_controller.dart';

class BookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingController>(
      () => BookingController(),
    );
    Get.lazyPut<BookingdetailController>(
      () => BookingdetailController(),
    );
    Get.lazyPut<BuatjanjiController>(
      () => BuatjanjiController(),
    );
  }
}
