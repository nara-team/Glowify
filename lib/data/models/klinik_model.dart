import 'package:cloud_firestore/cloud_firestore.dart';

class KlinikModel {
  String? id;
  String? namaKlinik;
  List<String>? idDoktor;
  Map<String, String>? alamatKlinik;
  Map<String, String>? operasional;
  String? photoKlinik;

  KlinikModel({
    this.id,
    this.namaKlinik,
    this.idDoktor,
    this.alamatKlinik,
    this.operasional,
    this.photoKlinik,
  });

  factory KlinikModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return KlinikModel(
      id: doc.id,
      namaKlinik: data['nama_klinik'] ?? 'Nama tidak diketahui',
      idDoktor: List<String>.from(data['id_doktor'] ?? []),
      alamatKlinik: Map<String, String>.from(data['alamat_klinik'] ?? {}),
      operasional: Map<String, String>.from(data['operational'] ?? {}),
      photoKlinik: data['photo_klinik'] ?? 'no image available',
    );
  }
}
