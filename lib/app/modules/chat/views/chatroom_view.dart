import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:intl/intl.dart';
import 'package:glowify/app/modules/chat/controllers/chatroom_controller.dart';

class ChatroomView extends GetView<ChatroomController> {
  final String chatId;
  final String doctorName;
  final String doctorProfilePicture;

  const ChatroomView({
    required this.chatId,
    required this.doctorName,
    required this.doctorProfilePicture,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Periksa apakah nilai-nilai tidak kosong sebelum melanjutkan
    assert(chatId.isNotEmpty, "chatId tidak boleh kosong");
    assert(doctorName.isNotEmpty, "doctorName tidak boleh kosong");
    assert(doctorProfilePicture.isNotEmpty, "doctorProfilePicture tidak boleh kosong");

    final TextEditingController messageController = TextEditingController();
    String userId = FirebaseAuth.instance.currentUser!.uid;

    // Fetch messages when the view is built
    controller.fetchMessages(chatId);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(doctorProfilePicture),
              radius: 20,
            ),
            SizedBox(width: 10),
            Text(
              doctorName,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.messages.isEmpty) {
                return Center(child: Text("Belum ada pesan"));
              }
              return ListView.builder(
                reverse: true,
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  bool isSender = message.senderId == userId;

                  return Align(
                    alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isSender ? primaryColor : secondaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            message.message,
                            style: TextStyle(color: whiteBackground1Color),
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                DateFormat('hh:mm a').format(message.timestamp.toDate()),
                                style: TextStyle(fontSize: 12, color: whiteBackground1Color),
                              ),
                              SizedBox(width: 5),
                              if (isSender)
                                Icon(
                                  message.isRead ? Icons.done_all : Icons.done,
                                  color: message.isRead ? whiteBackground1Color : Colors.grey,
                                  size: 16,
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: primaryColor,
                  ),
                  onPressed: () {
                    if (messageController.text.isNotEmpty) {
                      controller.sendMessage(
                        chatId,
                        messageController.text,
                        "text",
                      );
                      messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
