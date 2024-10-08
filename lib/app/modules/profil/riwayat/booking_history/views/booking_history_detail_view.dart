import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/widget/appbarcustom.dart';

import '../controllers/booking_history_detail_controller.dart';

class BookingHistoryDetailView extends GetView<BookingHistoryDetailController> {
  const BookingHistoryDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(judul: "Riwayat booking  "),
      body: Center(
        child: Text(
          'halaman detail histori booking',
          style: bold.copyWith(
            fontSize: largeSize,
          ),
        ),
      ),
    );
  }
}
