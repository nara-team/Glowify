// chat_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/chat_controller.dart';
import 'chat_user_view.dart'; // Halaman chat dengan pengguna

class ChatView extends GetView<ChatController> {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.put(ChatController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pengguna'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Cari Pengguna',
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
              if (controller.filteredUsers.isEmpty) {
                return const Center(child: Text("Tidak ada pengguna ditemukan"));
              }
              return ListView.builder(
                itemCount: controller.filteredUsers.length,
                itemBuilder: (context, index) {
                  final user = controller.filteredUsers[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user['photoURL'] ?? 'https://example.com/default.jpg'),
                    ),
                    title: Text(user['fullName'] ?? 'No Name'),
                    subtitle: Text(user['email'] ?? 'No Email'),
                    onTap: () {
                      // Navigasi ke halaman chat dengan pengguna yang dipilih
                      Get.to(() => ChatUserPageView(userId: user['id']));
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
