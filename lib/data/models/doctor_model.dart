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
  List<Timestamp>? schedule;

  Doctor({
    this.doctorId,
    this.alumnus,
    this.doctorEmail,
    this.doctorName,
    this.profilePicture,
    this.specialization,
    this.strDoctor,
    this.userType,
    this.schedule,
  });

  factory Doctor.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Doctor(
      doctorId: doc.id,
      alumnus: List<String>.from(data['alumnus'] ?? []),
      doctorEmail: data['doctor_email'] ?? 'Email tidak diketahui',
      doctorName: data['doctor_name'] ?? 'Nama tidak diketahui',
      profilePicture: data['profilePicture'] ?? 'https://firebasestorage.googleapis.com/v0/b/glowifyapp-9bf8d.appspot.com/o/doctor_image%2Fdokter_avatar.jpg?alt=media&token=67704983-655d-4796-9b2f-9c86682a1726',
      specialization: data['specialization'] ?? 'Spesialisasi tidak diketahui',
      strDoctor: data['str_doctor'] ?? 'Nomor STR tidak diketahui',
      userType: data['user_type'] ?? 'Tipe pengguna tidak diketahui',
      schedule: List<Timestamp>.from(data['schedule'] ?? []),
    );  
  }
}
