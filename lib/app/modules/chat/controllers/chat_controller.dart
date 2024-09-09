// chat_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  var users = <Map<String, dynamic>>[].obs; // List observasi untuk menyimpan data pengguna
  var filteredUsers = <Map<String, dynamic>>[].obs; // List observasi untuk menyimpan data pencarian

  @override
  void onInit() {
    super.onInit();
    fetchUsers(); // Memanggil fungsi untuk mengambil data pengguna saat inisialisasi
  }

  // Fungsi untuk mengambil data pengguna dari koleksi Firestore 'users'
  void fetchUsers() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').get();
      users.value = snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id; // Menambahkan id dokumen ke data pengguna
        return data;
      }).toList();
      filteredUsers.value = users; // Inisialisasi list yang difilter dengan data pengguna yang sama
    } catch (e) {
      print("Error fetching users: $e");
    }
  }

  // Fungsi untuk mencari pengguna berdasarkan nama
  void search(String query) {
    filteredUsers.value = users.where((user) {
      final nameLower = user['fullName'].toString().toLowerCase();
      final searchLower = query.toLowerCase();
      return nameLower.contains(searchLower);
    }).toList();
  }
}
