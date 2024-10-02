import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:glowify/app/theme/app_theme.dart';

class ChatDoctorPageView extends StatefulWidget {
  final String doctorId;
  const ChatDoctorPageView({required this.doctorId, Key? key})
      : super(key: key);

  @override
  ChatDoctorPageViewState createState() => ChatDoctorPageViewState();
}

class ChatDoctorPageViewState extends State<ChatDoctorPageView> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _messageController = TextEditingController();
  List<QueryDocumentSnapshot> _messages = [];
  String? roomId;
  Map<String, dynamic>? doctorData;

  @override
  void initState() {
    super.initState();
    _setRoomId();
    _fetchDoctorData();
  }

  void _setRoomId() {
    String userId = _auth.currentUser!.uid;
    roomId = _generateRoomId(userId, widget.doctorId);
    _fetchMessages();
  }

  String _generateRoomId(String userId, String doctorId) {
    return userId.compareTo(doctorId) > 0
        ? '${userId}_$doctorId'
        : '${doctorId}_$userId';
  }

  void _fetchMessages() {
    if (roomId == null) return;

    _firestore
        .collection('chatRooms')
        .doc(roomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      setState(() {
        _messages = snapshot.docs;
      });
    });
  }

  void _fetchDoctorData() async {
    try {
      DocumentSnapshot doctorSnapshot =
          await _firestore.collection('doctor').doc(widget.doctorId).get();
      setState(() {
        doctorData = doctorSnapshot.data() as Map<String, dynamic>?;
      });
    } catch (e) {
      debugPrint("Error fetching doctor data: $e");
    }
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.isNotEmpty && roomId != null) {
      await _firestore
          .collection('chatRooms')
          .doc(roomId)
          .collection('messages')
          .add({
        'text': _messageController.text,
        'sender': _auth.currentUser!.uid,
        'timestamp': FieldValue.serverTimestamp(),
        'doctorId': widget.doctorId,
      });
      _messageController.clear();
    }
  }

  String _formatTimestamp(Timestamp timestamp) {
    final DateTime date = timestamp.toDate();
    return DateFormat('HH:mm').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: doctorData == null
            ? const Text('Loading...')
            : Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(doctorData!['photo_doctor'] ??
                        'https://example.com/default.jpg'),
                    radius: 20,
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      doctorData!['name'] ?? 'Doctor',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUserMessage =
                    message['sender'] == _auth.currentUser!.uid;
                final timestamp = message['timestamp'] as Timestamp?;

                return Align(
                  alignment: isUserMessage
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color:
                          isUserMessage ? Colors.blue[100] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: isUserMessage
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Text(
                          message['text'],
                          style: const TextStyle(fontSize: 16),
                          textAlign:
                              isUserMessage ? TextAlign.right : TextAlign.left,
                        ),
                        if (timestamp != null)
                          Text(
                            _formatTimestamp(timestamp),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: primaryColor),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
