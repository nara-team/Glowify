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
  RxBool isLoading = true.obs;

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
        isLoading.value = true;
        await FirebaseFirestore.instance.collection('bookings').add({
          'doctorId': doctor.value.doctorId,
          'booking_time': selectedSchedule.value,
          'note': noteController.value,
          'status': 'pending',
          'userId': currentUserId,
          'bookingAt': Timestamp.now(),
        });
      } catch (e) {
        Get.snackbar('Error', 'Gagal membuat booking: $e');
      } finally {
        isLoading.value = false;
        Get.offAllNamed('/navbar');
        const SnackBarCustom(
          judul: 'Sukses',
          pesan: 'Booking berhasil dibuat',
          isHasIcon: true,
          iconType: SnackBarIconType.sukses,
        ).show();
      }
    } else {
      Get.snackbar('Error', 'Silakan pilih jadwal terlebih dahulu');
      const SnackBarCustom(
        judul: 'maaf,',
        pesan: 'Silakan pilih jadwal terlebih dahulu',
        iconType: SnackBarIconType.warning,
      ).show();
    }
  }
}
