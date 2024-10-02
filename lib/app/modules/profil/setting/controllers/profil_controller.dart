import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
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

  Future<void> updateProfile(
      {String? newName, String? newEmail, File? newImageFile}) async {
    try {
      String uid = _auth.currentUser!.uid;
      String? downloadUrl;

      if (newImageFile != null) {
        Reference storageRef =
            FirebaseStorage.instance.ref().child('profile_images/$uid.png');
        UploadTask uploadTask = storageRef.putFile(newImageFile);
        TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
        downloadUrl = await snapshot.ref.getDownloadURL();
      }

      Map<String, dynamic> updateData = {};
      if (newName != null && newName.isNotEmpty) {
        updateData['fullName'] = newName;
      }
      if (newEmail != null && newEmail.isNotEmpty) {
        updateData['email'] = newEmail;
      }
      if (downloadUrl != null) updateData['photoURL'] = downloadUrl;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update(updateData);

      if (newName != null && newName.isNotEmpty) name.value = newName;
      if (newEmail != null && newEmail.isNotEmpty) email.value = newEmail;
      if (downloadUrl != null) imageUrl.value = downloadUrl;

      debugPrint("");
    } catch (e) {
      debugPrint("");
    }
  }

  void pickImageAndEditProfile(String? newName, String? newEmail) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      File? newImageFile;
      if (pickedFile != null) {
        newImageFile = File(pickedFile.path);
      }

      updateProfile(
          newName: newName, newEmail: newEmail, newImageFile: newImageFile);
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  void showLogoutModal() async {
    await Get.bottomSheet(
      SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white, // Background putih
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                child: Text(
                  'Yakin keluar?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const Divider(thickness: 1),
              ListTile(
                leading: const Icon(Iconsax.logout, color: Colors.redAccent),
                title: const Text(
                  'Keluar',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.redAccent,
                  ),
                ),
                onTap: () async {
                  try {
                    await _auth.signOut();
                    Get.offAllNamed('/login');
                  } catch (e) {
                    debugPrint("");
                  }
                },
              ),
              const Divider(thickness: 1),
              ListTile(
                leading: const Icon(Iconsax.close_circle, color: Colors.black),
                title: const Text(
                  'Batal',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Get.back();
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
