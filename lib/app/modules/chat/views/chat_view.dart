import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/chat_controller.dart';
import 'chat_doctor_view.dart'; // Import halaman chat dokter

class ChatView extends GetView<ChatController> {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.put(ChatController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Dokter'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Cari Dokter',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                controller.search(value);
              },
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.filteredDoctors.isEmpty) {
                return const Center(child: Text("Tidak ada dokter ditemukan"));
              }
              return ListView.builder(
                itemCount: controller.filteredDoctors.length,
                itemBuilder: (context, index) {
                  final doctor = controller.filteredDoctors[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(doctor['photo_doctor'] ?? 'https://example.com/default.jpg'),
                    ),
                    title: Text(doctor['name'] ?? 'No Name'),
                    subtitle: Text(doctor['specialization'] ?? 'No Specialization'),
                   onTap: () {
                      // Navigasi ke halaman chat dengan dokter yang dipilih
                      Get.to(() => ChatDoctorPageView(doctorId: doctor['id']));
                    },

                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
