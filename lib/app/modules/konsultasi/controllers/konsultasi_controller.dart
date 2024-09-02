import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Doctor {
  final String name;
  final String specialty;
  final String image;

  Doctor({
    required this.name,
    required this.specialty,
    required this.image,
  });

  factory Doctor.fromMap(Map<String, dynamic> data) {
    return Doctor(
      name: data['name'] ?? '',
      specialty: data['specialization'] ?? '',
      image: data['image'] ?? 'assets/images/doctor.jpg',
    );
  }
}

class KonsultasiController extends GetxController {
  var doctors = <Doctor>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDoctors();
  }

  void fetchDoctors() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final querySnapshot = await firestore.collection('doctor').get();
      final allDoctors = querySnapshot.docs
          .map((doc) => Doctor.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      doctors.assignAll(allDoctors);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch doctors', snackPosition: SnackPosition.BOTTOM);
    }
  }
}
