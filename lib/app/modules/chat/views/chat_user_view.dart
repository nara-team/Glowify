// chat_user_view.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatUserPageView extends StatefulWidget {
  final String userId;
  const ChatUserPageView({required this.userId, Key? key}) : super(key: key);

  @override
  _ChatUserPageViewState createState() => _ChatUserPageViewState();
}

class _ChatUserPageViewState extends State<ChatUserPageView> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _messageController = TextEditingController();
  List<QueryDocumentSnapshot> _messages = [];
  String? roomId;
  String? doctorId;

  @override
  void initState() {
    super.initState();
    _setRoomId();
  }

  // Membuat roomId yang unik berdasarkan userId dan doctorId
  void _setRoomId() {
    doctorId = _auth.currentUser!.uid; // Mendapatkan doctorId dari currentUser
    roomId = _generateRoomId(widget.userId, doctorId!);
    _fetchMessages();
  }

  // Membuat roomId unik berdasarkan kombinasi userId dan doctorId
  String _generateRoomId(String userId, String doctorId) {
    if (userId.compareTo(doctorId) > 0) {
      return '$userId\_$doctorId'; // Membuat roomId dengan urutan userId dulu
    } else {
      return '$doctorId\_$userId'; // Jika tidak, doctorId dulu
    }
  }

  // Mengambil pesan dari room chat yang spesifik
  void _fetchMessages() {
    if (roomId == null) return;

    _firestore
        .collection('chatRooms')
        .doc(roomId) // Mengambil berdasarkan roomId
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      setState(() {
        _messages = snapshot.docs;
      });
    });
  }

  // Mengirim pesan ke room chat yang spesifik
  Future<void> _sendMessage() async {
    if (_messageController.text.isNotEmpty && roomId != null) {
      await _firestore.collection('chatRooms').doc(roomId).collection('messages').add({
        'text': _messageController.text,
        'sender': doctorId, // Menggunakan doctorId untuk identifikasi pengirim
        'timestamp': FieldValue.serverTimestamp(),
        'receiverId': widget.userId,
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat dengan Pengguna'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              reverse: true, // Pesan terakhir di bawah
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isDoctorMessage = message['sender'] == doctorId;
                return Align(
                  alignment: isDoctorMessage ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: isDoctorMessage ? Colors.green[100] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      message['text'],
                      style: const TextStyle(fontSize: 16),
                      textAlign: isDoctorMessage ? TextAlign.right : TextAlign.left,
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
                      hintText: 'Ketik pesan',
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
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
