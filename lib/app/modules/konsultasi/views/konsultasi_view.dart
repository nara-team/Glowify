import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/konsultasi_controller.dart';
import 'chat_doctor_view.dart';

class KonsultasiView extends GetView<KonsultasiController> {
  const KonsultasiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Konsultasi Dokter')),
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.doctors.length,
          itemBuilder: (context, index) {
            final doctor = controller.doctors[index];
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(doctor.image), // Use NetworkImage instead of AssetImage
                ),
                title: Text(
                  doctor.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Text(
                  doctor.specialty,
                  style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                ),
                trailing: _buildTrailingButtons(doctor),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildTrailingButtons(Doctor doctor) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            Get.to(() => ChatDoctorPageView(doctorId: doctor.id)); // Ganti `doctor.name` dengan `doctor.id`
          },
          icon: const Icon(Icons.chat),
          color: Colors.pink,
          tooltip: 'Chat',
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.videocam),
          color: Colors.pink,
          tooltip: 'Call',
        ),
      ],
    );
  }
}
