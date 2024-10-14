import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  var isLoading = true.obs;
  Position? currentPosition;

  @override
  void onInit() {
    super.onInit();
    _getLocation();

    _getLocationAndFetchKlinik();
  }

  Future<void> _getLocationAndFetchKlinik() async {
    await _getLocation();
    fetchKlinikList();
  }

  Future<void> fetchKlinikList() async {
    isLoading.value = true;
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('klinik').get();

      var klinikData = snapshot.docs.map((doc) {
        final klinik = Klinik.fromFirestore(doc);

        if (klinik.kordinat != null) {
          debugPrint(
              "Kordinat klinik ${klinik.namaKlinik}: ${klinik.kordinat!.latitude}, ${klinik.kordinat!.longitude}");
        } else {
          debugPrint("Kordinat klinik ${klinik.namaKlinik} tidak tersedia");
        }

        if (currentPosition != null && klinik.kordinat != null) {
          klinik.distance = calculateDistance(
            currentPosition!.latitude,
            currentPosition!.longitude,
            klinik.kordinat!.latitude,
            klinik.kordinat!.longitude,
          );
          debugPrint(
              "Jarak ke klinik ${klinik.namaKlinik}: ${klinik.distance} meter");
        } else {
          klinik.distance = null;
          debugPrint("Kordinat klinik atau posisi pengguna tidak tersedia");
        }

        return klinik;
      }).toList();

      klinikList.value = klinikData;
    } catch (e) {
      Get.snackbar('Error', 'Error fetching klinik data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  double calculateDistance(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    return Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
  }

  Future<void> _getLocation() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      try {
        currentPosition = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        debugPrint(
            "Lokasi pengguna: ${currentPosition!.latitude}, ${currentPosition!.longitude}");

        await _getAddressFromLatLng(currentPosition!);
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
