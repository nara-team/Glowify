import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/app/theme/sized_theme.dart';
import 'package:glowify/widget/appbarcustom.dart';
import 'package:glowify/widget/customsearchtextfield.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../controllers/konsultasi_controller.dart';

class KonsultasiView extends GetView<KonsultasiController> {
  const KonsultasiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(judul: "Konsultasi Dokter"),
      body: SafeArea(
        child: Padding(
          padding: PaddingCustom().paddingOnly(20, 20, 20, 0),
          child: Column(
            children: [
              CustomSearchTextField(
                onChanged: (query) {},
                hintText: "Cari dokter...",
              ),
              const Gap(40),
              Expanded(
                child: Obx(() {
                  if (controller.doctors.isEmpty) {
                    return Skeletonizer(
                      enabled: controller.doctors.isEmpty,
                      child: ListView.builder(
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 16,
                                    color: Colors.grey[300],
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    width: 150,
                                    height: 16,
                                    color: Colors.grey[300],
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    width: 50,
                                    height: 50,
                                    color: Colors.grey[300],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: controller.doctors.length,
                    itemBuilder: (context, index) {
                      final doctor = controller.doctors[index];
                      return DoctorCard(
                        name: doctor.doctorName ?? 'Nama Tidak Diketahui',
                        specialty: doctor.specialization ??
                            'Spesialisasi Tidak Diketahui',
                        imagePath: doctor.profilePicture ??
                            'assets/images/default_doctor.png',
                        onTap: () {
                          Get.toNamed('/doctordetail', arguments: doctor);
                        },
                      );
                    },
                  );
                }),
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
  final String imagePath;
  final VoidCallback onTap;

  const DoctorCard({
    super.key,
    required this.name,
    required this.specialty,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
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
                child: Image.network(
                  imagePath,
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.broken_image,
                      size: 60,
                    );
                  },
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
                  ],
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}
