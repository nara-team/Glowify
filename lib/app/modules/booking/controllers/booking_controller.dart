import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:glowify/data/models/doctor_model.dart';
import 'package:glowify/data/models/klinik_model.dart';
import 'package:permission_handler/permission_handler.dart';

class BookingController extends GetxController {
  final _currentAddress = "Mencari Lokasi Anda...".obs;
  var klinikList = <Klinik>[].obs;
  var selectedKlinik = Klinik().obs;
  var doctors = <Doctor>[].obs;

  @override
  void onInit() {
    super.onInit();
    _getLocation();
    fetchKlinikList();
  }

  Future<void> fetchKlinikList() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('klinik').get();

      var klinikData = snapshot.docs.map((doc) {
        return Klinik.fromFirestore(doc);
      }).toList();

      klinikList.value = klinikData;
    } catch (e) {
      Get.snackbar('Error', 'Error fetching klinik data: $e');
    }
  }

  Future<void> fetchKlinikDetail(String klinikId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('klinik')
          .doc(klinikId)
          .get();

      if (snapshot.exists) {
        selectedKlinik.value = Klinik.fromFirestore(snapshot);

        if (selectedKlinik.value.idDoktor != null &&
            selectedKlinik.value.idDoktor!.isNotEmpty) {
          fetchDoctorsForKlinik(selectedKlinik.value.idDoktor!);
        } else {
          Get.snackbar(
              'Info', 'Tidak ada dokter yang terdaftar di klinik ini.');
        }
      } else {
        Get.snackbar('Error', 'Klinik tidak ditemukan.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error fetching klinik detail: $e');
    }
  }

  Future<void> fetchDoctorsForKlinik(List<String> doctorIds) async {
    try {
      List<Doctor> doctorList = [];
      for (var doctorId in doctorIds) {
        DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
            .collection('doctors')
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

  Future<void> _getLocation() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        await _getAddressFromLatLng(position);
      } catch (e) {
        _currentAddress.value = "Failed to get location: $e";
      }
    } else if (status.isDenied) {
      _currentAddress.value = "Location permission denied.";
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    } else {
      _currentAddress.value = "Unable to access location.";
    }
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        _currentAddress.value =
            "${place.street}, ${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}";
      } else {
        _currentAddress.value = "No address available for this location.";
      }
    } catch (e) {
      _currentAddress.value = "Error occurred while getting address: $e";
    }
  }

  String get currentAddress => _currentAddress.value;
}
