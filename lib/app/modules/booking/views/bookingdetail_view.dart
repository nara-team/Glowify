import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/app/theme/sized_theme.dart';
import 'package:glowify/data/models/klinik_model.dart';
import 'package:glowify/widget/appbarcustom.dart';
import '../controllers/bookingdetail_controller.dart';

class BookingDetailView extends GetView<BookingdetailController> {
  const BookingDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final KlinikModel klinik = Get.arguments;

    controller.fetchDoctorsForKlinik(klinik.idDoktor ?? []);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: whiteBackground1Color,
        appBar: CustomAppBar(
          judul: klinik.namaKlinik ?? 'Detail Klinik',
        ),
        body: Padding(
          padding: PaddingCustom().paddingOnly(20, 20, 20, 4),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: Image.asset(
                      klinik.photoKlinik!,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              blackColor.withOpacity(0.9),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 12,
                    child: Text(
                      klinik.namaKlinik!,
                      style: const TextStyle(
                        color: whiteBackground1Color,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 12,
                    child: LocationInfo(
                      distance: "16 km",
                    ),
                  ),
                ],
              ),
              const TabBar(
                tabs: [
                  Tab(text: 'Dokter'),
                  Tab(text: 'Detail'),
                ],
                indicatorColor: primaryColor,
                labelColor: primaryColor,
                unselectedLabelColor: blackColor,
              ),
              const Gap(20),
              Expanded(
                child: TabBarView(
                  children: [
                    Obx(() {
                      if (controller.doctorList.isEmpty) {
                        return Center(
                          child: Text(
                            'Dokter belum tersedia untuk layanan ini',
                            style: medium.copyWith(
                              fontSize: regularSize,
                            ),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: controller.doctorList.length,
                          itemBuilder: (context, index) {
                            final doctor = controller.doctorList[index];
                            return DoctorCard(
                              name: doctor.name ?? 'Nama Tidak Diketahui',
                              specialty: doctor.specialization ??
                                  'Spesialisasi Tidak Diketahui',
                              hospital:
                                  klinik.namaKlinik ?? 'Klinik Tidak Diketahui',
                              imagePath: doctor.photoDoctor ??
                                  'assets/images/default_doctor.png',
                            );
                          },
                        );
                      }
                    }),
                    Center(
                      child: Text(
                        'Alamat: ${klinik.alamatKlinik?['desa']}, ${klinik.alamatKlinik?['kecamatan']}, ${klinik.alamatKlinik?['kabupaten']}, ${klinik.alamatKlinik?['provinsi']}\n'
                        'Jam Operasional: ${klinik.operasional?['start']} - ${klinik.operasional?['end']}',
                        style: medium.copyWith(
                          fontSize: regularSize,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LocationInfo extends StatelessWidget {
  final String distance;

  const LocationInfo({Key? key, required this.distance}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: PaddingCustom().paddingHorizontalVertical(4, 4),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.location_on,
              color: whiteBackground1Color,
              size: 20,
            ),
            const SizedBox(width: 2),
            Text(
              distance,
              style: const TextStyle(
                fontSize: regularSize,
                color: whiteBackground1Color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final String name;
  final String specialty;
  final String hospital;
  final String imagePath;

  const DoctorCard({
    super.key,
    required this.name,
    required this.specialty,
    required this.hospital,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: whiteBackground1Color,
      surfaceTintColor: whiteBackground1Color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    specialty,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    hospital,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: PaddingCustom().paddingHorizontalVertical(10, 5),
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Booking',
                style: medium.copyWith(
                  color: whiteBackground1Color,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
