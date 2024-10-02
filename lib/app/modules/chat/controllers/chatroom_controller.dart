import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/data/models/message_model.dart';

class ChatroomController extends GetxController {
  var messages = <Message>[].obs;
  var doctorName = ''.obs;
  var doctorProfilePicture = ''.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    final chatId = Get.arguments as String?;
    if (chatId != null) {
      fetchDoctorData(chatId);
      fetchMessages(chatId);
    } else {
      Get.snackbar('Error', 'Chat ID is missing');
    }
  }

  void fetchDoctorData(String chatId) async {
    try {
      final chatDoc = await FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId)
          .get();

      if (chatDoc.exists) {
        final chatData = chatDoc.data() as Map<String, dynamic>;
        final doctorId = chatData['doctorId'];

        if (doctorId != null) {
          final doctorDoc = await FirebaseFirestore.instance
              .collection('doctor')
              .doc(doctorId)
              .get();

          if (doctorDoc.exists) {
            final doctorData = doctorDoc.data() as Map<String, dynamic>;
            doctorName.value = doctorData['name'] ?? 'Unknown Doctor';
            doctorProfilePicture.value = doctorData['profilePicture'] ?? '';
          } else {
            doctorName.value = 'Unknown Doctor';
            doctorProfilePicture.value = '';
          }
        } else {
          doctorName.value = 'Unknown Doctor';
          doctorProfilePicture.value = '';
        }
      } else {
        doctorName.value = 'Unknown Doctor';
        doctorProfilePicture.value = '';
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load doctor data: $e');
    }
  }

  void fetchMessages(String chatId) async {
    try {
      final chatDoc = await FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId)
          .get();

      if (chatDoc.exists) {
        final chatData = chatDoc.data() as Map<String, dynamic>;

        doctorName.value = chatData['doctorName'] ?? 'Unknown Doctor';
        doctorProfilePicture.value = chatData['doctorProfilePicture'] ?? '';

        FirebaseFirestore.instance
            .collection('chats')
            .doc(chatId)
            .collection('messages')
            .orderBy('timestamp', descending: true)
            .snapshots()
            .listen((snapshot) {
          messages.value = snapshot.docs.map((doc) {
            final message = Message.fromFirestore(doc);

            if (!message.isRead && message.senderId != _auth.currentUser!.uid) {
              markMessageAsRead(chatId, message.messageId);
            }
            return message;
          }).toList();
        });
      } else {
        doctorName.value = 'Unknown Doctor';
        doctorProfilePicture.value = '';
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load messages: $e');
    }
  }

  Future<void> markMessageAsRead(String chatId, String messageId) async {
    try {
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .doc(messageId)
          .update({'isRead': true});
    } catch (e) {
      debugPrint('Error marking message as read: $e');
    }
  }

  Future<void> sendMessage(
      String chatId, String messageContent, String messageType) async {
    try {
      String senderId = _auth.currentUser!.uid;

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(senderId)
          .get();

      String senderName = 'Anonymous';
      if (userDoc.exists) {
        senderName = userDoc['fullName'] ?? 'Anonymous';
      }

      final messageRef = FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .doc();

      final newMessage = Message(
        messageId: messageRef.id,
        senderId: senderId,
        senderName: senderName,
        message: messageContent,
        messageType: messageType,
        timestamp: Timestamp.now(),
        isRead: false,
      );

      await messageRef.set(newMessage.toFirestore());

      FirebaseFirestore.instance.collection('chats').doc(chatId).update({
        'lastMessage': messageContent,
        'lastMessageTime': Timestamp.now(),
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to send message: $e');
      debugPrint('Error: $e');
    }
  }
}
