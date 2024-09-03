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
          padding: PaddingCustom().paddingOnly(20, 10, 20, 4),
          child: Column(
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Lokasi Anda",
                          style: bold.copyWith(
                            fontSize: mediumSize,
                          ),
                        ),
                        const Gap(1),
                        Obx(() {
                          return Text(
                            controller.currentAddress,
                            style: medium.copyWith(
                              fontSize: regularSize,
                            ),
                            softWrap: true,
                            maxLines: null,
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomTextField(
                onChanged: (value) {},
                hintText: "cari klinik",
              ),
              const Gap(30),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.klinikList.length,
                    itemBuilder: (context, index) {
                      final klinik = controller.klinikList[index];

                      final address = klinik.alamatKlinik;
                      String addressString = '';

                      if (address != null) {
                        addressString =
                            '${klinik.alamatKlinik!['provinsi']}, ${klinik.alamatKlinik!['kabupaten']}, ${klinik.alamatKlinik!['kecamatan']}, ${klinik.alamatKlinik!['desa']}';
                      } else {
                        addressString = 'Alamat tidak tersedia';
                      }

                      return ClinicCard(
                        onTap: () => controller.onKlinikClicked(klinik),
                        imagePath: klinik.photoKlinik!,
                        clinicName: klinik.namaKlinik ?? 'nama tidak diketahui',
                        openHours: (klinik.operasional?['start'] != null &&
                                klinik.operasional?['end'] != null)
                            ? '${klinik.operasional!['start']} - ${klinik.operasional!['end']}'
                            : 'tidak tersedia',
                        address: addressString,
                        distance: 'Jarak tidak tersedia',
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
