import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String messageId;
  String message;
  String messageType;
  String senderId;
  String senderName;
  Timestamp timestamp;
  bool isRead;

  Message({
    required this.messageId,
    required this.message,
    required this.messageType,
    required this.senderId,
    required this.senderName,
    required this.timestamp,
    this.isRead = false,
  });

  factory Message.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Message(
      messageId: doc.id,
      message: data['message'] ?? '',
      messageType: data['messageType'] ?? 'text',
      senderId: data['senderId'] ?? '',
      senderName: data['senderName'] ?? 'Unknown Sender',
      timestamp: data['timestamp'] ?? Timestamp.now(),
      isRead: data['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'message': message,
      'messageType': messageType,
      'senderId': senderId,
      'senderName': senderName,
      'timestamp': timestamp,
      'isRead': isRead,
    };
  }
}
