import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/app/theme/sized_theme.dart';
import 'package:glowify/widget/appbarcustom.dart';
import 'package:glowify/widget/cliniccard.dart';
import 'package:glowify/widget/serch_textfield.custom.dart';
import 'package:iconsax/iconsax.dart';

import '../controllers/booking_controller.dart';

class BookingView extends GetView<BookingController> {
  const BookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(judul: "Booking Klinik Kecantikan"),
      body: SafeArea(
        child: Padding(
          padding: PaddingCustom().paddingOnly(20, 30, 20, 4),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Iconsax.location5,
                        color: primaryColor,
                        size: 36,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Lokasi Anda",
                            style: bold.copyWith(
                              fontSize: regularSize,
                            ),
                          ),
                          const Gap(1),
                          Text(
                            "Malang, Lowokwaru",
                            style: medium.copyWith(
                              fontSize: regularSize,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    onChanged: (value) {
                      controller.searchKlinik(value);
                    },
                    hintText: "cari klinik",
                  ),
                ],
              ),
              const Gap(30),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.filteredDataKlinikModel.length,
                    itemBuilder: (context, index) {
                      final klinik = controller.filteredDataKlinikModel[index];

                      final address = klinik['address'];
                      String addressString = '';

                      if (address is Map<String, dynamic>) {
                        addressString =
                            '${address['jalan']}, ${address['desa']}, ${address['kecamatan']}, ${address['kota']}, ${address['provinsi']}, ${address['kode_pos']} - ${address['additional']}';
                      } else {
                        addressString = 'Alamat tidak tersedia';
                      }
                      return ClinicCard(
                        onTap: () => Get.toNamed(
                          '/bookingdetail',
                          arguments: klinik,
                        ),
                        imagePath: klinik['imagepath'],
                        clinicName: klinik['title'],
                        openHours:
                            '${klinik['operasionalStart']} - ${klinik['operasionalEnd']}',
                        address: addressString,
                        distance: '${klinik['distance']} Km',
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
