import 'package:get/get.dart';

class RiwayatBookingController extends GetxController {
  // Observable list for booking history with clinic and doctor details
  var bookingHistory = <Map<String, String>>[].obs;

  // Filter aktif
  var activeFilter = 'Semua'.obs;  // Menambahkan state untuk filter aktif

  // Fungsi untuk memfilter booking berdasarkan status
  List<Map<String, dynamic>> get filteredBookingHistory {
    if (activeFilter.value == 'Semua') {
      return bookingHistory;
    } else {
      return bookingHistory.where((booking) => booking['status'] == activeFilter.value).toList();
    }
  }

  @override
  void onInit() {
    super.onInit();

    // Initialize booking history with more detailed data
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
