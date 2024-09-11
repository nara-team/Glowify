import 'package:cloud_firestore/cloud_firestore.dart';

class Klinik {
  String? klinikId;

  List<String>? idDoktor;
  String? namaKlinik;
  String? photoKlinik;
  String? operationalStart;
  String? operationalEnd;
  Map<String, String>? alamatKlinik;

  Klinik({
    this.klinikId,
    this.alamatKlinik,
    this.idDoktor,
    this.namaKlinik,
    this.photoKlinik,
    this.operationalStart,
    this.operationalEnd,
  });

  factory Klinik.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final operationalData = data['operational'] ?? {};

    return Klinik(
      klinikId: doc.id,
      alamatKlinik: Map<String, String>.from(data['alamat_klinik'] ?? {}),
      idDoktor: List<String>.from(data['id_doktor'] ?? []),
      namaKlinik: data['nama_klinik'] ?? 'Nama tidak diketahui',
      photoKlinik: data['photo_klinik'] ?? 'assets/images/hospital_null.jpg',
      operationalStart: operationalData['start'] ?? 'Tidak tersedia',
      operationalEnd: operationalData['end'] ?? 'Tidak tersedia',
    );
  }
}
