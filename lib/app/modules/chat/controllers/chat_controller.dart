import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  var doctors = <Map<String, dynamic>>[].obs; // List observasi untuk menyimpan data dokter
  var filteredDoctors = <Map<String, dynamic>>[].obs; // List observasi untuk menyimpan data pencarian dokter

  @override
  void onInit() {
    super.onInit();
    fetchDoctors(); // Memanggil fungsi untuk mengambil data dokter saat inisialisasi
  }

  // Fungsi untuk mengambil data dokter dari koleksi Firestore
  void fetchDoctors() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('doctor').get();
      doctors.value = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      filteredDoctors.value = doctors; // Inisialisasi list yang difilter dengan data dokter yang sama
    } catch (e) {
      print("Error fetching doctors: $e");
    }
  }

  // Fungsi untuk mencari dokter berdasarkan nama
  void search(String query) {
    filteredDoctors.value = doctors.where((doctor) {
      final nameLower = doctor['name'].toString().toLowerCase();
      final searchLower = query.toLowerCase();
      return nameLower.contains(searchLower);
    }).toList();
  }
}
