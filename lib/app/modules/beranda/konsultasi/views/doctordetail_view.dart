import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/data/models/doctor_model.dart';
import 'package:glowify/widget/appbarcustom.dart';
import 'package:glowify/widget/custom_button.dart';
import 'package:iconsax/iconsax.dart';

import '../controllers/doctordetail_controller.dart';

class DoctordetailView extends GetView<DoctordetailController> {
  final Doctor doctor = Get.arguments;

  DoctordetailView({super.key});

  @override
  Widget build(BuildContext context) {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: CustomAppBar(judul: doctor.doctorName ?? 'Page Uknown'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Card(
            surfaceTintColor: whiteBackground1Color,
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.network(
                    doctor.profilePicture!,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.circle, color: Colors.green, size: 16),
                          SizedBox(width: 5),
                          Text(
                            'Online',
                            style: TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                      const Gap(10),
                      Text(
                        doctor.doctorName ?? 'Nama tidak tersedia',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(5),
                      Text(
                        'spesialis: ${doctor.specialization}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: abuMedColor,
                        ),
                      ),
                      const Gap(20),
                      ListTile(
                        leading: const Icon(Iconsax.buildings),
                        title: Text(
                          'Alumnus',
                          style: semiBold.copyWith(
                            fontSize: mediumSize,
                          ),
                        ),
                        subtitle: Text(
                            doctor.alumnus?.join(', ') ?? 'Tidak diketahui'),
                      ),
                      Obx(() {
                        return ListTile(
                          leading: const Icon(Iconsax.hospital),
                          title: Text(
                            'Praktik di',
                            style: semiBold.copyWith(
                              fontSize: mediumSize,
                            ),
                          ),
                          subtitle: Text(
                            '${controller.klinik.value.namaKlinik}, '
                            '${controller.klinik.value.alamatKlinik?['desa'] ?? ''}, '
                            '${controller.klinik.value.alamatKlinik?['kecamatan'] ?? ''}, '
                            '${controller.klinik.value.alamatKlinik?['kabupaten'] ?? ''}, '
                            '${controller.klinik.value.alamatKlinik?['provinsi'] ?? ''}',
                          ),
                        );
                      }),
                      ListTile(
                        leading: const Icon(Iconsax.card),
                        title: Text(
                          'Nomor STR',
                          style: semiBold.copyWith(
                            fontSize: mediumSize,
                          ),
                        ),
                        subtitle: Text(
                            doctor.strDoctor ?? 'Nomor STR tidak diketahui'),
                      ),
                      const Gap(20),
                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          text: 'Chat',
                          onPressed: () {
                            controller.startChat(
                              currentUserId,
                              doctor.doctorId!,
                              doctor.doctorName!,
                              doctor.profilePicture!,
                            );
                          },
                          icon: const Icon(
                            Iconsax.message,
                            color: whiteBackground1Color,
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
      ),
    );
  }
}
