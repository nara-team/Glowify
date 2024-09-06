import 'package:get/get.dart';

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
  }
}
