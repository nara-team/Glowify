import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationController extends GetxController {
  var notifications = <Map<String, dynamic>>[].obs;

  var activeFilter = "Semua".obs;

  List<Map<String, dynamic>> get filteredNotification {
    if (activeFilter.value == 'Semua') {
      return notifications;
    } else {
      return notifications
          .where((booking) => booking['status'] == activeFilter.value)
          .toList();
    }
  }

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
        "status": "unread"
      },
      {
        "title": "Tutorial memutihkan kulit",
        "message": "Ada tutorial baru tentang cara memutihkan kulit.",
        "time": now.subtract(const Duration(minutes: 10)),
        "status": "unread"
      },
      {
        "title": "Promo Spesial!",
        "message": "Dapatkan diskon spesial untuk produk perawatan kulit.",
        "time": now.subtract(const Duration(hours: 3)),
        "status": "read"
      },
      {
        "title": "Booking Klinik Kecantikan",
        "message": "Booking sekarang dan dapatkan penawaran eksklusif!",
        "time": now.subtract(const Duration(days: 1)),
        "status": "read"
      },
      {
        "title": "Deteksi Kesehatan Wajah",
        "message": "Coba fitur deteksi kesehatan wajah sekarang.",
        "time": now.subtract(const Duration(days: 2)),
        "status": "read"
      },
    ]);
  }

  String formatTime(DateTime dateTime) {
    return timeago.format(dateTime, locale: 'en_short');
  }
}
