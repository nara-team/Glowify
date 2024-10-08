import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/app/theme/sized_theme.dart';
import 'package:glowify/widget/appbarcustom.dart';
import 'package:glowify/widget/nodata_handling_widget.dart';
import 'package:glowify/widget/tabfilter_custom.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skeletonizer/skeletonizer.dart';
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
              TabFilterCustom(
                categories: const ['Semua', 'completed', 'pending', 'canceled'],
                selectedCategory: controller.activeFilter,
                onCategorySelected: (String category) {
                  controller.activeFilter.value = category;
                },
                isScrollable: true,
                horizontal: 10,
                vertical: 5,
              ),
              const Gap(20),
              Expanded(
                child: Obx(() {
                  if (controller.bookingHistory.isEmpty) {
                    return ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Skeletonizer(
                          child: Card(
                            surfaceTintColor: whiteBackground1Color,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: primaryColor,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 2,
                            shadowColor: Colors.transparent,
                            margin: const EdgeInsets.only(bottom: 10),
                            child: ListTile(
                              leading: Container(
                                width: 50,
                                height: 50,
                                color: Colors.grey,
                              ),
                              title: Container(
                                width: double.infinity,
                                height: 20.0,
                                color: Colors.grey,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 10.0,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 5.0),
                                    color: Colors.grey,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 10.0,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 5.0),
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }

                  var bookings = controller.filteredBookingHistory;
                  if (bookings.isEmpty) {
                    return const NodataHandling(
                      iconVariant: IconVariant.dokumen,
                      messageText: "belum ada riwayat dengan status ini",
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
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 2,
                          shadowColor: Colors.transparent,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            leading: const Icon(Iconsax.stickynote),
                            title: Text(
                                booking['service'] ?? 'Service Tidak Tersedia'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Klinik: ${booking['clinic'] ?? 'Clinic Tidak Tersedia'}'),
                                Text(
                                    'Dokter: ${booking['doctor'] ?? 'Doctor Tidak Tersedia'}'),
                                Text(
                                    'Tanggal: ${booking['date'] ?? 'Tanggal Tidak Tersedia'}'),
                              ],
                            ),
                            trailing: Container(
                              padding: PaddingCustom()
                                  .paddingHorizontalVertical(8, 4),
                              decoration: BoxDecoration(
                                color: booking['statusColor'],
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                booking['status'] ?? 'Status Tidak Tersedia',
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
