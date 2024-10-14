import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/data/models/bookings_model.dart';
import 'package:glowify/widget/snackbar_custom.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class RiwayatBookingController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final bookingHistory = <Booking>[].obs;
  final activeFilter = 'Semua'.obs;
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    initializeDateFormatting('id_ID', null).then((_) {
      fetchBookingHistory();
    });
  }

  Future<String> getDoctorName(String doctorId) async {
    try {
      DocumentSnapshot doctorSnapshot =
          await _firestore.collection('doctor').doc(doctorId).get();
      return doctorSnapshot.get('doctor_name') as String;
    } catch (e) {
      return 'Unknown Doctor';
    }
  }

  Future<String> getUserName(String userId) async {
    try {
      DocumentSnapshot userSnapshot =
          await _firestore.collection('users').doc(userId).get();
      return userSnapshot.get('fullName') as String;
    } catch (e) {
      User? user = FirebaseAuth.instance.currentUser;
      return user?.displayName ?? 'Unknown User';
    }
  }

  Future<void> fetchBookingHistory() async {
    try {
      isLoading.value = true;
      QuerySnapshot bookingSnapshot = await _firestore
          .collection('bookings')
          .where('userId', isEqualTo: currentUserId)
          .get();

      List<Booking> fetchedBookings = [];

      for (var doc in bookingSnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String doctorId = data['doctorId'];
        String userId = data['userId'];

        String doctorName = await getDoctorName(doctorId);
        String userName = await getUserName(userId);

        String status = data['status'];
        Color statusColor = _getStatusColor(status);

        DateTime bookingAtDateTime = (data['bookingAt'] as Timestamp).toDate();
        DateTime bookingTimeDateTime =
            (data['booking_time'] as Timestamp).toDate();
        String formattedBookingAt =
            DateFormat('EEEE, dd-MM-yyyy, HH:mm', 'id_ID')
                .format(bookingAtDateTime);
        String formattedBookingTime =
            DateFormat('EEEE, dd-MM-yyyy, HH:mm', 'id_ID')
                .format(bookingTimeDateTime);

        Booking booking = Booking.fromFirestore(
          doc,
          doctorName,
          userName,
          statusColor,
          formattedBookingAt,
          formattedBookingTime,
        );

        fetchedBookings.add(booking);
      }

      bookingHistory.value = fetchedBookings;
    } catch (e) {
      const SnackBarCustom(
        judul: "Gagal",
        pesan: "Gagal mengambil data booking",
        iconType: SnackBarIconType.gagal,
        isHasIcon: true,
      ).show();
    } finally {
      isLoading.value = false;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'canceled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  List<Booking> get filteredBookingHistory {
    if (activeFilter.value == 'Semua') {
      return bookingHistory;
    }
    return bookingHistory
        .where((booking) => booking.status == activeFilter.value)
        .toList();
  }
}
