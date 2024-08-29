import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      userName.value = userDoc['fullName'] ?? 'No Name';
    } catch (e) {
      Get.snackbar('Error', 'Failed to load user data');
    }
  }

  void logout() async {
    try {
      await _auth.signOut();
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar('Error', 'Failed to logout');
    }
  }

  final List<Map<String, dynamic>> fetureDraftModel = [
    {
      "route": "",
      "iconPath": "assets/images/stethoscope.png",
      "caption": "Konsultasi\nDoctor",
    },
    {
      "route": "/face-detection",
      "iconPath": "assets/images/face-recognition.png",
      "caption": "Deteksi\nKesehatan Wajah",
    },
    {
      "route": "",
      "iconPath": "assets/images/klinik.png",
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

  final List<Map<String, dynamic>> trendingTutorialModel = [
    {
      "route": "",
      "iconPath": "assets/images/banner_home.png",
      "contentText": "Cara Memutihkan Kulit dan Faktor Penyebab Gelapnya Kulit"
    },
    {
      "route": "",
      "iconPath": "assets/images/banner_home.png",
      "contentText": "Cara Memutihkan Kulit dan Faktor Penyebab Gelapnya Kulit"
    },
    {
      "route": "",
      "iconPath": "assets/images/banner_home.png",
      "contentText": "Cara Memutihkan Kulit dan Faktor Penyebab Gelapnya Kulit"
    },
    {
      "route": "",
      "iconPath": "assets/images/banner_home.png",
      "contentText": "Cara Memutihkan Kulit dan Faktor Penyebab Gelapnya Kulit"
    },
    {
      "route": "",
      "iconPath": "assets/images/banner_home.png",
      "contentText": "Cara Memutihkan Kulit dan Faktor Penyebab Gelapnya Kulit"
    },
  ].obs;
}
