import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  String chatId;
  String userId;
  String doctorId;
  String userName;
  String doctorName;
  String lastMessage;
  Timestamp lastMessageTime;
  String
      doctorProfilePicture;
  int unreadMessagesCount;

  Chat({
    required this.chatId,
    required this.userId,
    required this.doctorId,
    required this.userName,
    required this.doctorName,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.doctorProfilePicture,
    this.unreadMessagesCount = 0,
  });

  factory Chat.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Chat(
      chatId: doc.id,
      userId: data['userId'] ?? '',
      doctorId: data['doctorId'] ?? '',
      userName: data['userName'] ?? 'Unknown User',
      doctorName: data['doctorName'] ?? 'Unknown Doctor',
      lastMessage: data['lastMessage'] ?? 'No messages yet',
      lastMessageTime: data['lastMessageTime'] ?? Timestamp.now(),
      doctorProfilePicture: data['doctorProfilePicture'] ??
          'https://example.com/default.jpg',
      unreadMessagesCount: data['unreadMessagesCount'] ?? 0,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'doctorId': doctorId,
      'userName': userName,
      'doctorName': doctorName,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime,
      'profilePicture': doctorProfilePicture, 
      'unreadMessagesCount': unreadMessagesCount,
    };
  }

  Chat copyWith({
    String? chatId,
    String? userId,
    String? doctorId,
    String? userName,
    String? doctorName,
    String? lastMessage,
    Timestamp? lastMessageTime,
    String? doctorProfilePicture,
    int? unreadMessagesCount,
  }) {
    return Chat(
      chatId: chatId ?? this.chatId,
      userId: userId ?? this.userId,
      doctorId: doctorId ?? this.doctorId,
      userName: userName ?? this.userName,
      doctorName: doctorName ?? this.doctorName,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      doctorProfilePicture: doctorProfilePicture ?? this.doctorProfilePicture,
      unreadMessagesCount: unreadMessagesCount ?? this.unreadMessagesCount,
    );
  }
}
