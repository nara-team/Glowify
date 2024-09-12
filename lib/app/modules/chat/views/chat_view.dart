import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/app/modules/chat/controllers/chat_controller.dart';
import 'package:glowify/app/modules/chat/controllers/chatroom_controller.dart';
import 'package:glowify/app/modules/chat/views/chatroom_view.dart';
import 'package:intl/intl.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({Key? key}) : super(key: key);

  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('hh:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(
              () {
                return Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(controller.imageUrl.value),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.name.value,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink,
                          ),
                        ),
                        Text(
                          controller.email.value,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari disini..',
                prefixIcon: Icon(Icons.search, color: Colors.pink),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.chats.isEmpty) {
                return Center(child: Text('No chats available'));
              }
              return ListView.builder(
                itemCount: controller.chats.length,
                itemBuilder: (context, index) {
                  final chat = controller.chats[index];
                  return ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(chat.doctorProfilePicture),
                      radius: 25,
                      onBackgroundImageError: (error, stackTrace) {
                        print('Error loading image: $error');
                      },
                      child: chat.doctorProfilePicture.isEmpty
                          ? const Icon(Icons.person)
                          : null,
                    ),
                    title: Text(
                      chat.doctorName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text(chat.lastMessage),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          formatTimestamp(chat.lastMessageTime),
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        if (chat.unreadMessagesCount > 0)
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.pink,
                            child: Text(
                              chat.unreadMessagesCount.toString(),
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                      ],
                    ),
                    onTap: () {
                      // Get.to(() => ChatroomView(), arguments: chat.chatId);
                      Get.to(
                        () => ChatroomView(
                          chatId: chat.chatId,
                          doctorName: chat.doctorName,
                          doctorProfilePicture: chat.doctorProfilePicture,
                        ),
                      );
                      Get.lazyPut<ChatroomController>(
                        () => ChatroomController(),
                      );
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
