import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatDoctorPageView extends StatefulWidget {
  final String doctorId;
  const ChatDoctorPageView({required this.doctorId, Key? key}) : super(key: key);

  @override
  _ChatDoctorPageViewState createState() => _ChatDoctorPageViewState();
}

class _ChatDoctorPageViewState extends State<ChatDoctorPageView> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _messageController = TextEditingController();
  List<QueryDocumentSnapshot> _messages = [];
  String? roomId;

  @override
  void initState() {
    super.initState();
    _setRoomId();
  }

  // Membuat roomId yang unik berdasarkan userId dan doctorId
  void _setRoomId() {
    String userId = _auth.currentUser!.uid;
    roomId = _generateRoomId(userId, widget.doctorId);
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
        'sender': _auth.currentUser!.uid, // Menggunakan userId untuk identifikasi pengirim
        'timestamp': FieldValue.serverTimestamp(),
        'doctorId': widget.doctorId,
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat with Doctor')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              reverse: true, // Pesan terakhir di bawah
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUserMessage = message['sender'] == _auth.currentUser!.uid;
                return Align(
                  alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: isUserMessage ? Colors.blue[100] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      message['text'],
                      style: const TextStyle(fontSize: 16),
                      textAlign: isUserMessage ? TextAlign.right : TextAlign.left,
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
