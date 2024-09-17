import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationController extends GetxController {
  var notifications = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDummyNotifications();
  }

  void loadDummyNotifications() {
    final now = DateTime.now();
    notifications.assignAll([
      {
        "title": "Ada yang baru nih di Glowify!",
        "message": "Cek sekarang untuk mengetahui pembaruan terbaru.",
        "time": now.subtract(const Duration(minutes: 1)),
      },
      {
        "title": "Tutorial memutihkan kulit",
        "message": "Ada tutorial baru tentang cara memutihkan kulit.",
        "time": now.subtract(const Duration(minutes: 10)),
      },
      {
        "title": "Promo Spesial!",
        "message": "Dapatkan diskon spesial untuk produk perawatan kulit.",
        "time": now.subtract(const Duration(hours: 3)),
      },
      {
        "title": "Booking Klinik Kecantikan",
        "message": "Booking sekarang dan dapatkan penawaran eksklusif!",
        "time": now.subtract(const Duration(days: 1)),
      },
      {
        "title": "Deteksi Kesehatan Wajah",
        "message": "Coba fitur deteksi kesehatan wajah sekarang.",
        "time": now.subtract(const Duration(days: 2)),
      },
    ]);
  }

  String formatTime(DateTime dateTime) {
    return timeago.format(dateTime, locale: 'en_short');
  }
}
