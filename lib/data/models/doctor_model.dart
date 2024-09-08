import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorModel {
  String? id;
  String? name;
  String? specialization;
  String? photoDoctor;

  DoctorModel({
    this.id,
    this.name,
    this.specialization,
    this.photoDoctor,
  });

  factory DoctorModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return DoctorModel(
      id: doc.id,
      name: data['name'] ?? 'Nama tidak diketahui',
      specialization: data['specialization'] ?? 'Spesialisasi tidak diketahui',
      photoDoctor: data['photo_doctor'] ?? 'no image available',
    );
  }
}
