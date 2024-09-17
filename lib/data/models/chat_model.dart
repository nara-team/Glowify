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
      doctorProfilePicture; // Add this field to store the doctor's profile picture URL
  int unreadMessagesCount;

  Chat({
    required this.chatId,
    required this.userId,
    required this.doctorId,
    required this.userName,
    required this.doctorName,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.doctorProfilePicture, // Initialize this field
    this.unreadMessagesCount = 0,
  });

  // Factory constructor to create Chat from Firestore document
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
          'https://example.com/default.jpg', // Pastikan ini terisi default
      unreadMessagesCount: data['unreadMessagesCount'] ?? 0,
    );
  }

  // Convert Chat object to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'doctorId': doctorId,
      'userName': userName,
      'doctorName': doctorName,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime,
      'profilePicture': doctorProfilePicture, // Add profile picture to the map
      'unreadMessagesCount': unreadMessagesCount,
    };
  }

  // Define the copyWith method
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
