import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glowify/data/models/doctor_model.dart';

class BookingdetailController extends GetxController {
  var doctors = <Doctor>[].obs;

  Future<void> fetchDoctorsForKlinik(List<String> doctorIds) async {
    try {
      List<Doctor> doctorList = [];
      for (var doctorId in doctorIds) {
        DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
            .collection('doctor')
            .doc(doctorId)
            .get();
        if (docSnapshot.exists) {
          doctorList.add(Doctor.fromFirestore(docSnapshot));
        }
      }
      doctors.value = doctorList;
    } catch (e) {
      Get.snackbar('Error', 'Error fetching doctors: $e');
    }
  }
}
