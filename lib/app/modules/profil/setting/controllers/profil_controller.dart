import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/widget/custom_bottomsheet.dart';
import 'package:iconsax/iconsax.dart';

class ProfilController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final RxString name = ''.obs;
  final RxString email = ''.obs;
  final RxString imageUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  void fetchUserData() async {
    try {
      String uid = _auth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      name.value = userDoc['fullName'] ?? 'No Name';
      email.value = userDoc['email'] ?? 'No Email';
      imageUrl.value = userDoc['photoURL'] ?? 'https://example.com/default.jpg';
    } catch (e) {
      debugPrint("");
    }
  }

  void showLogoutModal() async {
    await showCustomBottomSheet(
      title: 'Yakin keluar?',
      actions: [
        BottomSheetAction(
          icon: Iconsax.logout,
          label: 'Keluar',
          iconColor: primaryColor,
          onTap: () async {
            try {
              await _auth.signOut();
              Get.offAllNamed('/login');
            } catch (e) {
              debugPrint(e.toString());
            }
          },
        ),
        BottomSheetAction(
          icon: Iconsax.close_circle,
          label: 'Batal',
          onTap: () {
            Get.back();
          },
        ),
      ],
    );
  }
}
