import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/konsultasi_controller.dart';
import 'doctor_chat_page.dart';

class KonsultasiView extends GetView<KonsultasiController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konsultasi Dokter'),
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.doctors.length,
          itemBuilder: (context, index) {
            final doctor = controller.doctors[index];
            return Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(doctor.image),
                ),
                title: Text(
                  doctor.name,
                  style: TextStyle(
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
            Get.to(() => DoctorChatPage(doctor: doctor));
          },
          icon: Icon(Icons.chat),
          color: Colors.pink,
          tooltip: 'Chat',
        ),
        IconButton(
          onPressed: () {
            // Implement call functionality here if needed
          },
          icon: Icon(Icons.videocam),
          color: Colors.pink,
          tooltip: 'Call',
        ),
      ],
    );
  }
}
