import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:glowify/data/models/doctor_model.dart';
import 'package:glowify/widget/snackbar_custom.dart';

class BuatjanjiController extends GetxController {
  final doctor = Doctor().obs;
  final selectedSchedule = Rx<Timestamp?>(null);
  final noteController = ''.obs;
  String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void onInit() {
    super.onInit();

    final Doctor dokter = Get.arguments;
    doctor.value = dokter;
  }

  void updateSelectedSchedule(Timestamp? schedule) {
    selectedSchedule.value = schedule;
  }

  Future<void> saveBooking() async {
    if (selectedSchedule.value != null) {
      try {
        await FirebaseFirestore.instance.collection('bookings').add({
          'doctorId': doctor.value.doctorId,
          'booking_time': selectedSchedule.value,
          'note': noteController.value,
          'status': 'pending',
          'userId': currentUserId,
        });
        const SnackBarCustom(
          judul: 'Sukses',
          pesan: 'Booking berhasil dibuat',
        ).show();
        Get.offNamed('/navbar');
      } catch (e) {
        Get.snackbar('Error', 'Gagal membuat booking: $e');
      }
    } else {
      Get.snackbar('Error', 'Silakan pilih jadwal terlebih dahulu');
      const SnackBarCustom(
          judul: 'maaf,',
          pesan: 'Silakan pilih jadwal terlebih dahulu',
        ).show();
    }
  }
}
