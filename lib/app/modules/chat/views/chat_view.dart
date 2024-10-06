import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/app/modules/chat/controllers/chat_controller.dart';
import 'package:glowify/app/modules/chat/controllers/chatroom_controller.dart';
import 'package:glowify/app/modules/chat/views/chatroom_view.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/app/theme/sized_theme.dart';
import 'package:glowify/widget/customsearchtextfield.dart';
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
                      backgroundColor: primaryColor,
                      radius: 25,
                      backgroundImage: controller.imageUrl.isEmpty
                          ? null
                          : NetworkImage(controller.imageUrl.value),
                      child: controller.imageUrl.isEmpty
                          ? const Icon(
                              Icons.person,
                              color: whiteBackground1Color,
                              size: 30,
                            )
                          : null,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.name.value,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink,
                          ),
                        ),
                        Text(
                          controller.email.value,
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
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
              child: CustomSearchTextField(
                onChanged: (query) {},
                hintText: "Cari pesan...",
              )),
          Expanded(
            child: Obx(() {
              if (controller.chats.isEmpty) {
                return const Center(
                  child: Text('belum ada riwayat pesan'),
                );
              }
              return ListView.builder(
                itemCount: controller.chats.length,
                itemBuilder: (context, index) {
                  final chat = controller.chats[index];
                  return ListTile(
                    contentPadding:
                        PaddingCustom().paddingHorizontalVertical(16, 8),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(chat.doctorProfilePicture),
                      radius: 25,
                      onBackgroundImageError: (error, stackTrace) {
                        debugPrint('Error loading image: $error');
                      },
                      child: chat.doctorProfilePicture.isEmpty
                          ? const Icon(Icons.person)
                          : null,
                    ),
                    title: Text(
                      chat.doctorName,
                      style: const TextStyle(
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
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        if (chat.unreadMessagesCount > 0)
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.pink,
                            child: Text(
                              chat.unreadMessagesCount.toString(),
                              style: const TextStyle(
                                  fontSize: 12, color: whiteBackground1Color),
                            ),
                          ),
                      ],
                    ),
                    onTap: () {
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
