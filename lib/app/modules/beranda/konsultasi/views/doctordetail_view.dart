import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/app/theme/sized_theme.dart';
import 'package:glowify/data/models/doctor_model.dart';
import 'package:glowify/widget/appbarcustom.dart';
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
                      const SizedBox(height: 10),
                      Text(
                        doctor.doctorName ?? 'Nama tidak tersedia',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'spesialis: ${doctor.specialization}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: abuMedColor,
                        ),
                      ),
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            debugPrint('Chat button pressed');
                            if (doctor.doctorId != null &&
                                doctor.doctorName != null &&
                                doctor.profilePicture != null) {
                              controller.startChat(
                                currentUserId,
                                doctor.doctorId!,
                                doctor.doctorName!,
                                doctor.profilePicture!,
                              );
                            } else {
                              debugPrint('Error: Doctor data is incomplete');
                              Get.snackbar(
                                  'Error', 'Data dokter tidak lengkap.');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            padding: PaddingCustom().paddingVertical(15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Iconsax.message,
                                color: whiteBackground1Color,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Chat',
                                style: bold.copyWith(
                                  fontSize: mediumSize,
                                  color: whiteBackground1Color,
                                ),
                              ),
                            ],
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
