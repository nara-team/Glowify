import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/app/theme/sized_theme.dart';
import 'package:glowify/widget/appbarcustom.dart';
import '../controllers/riwayat_booking_controller.dart';

class RiwayatBookingView extends GetView<RiwayatBookingController> {
  const RiwayatBookingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(judul: "Riwayat Booking"),
      body: SafeArea(
        child: Padding(
          padding: PaddingCustom().paddingHorizontalVertical(20, 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: ['Semua', 'Completed', 'Pending'].map(
                  (status) {
                    return Obx(
                      () => ChoiceChip(
                        label: Text(status),
                        selectedColor: primaryColor,
                        labelStyle: TextStyle(
                            color: controller.activeFilter.value == status
                                ? whiteBackground1Color
                                : blackColor),
                        selected: controller.activeFilter.value == status,
                        onSelected: (bool selected) {
                          controller.activeFilter.value = status;
                        },
                      ),
                    );
                  },
                ).toList(),
              ),
              const Gap(20),
              Expanded(
                child: Obx(() {
                  var bookings = controller.filteredBookingHistory;
                  if (bookings.isEmpty) {
                    return const Center(
                      child: Text(
                        'Belum ada riwayat booking',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: bookings.length,
                      itemBuilder: (context, index) {
                        final booking = bookings[index];
                        return Card(
                          surfaceTintColor: whiteBackground1Color,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: primaryColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: const Icon(Icons.spa),
                            title: Text(booking['service']!),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Klinik: ${booking['clinic']}'),
                                Text('Dokter: ${booking['doctor']}'),
                                Text('Tanggal: ${booking['date']}'),
                              ],
                            ),
                            trailing: Container(
                              padding: PaddingCustom()
                                  .paddingHorizontalVertical(8, 4),
                              decoration: BoxDecoration(
                                color: booking['status'] == 'Completed'
                                    ? Colors.green
                                    : Colors.red,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                booking['status']!,
                                style: bold.copyWith(
                                  color: whiteBackground1Color,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
