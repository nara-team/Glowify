import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:glowify/data/models/doctor_model.dart';
import 'package:glowify/data/models/klinik_model.dart';
import 'package:permission_handler/permission_handler.dart';

class BookingController extends GetxController {
  final _firestore = FirebaseFirestore.instance;

  var klinikList = <KlinikModel>[].obs;
  var doctorList = <DoctorModel>[].obs;
  final _currentAddress = "Mencari Lokasi Anda...".obs;

  var filteredKlinikList = <KlinikModel>[].obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _getLocation();
    fetchKlinikList();
  }

  Future<void> fetchKlinikList() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('klinik').get();
      klinikList.value = snapshot.docs.map((doc) {
        return KlinikModel.fromFirestore(doc);
      }).toList();
    } catch (e) {
      print("Error fetching klinik: $e");
    }
  }

  Future<void> fetchDoctorsForKlinik(List<String> doctorIds) async {
    try {
      if (doctorIds.isNotEmpty) {
        QuerySnapshot snapshot = await _firestore
            .collection('doctor')
            .where(FieldPath.documentId, whereIn: doctorIds)
            .get();

        doctorList.value = snapshot.docs.map((doc) {
          return DoctorModel.fromFirestore(doc);
        }).toList();
      } else {
        doctorList.clear();
      }
    } catch (e) {
      print("Error fetching doctors: $e");
    }
  }

  void onKlinikClicked(KlinikModel klinik) {
    fetchDoctorsForKlinik(klinik.idDoktor ?? []);
    Get.toNamed('/bookingdetail', arguments: klinik);
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
    update();
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
    update();
  }

  String get currentAddress => _currentAddress.value;
}
