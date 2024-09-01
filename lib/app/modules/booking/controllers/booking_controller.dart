import 'package:get/get.dart';

class BookingController extends GetxController {
  final List<Map<String, dynamic>> dataKlinikModel = [
    {
      "route": "",
      "imagepath": "assets/images/klinik_1.png",
      "title": "Royal Hospital Surabaya",
      "operasionalStart": "00.00",
      "operasionalEnd": "24.00",
      "address": {
        'provinsi': 'Jawa Timur',
        'kota': 'banyuwangi',
        'kecamatan': 'siliragung',
        'desa': 'barurejo',
        'jalan': 'jl. patung gandrung',
        'kode_pos': 68488,
        'additional': 'samping indomaret',
      },
      "distance": 16,
      "avaible_doctor": [
        {
          "doctorname": "Dr. Andini Putri",
          "photo_doctor": "assets/images/dokter_1.jpeg",
          "spesialis": "Spesialis Dermatologi",
        },
        {
          "doctorname": "dr. Adi Agung Anantawijaya Daryago, Sp.DV",
          "photo_doctor": "assets/images/dokter_1.jpeg",
          "spesialis": "Spesialis Dermatologi",
        },
        {
          "doctorname": "dr. Agni Anastasia Sahulata, Sp.KK",
          "photo_doctor": "assets/images/dokter_1.jpeg",
          "spesialis": "Spesialis Kulit dan Kelamin",
        },
      ],
    },
    {
      "route": "",
      "imagepath": "assets/images/klinik_1.png",
      "title": "Al Huda",
      "operasionalStart": "00.00",
      "operasionalEnd": "24.00",
      "address": {
        'provinsi': 'Jawa Timur',
        'kota': 'banyuwangi',
        'kecamatan': 'genteng',
        'desa': 'stail',
        'jalan': 'jl. kenangan',
        'kode_pos': 68456,
        'additional': 'samping warung pak cik',
      },
      "distance": 68,
      "avaible_doctor": [
        {
          "doctorname": "dr. Andravita Fenti Mitaart, Sp.KK",
          "photo_doctor": "assets/images/dokter_1.jpeg",
          "spesialis": "Spesialis Dermatologi",
        },
        {
          "doctorname": "Dr. Ayu Nur Ain H. Sp.D.V.E, FINSDV",
          "photo_doctor": "assets/images/dokter_1.jpeg",
          "spesialis": "Spesialis Dermatologi",
        },
      ],
    },
  ].obs;

  List<Map<String, dynamic>> getAllDoctors() {
    List<Map<String, dynamic>> allDoctors = [];
    for (var klinik in dataKlinikModel) {
      allDoctors.addAll(klinik['avaible_doctor']);
    }
    return allDoctors;
  }

  final RxList<Map<String, dynamic>> filteredDataKlinikModel =
      <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();

    filteredDataKlinikModel.addAll(dataKlinikModel);
  }

  void searchKlinik(String query) {
    if (query.isEmpty) {
      filteredDataKlinikModel.assignAll(dataKlinikModel);
    } else {
      filteredDataKlinikModel.assignAll(
        dataKlinikModel.where((klinik) {
          final title = klinik['title'].toString().toLowerCase();
          final address = klinik['address'] as Map<String, dynamic>;

          final addressContainsQuery = address.values.any((value) {
            return value.toString().toLowerCase().contains(query.toLowerCase());
          });
          return title.contains(query.toLowerCase()) || addressContainsQuery;
        }).toList(),
      );
    }
  }
}
