import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/widget/appbarcustom.dart';
import '../controllers/konsultasi_controller.dart';

class KonsultasiView extends GetView<KonsultasiController> {
  const KonsultasiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(judul: "Konsultasi Dokter"),
      body: Obx(() {
        if (controller.doctors.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: controller.doctors.length,
          itemBuilder: (context, index) {
            final doctor = controller.doctors[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(doctor.profilePicture!),
              ),
              title: Text(doctor.doctorName!),
              subtitle: Text(doctor.specialization!),
              onTap: () {
                Get.toNamed('/doctordetail', arguments: doctor);
              },
            );
          },
        );
      }),
    );
  }
}
