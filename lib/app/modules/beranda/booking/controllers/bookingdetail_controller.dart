import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glowify/data/models/doctor_model.dart';

class BookingdetailController extends GetxController {
  var doctors = <Doctor>[].obs;

  Future<void> fetchDoctorsForKlinik(List<String> doctorIds) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('doctor')
          .where(FieldPath.documentId, whereIn: doctorIds)
          .get();

      doctors.value =
          snapshot.docs.map((doc) => Doctor.fromFirestore(doc)).toList();
    } catch (e) {
      Get.snackbar('Error', 'Error fetching doctors: $e');
    }
  }
}
