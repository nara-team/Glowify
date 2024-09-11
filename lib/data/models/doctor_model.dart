import 'package:cloud_firestore/cloud_firestore.dart';

class Doctor {
  String? doctorId;
  List<String>? alumnus;
  String? doctorEmail;
  String? doctorName;
  String? profilePicture;
  String? specialization;
  String? strDoctor;
  String? userType;

  Doctor({
    this.doctorId,
    this.alumnus,
    this.doctorEmail,
    this.doctorName,
    this.profilePicture,
    this.specialization,
    this.strDoctor,
    this.userType,
  });

  factory Doctor.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Doctor(
      doctorId: doc.id,
      alumnus: List<String>.from(data['alumus'] ?? []),
      doctorEmail: data['doctor_email'] ?? 'Email tidak diketahui',
      doctorName: data['doctor_name'] ?? 'Nama tidak diketahui',
      profilePicture:
          data['profilePicture'] ?? 'assets/images/doktor_null.jpg',
      specialization: data['specialization'] ?? 'Spesialisasi tidak diketahui',
      strDoctor: data['str_doctor'] ?? 'Nomor STR tidak diketahui',
      userType: data['user_type'] ?? 'Tipe pengguna tidak diketahui',
    );
  }
}
