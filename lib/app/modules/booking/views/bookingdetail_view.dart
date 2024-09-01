import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:glowify/app/modules/booking/controllers/bookingdetail_controller.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/app/theme/sized_theme.dart';
import 'package:glowify/widget/appbarcustom.dart';
import 'package:glowify/widget/cliniccard.dart' as klinikwidget;

class BookingDetailView extends GetView<BookingdetailController> {
  const BookingDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final clinicData = Get.arguments as Map<String, dynamic>?;

    if (clinicData == null) {
      return const Center(
        child: Text(
          'Data klinik tidak ditemukan',
          style: TextStyle(fontSize: 18, color: primaryColor),
        ),
      );
    }
    final List<dynamic> doctorList = clinicData['avaible_doctor'] ?? [];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: whiteBackground1Color,
        appBar: CustomAppBar(
          judul: clinicData['title'],
        ),
        body: Padding(
          padding: PaddingCustom().paddingOnly(20, 20, 20, 4),
          child: Column(
            children: [
              Stack(
                children: [
                  // Gambar klinik
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: Image.asset(
                      'assets/images/klinik_1.png',
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Shadow di dalam gambar, bagian bawah
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 60, // Tinggi shadow
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              blackColor.withOpacity(
                                  0.9), // Shadow warna gelap di bawah
                              Colors.transparent, // Transparan di atas
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
                      clinicData['title'],
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
                    child: klinikwidget.LocationInfo(
                      distance: "${clinicData['distance']} km",
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
                    doctorList.isNotEmpty
                        ? ListView.builder(
                            itemCount: doctorList.length,
                            itemBuilder: (context, index) {
                              final doctor = doctorList[index];
                              return DoctorCard(
                                name: doctor['doctorname'],
                                specialty: doctor['spesialis'],
                                hospital: clinicData['title'],
                                imagePath: doctor['photo_doctor'],
                              );
                            },
                          )
                        : Center(
                            child: Text(
                              'Dokter belum tersedia untuk layanan ini',
                              style: medium.copyWith(
                                fontSize: regularSize,
                              ),
                            ),
                          ),
                    Center(
                      child: Text(
                        'Detail Klinik',
                        style: medium.copyWith(
                          fontSize: regularSize,
                        ),
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
