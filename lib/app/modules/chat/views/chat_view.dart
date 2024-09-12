import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/chat_controller.dart';
import 'chat_doctor_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.put(ChatController());

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Cari dokter...',
                  prefixIcon: Icon(Icons.search, color: Colors.redAccent),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
                onChanged: (value) {
                  controller.search(value);
                },
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.filteredDoctors.isEmpty) {
                return const Center(
                  child: Text(
                    "Dokter tidak ditemukan",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                );
              }
              return ListView.builder(
                itemCount: controller.filteredDoctors.length,
                itemBuilder: (context, index) {
                  final doctor = controller.filteredDoctors[index];
                  final lastMessageTime = doctor['lastMessageTime'] != null
                      ? DateFormat('hh:mm a').format((doctor['lastMessageTime'] as Timestamp).toDate())
                      : '';
                  
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(doctor['photo_doctor'] ?? 'https://example.com/default.jpg'),
                    ),
                    title: Text(
                      doctor['name'] ?? 'No Name',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      doctor['lastMessage'] ?? 'No message',
                      style: const TextStyle(color: Colors.black54),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          lastMessageTime,
                          style: TextStyle(color: Colors.grey[600], fontSize: 12),
                        ),
                        const SizedBox(height: 4),
                        if (index == 0)
                          Container(
                            width: 18,
                            height: 18,
                            decoration: const BoxDecoration(
                              color: Colors.redAccent,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Text(
                                '1',
                                style: TextStyle(color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ),
                        if (index != 0)
                          Icon(Icons.check_circle, color: Colors.blue, size: 16),
                      ],
                    ),
                    onTap: () {
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
