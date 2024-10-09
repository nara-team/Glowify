import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/sized_theme.dart';
import 'package:glowify/widget/appbarcustom.dart';

import '../controllers/booking_history_detail_controller.dart';

class BookingHistoryDetailView extends GetView<BookingHistoryDetailController> {
  const BookingHistoryDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    final booking = Get.arguments;
    return Scaffold(
      appBar: const CustomAppBar(judul: "Riwayat booking  "),
      body: SafeArea(
        child: Padding(
          padding: PaddingCustom().paddingHorizontal(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Service: ${booking['service'] ?? 'Service Tidak Tersedia'}'),
              Text('Klinik: ${booking['clinic'] ?? 'Clinic Tidak Tersedia'}'),
              Text('Dokter: ${booking['doctor'] ?? 'Doctor Tidak Tersedia'}'),
              Text('Tanggal: ${booking['date'] ?? 'Tanggal Tidak Tersedia'}'),
              Text('Status: ${booking['status'] ?? 'Status Tidak Tersedia'}'),
            ],
          ),
        ),
      ),
    );
  }
}
