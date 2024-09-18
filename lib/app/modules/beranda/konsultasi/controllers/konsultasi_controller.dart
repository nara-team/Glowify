import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../data/models/doctor_model.dart';
import '../../../../../data/models/klinik_model.dart';

class KonsultasiController extends GetxController {
  var doctors = <Doctor>[].obs;
  var klinik = Klinik().obs;

  @override
  void onInit() {
    fetchDoctors();
    super.onInit();
  }

  void fetchDoctors() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('doctor').get();

      doctors.value =
          snapshot.docs.map((doc) => Doctor.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error fetching doctors: $e');
    }
  }

  Future<void> fetchClinicByDoctorId(String doctorId) async {
    try {
      QuerySnapshot clinicSnapshot = await FirebaseFirestore.instance
          .collection('klinik')
          .where('id_doktor', arrayContains: doctorId)
          .get();

      if (clinicSnapshot.docs.isNotEmpty) {
        var clinicData = clinicSnapshot.docs.first;
        klinik.value = Klinik.fromFirestore(clinicData);
      } else {
        klinik.value = Klinik(
          namaKlinik: 'Tidak diketahui',
          alamatKlinik: {
            'desa': '',
            'kecamatan': '',
            'kabupaten': '',
            'provinsi': ''
          },
        );
      }
    } catch (e) {
      print('Error fetching clinic data: $e');
    }
  }
}
