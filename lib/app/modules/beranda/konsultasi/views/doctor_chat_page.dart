// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
// import '../controllers/konsultasi_controller.dart';

// class DoctorChatPage extends StatefulWidget {
//   final Doctor doctor;

//   DoctorChatPage({required this.doctor});

//   @override
//   _DoctorChatPageState createState() => _DoctorChatPageState();
// }

// class _DoctorChatPageState extends State<DoctorChatPage> {
//   final DatabaseReference _messagesRef = FirebaseDatabase.instance.ref().child('messages');
//   final TextEditingController _messageController = TextEditingController();
//   final List<Map<dynamic, dynamic>> _messages = [];

//   @override
//   void initState() {
//     super.initState();
//     _messagesRef.onChildAdded.listen((event) {
//       setState(() {
//         _messages.add(event.snapshot.value as Map<dynamic, dynamic>);
//       });
//     });
//   }

//   void _sendMessage() {
//     final messageText = _messageController.text.trim();
//     if (messageText.isNotEmpty) {
//       final messageData = {
//         'text': messageText,
//         'sender': 'user', // Adjust based on the sender
//         'timestamp': DateTime.now().toIso8601String(),
//       };
//       _messagesRef.push().set(messageData).then((_) {
//         _messageController.clear();
//       }).catchError((error) {
//         print("Failed to send message: $error");
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             CircleAvatar(
//               backgroundImage: AssetImage(widget.doctor.image),
//               radius: 20,
//             ),
//             SizedBox(width: 10),
//             Text(widget.doctor.name),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               padding: EdgeInsets.all(16),
//               itemCount: _messages.length,
//               itemBuilder: (context, index) {
//                 final message = _messages[index];
//                 final isUserMessage = message['sender'] == 'user';
//                 return Align(
//                   alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
//                   child: Container(
//                     margin: EdgeInsets.only(bottom: 10),
//                     padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
//                     decoration: BoxDecoration(
//                       color: isUserMessage ? Colors.pink[100] : Colors.grey[200],
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Text(
//                       message['text'],
//                       style: TextStyle(fontSize: 16),
//                       textAlign: isUserMessage ? TextAlign.right : TextAlign.left,
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: InputDecoration(
//                       hintText: 'Type a message',
//                       filled: true,
//                       fillColor: Colors.grey[200],
//                       contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 CircleAvatar(
//                   backgroundColor: Colors.pink,
//                   child: IconButton(
//                     icon: Icon(Icons.send, color: Colors.white),
//                     onPressed: _sendMessage,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
