import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/sized_theme.dart';
import 'package:glowify/data/models/bookings_model.dart';
import 'package:glowify/widget/appbarcustom.dart';

import '../controllers/booking_history_detail_controller.dart';

class BookingHistoryDetailView extends GetView<BookingHistoryDetailController> {
  const BookingHistoryDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    final Booking booking = Get.arguments as Booking;

    return Scaffold(
      appBar: const CustomAppBar(
        judul: "Riwayat booking",
      ),
      body: Padding(
        padding: PaddingCustom().paddingHorizontal(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dokter: ${booking.doctorName}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(8),
            Text(
              'User: ${booking.userName}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const Gap(8),
            Text(
              'Booking At: ${booking.formattedBookingAt}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const Gap(8),
            Text(
              'Tanggal Janji: ${booking.formattedBookingTime}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const Gap(8),
            Text(
              'Catatan: ${booking.note}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const Gap(8),
            Text(
              'Status: ${booking.status}',
              style: TextStyle(
                fontSize: 16,
                color: booking.statusColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
