import 'package:get/get.dart';

class RiwayatBookingController extends GetxController {
  var bookingHistory = <Map<String, String>>[].obs;

  var activeFilter = 'Semua'.obs;
  
  List<Map<String, dynamic>> get filteredBookingHistory {
    if (activeFilter.value == 'Semua') {
      return bookingHistory;
    } else {
      return bookingHistory
          .where((booking) => booking['status'] == activeFilter.value)
          .toList();
    }
  }

  @override
  void onInit() {
    super.onInit();

    bookingHistory.assignAll([
      {
        'date': '2024-09-01',
        'service': 'Facial Treatment',
        'status': 'Completed',
        'clinic': 'Glowify Beauty Clinic',
        'doctor': 'Dr. Amanda Putri',
      },
      {
        'date': '2024-08-28',
        'service': 'Skincare Consultation',
        'status': 'Canceled',
        'clinic': 'Dermacare Clinic',
        'doctor': 'Dr. Budi Santoso',
      },
      {
        'date': '2024-08-20',
        'service': 'Acne Treatment',
        'status': 'Completed',
        'clinic': 'Glowify Beauty Clinic',
        'doctor': 'Dr. Amanda Putri',
      },
    ]);
  }
}
