import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RiwayatBookingController extends GetxController {
  var bookingHistory = <Map<String, dynamic>>[].obs;
  var activeFilter = 'Semua'.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> fetchBookingHistory() async {
    try {
      String userId = auth.currentUser?.uid ?? '';

      if (userId.isEmpty) {
        debugPrint('User not logged in');
        return;
      }

      QuerySnapshot bookingSnapshot = await firestore
          .collection('bookings')
          .where('userId', isEqualTo: userId)
          .get();

      List<Map<String, dynamic>> fetchedData = [];

      for (var doc in bookingSnapshot.docs) {
        String status = doc['status'];
        Color statusColor;

        switch (status) {
          case 'completed':
            statusColor = Colors.green;
            break;
          case 'pending':
            statusColor = Colors.orange;
            break;
          case 'canceled':
            statusColor = Colors.red;
            break;
          default:
            statusColor = Colors.grey;
        }

        String doctorId = doc['doctorId'];

        DocumentSnapshot doctorSnapshot =
            await firestore.collection('doctor').doc(doctorId).get();

        String doctorName = doctorSnapshot.exists
            ? doctorSnapshot['doctor_name']
            : 'Unknown Doctor';

        QuerySnapshot clinicSnapshot = await firestore
            .collection('klinik')
            .where('id_doktor', arrayContains: doctorId)
            .get();

        String clinicName = clinicSnapshot.docs.isNotEmpty
            ? clinicSnapshot.docs.first['nama_klinik']
            : 'Unknown Clinic';

        fetchedData.add({
          'date': doc['booking_time'].toDate().toString(),
          'service': doc['note'],
          'status': status,
          'statusColor': statusColor,
          'clinic': clinicName,
          'doctor': doctorName,
        });
      }

      bookingHistory.assignAll(fetchedData);
    } catch (e) {
      debugPrint('Error fetching booking data: $e');
    }
  }

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
    fetchBookingHistory();
  }
}
