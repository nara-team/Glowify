import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BerandaController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var userName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserName();
  }

  void fetchUserName() async {
    try {
      String uid = _auth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      userName.value = userDoc['fullName'] ?? 'No Name';
    } catch (e) {
      debugPrint("gagal mendapatkan userdata");
    }
  }

  final List<Map<String, dynamic>> fetureDraftModel = [
    {
      "route": "/konsultasi",
      "iconPath": "assets/images/stethoscope.svg",
      "caption": "Konsultasi\nDoctor",
    },
    {
      "route": "/face-detection",
      "iconPath": "assets/images/face-recognition.svg",
      "caption": "Deteksi\nKesehatan Wajah",
    },
    {
      "route": "/booking",
      "iconPath": "assets/images/Vector.svg",
      "caption": "Booking Klinik\nkecantikan",
    },
  ].obs;

  final List<Map<String, dynamic>> imagesliderModel = [
    {
      "route": "",
      "iconPath": "assets/images/banner_home.png",
    },
    {
      "route": "",
      "iconPath": "assets/images/banner_home.png",
    },
    {
      "route": "",
      "iconPath": "assets/images/banner_home.png",
    },
  ].obs;
}
