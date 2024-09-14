import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Untuk mendapatkan user ID

class ChatController extends GetxController {
  var doctors = <Map<String, dynamic>>[].obs;
  var filteredDoctors = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDoctors();
  }

  // Fungsi untuk mengambil data dokter dari Firestore
  void fetchDoctors() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('doctor').get();
      var doctorsList = snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();

      // Ambil pesan terakhir untuk setiap dokter
      for (var doctor in doctorsList) {
        final lastMessage = await _getLastMessage(doctor['id']);
        doctor['lastMessage'] = lastMessage['text'];
        doctor['lastMessageTime'] = lastMessage['timestamp'];
      }

      doctors.value = doctorsList;
      filteredDoctors.value = doctorsList;
    } catch (e) {
      print("Error fetching doctors: $e");
    }
  }

  // Ambil pesan terakhir dari chat room
  Future<Map<String, dynamic>> _getLastMessage(String doctorId) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid; // Mendapatkan user ID
      final roomId = _generateRoomId(userId, doctorId);
      final snapshot = await FirebaseFirestore.instance
          .collection('chatRooms')
          .doc(roomId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final lastMessageData = snapshot.docs.first.data() as Map<String, dynamic>;
        return {
          'text': lastMessageData['text'] ?? 'No message',
          'timestamp': lastMessageData['timestamp'] ?? null,
        };
      }
      return {'text': 'No message', 'timestamp': null};
    } catch (e) {
      print("Error fetching last message: $e");
      return {'text': 'Error', 'timestamp': null};
    }
  }

  // Fungsi untuk generate roomId unik berdasarkan userId dan doctorId
  String _generateRoomId(String userId, String doctorId) {
    return userId.compareTo(doctorId) > 0 ? '$userId\_$doctorId' : '$doctorId\_$userId';
  }

  // Fungsi untuk mencari dokter
  void search(String query) {
    filteredDoctors.value = doctors.where((doctor) {
      final nameLower = doctor['name'].toString().toLowerCase();
      final searchLower = query.toLowerCase();
      return nameLower.contains(searchLower);
    }).toList();
  }
}
