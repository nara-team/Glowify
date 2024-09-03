import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glowify/data/models/doctor_model.dart';

class BookingdetailController extends GetxController {
  final _firestore = FirebaseFirestore.instance;

  // Objek untuk menyimpan daftar dokter
  var doctorList = <DoctorModel>[].obs;

  // Fungsi untuk mengambil data dokter berdasarkan ID dokter yang terkait dengan klinik
  Future<void> fetchDoctorsForKlinik(List<String> doctorIds) async {
    try {
      if (doctorIds.isNotEmpty) {
        QuerySnapshot snapshot = await _firestore
            .collection('doctor')
            .where(FieldPath.documentId, whereIn: doctorIds)
            .get();

        // Mengubah data snapshot menjadi daftar DoctorModel
        doctorList.value = snapshot.docs.map((doc) {
          return DoctorModel.fromFirestore(doc);
        }).toList();
      } else {
        doctorList.clear(); // Menghapus data jika tidak ada dokter
      }
    } catch (e) {
      print("Error fetching doctors: $e");
    }
  }
}
