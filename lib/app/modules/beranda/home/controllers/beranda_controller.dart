import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

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
      "iconPath": "assets/icons/stethoscope.svg",
      "caption": "Konsultasi\nDoctor",
    },
    {
      "route": "/face-detection",
      "iconPath": "assets/icons/face-recognition.svg",
      "caption": "Deteksi\nKesehatan Wajah",
    },
    {
      "route": "/booking",
      "iconPath": "assets/icons/klinikbuilding.svg",
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


  final GlobalKey featureHighlightKey = GlobalKey();
  final List<GlobalKey> featureButtonKeys = [];

  List<TargetFocus> targets = [];

  // Method untuk inisialisasi target highlight
  void initTargets(List<Map<String, dynamic>> features) {
    // Tambahkan target untuk judul "Feature"
    targets.add(
      TargetFocus(
        identify: "Feature",
        keyTarget: featureHighlightKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Feature Highlight",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 24.0,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Di sini Anda dapat menemukan berbagai fitur yang tersedia di aplikasi kami.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    // Tambahkan target untuk setiap FeatureButton
    for (int i = 0; i < featureButtonKeys.length; i++) {
      targets.add(
        TargetFocus(
          identify: "FeatureButton_$i",
          keyTarget: featureButtonKeys[i],
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Fitur ${features[i]['caption']}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 24.0,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Ketuk untuk melihat lebih lanjut tentang fitur ${features[i]['caption']}.",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  // Method untuk memulai tutorial
  void showTutorial(BuildContext context) {
    TutorialCoachMark(
      targets: targets,
      colorShadow: Colors.black.withOpacity(0.7),
      textSkip: "Lewati",
      onFinish: () {
        debugPrint("Tutorial selesai");
      },
      onSkip: () {
        debugPrint("Tutorial dilewati");
        return true;
      },
      onClickTarget: (target) {
        debugPrint("Target ditekan: ${target.identify}");
      },
    ).show(context: context);
  }
}
