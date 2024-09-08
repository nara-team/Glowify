import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart'; // Tambahkan iconsax untuk ikon

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

  // Mengambil data user dari Firestore
  void fetchUserData() async {
    try {
      String uid = _auth.currentUser!.uid;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      name.value = userDoc['fullName'] ?? 'No Name';
      email.value = userDoc['email'] ?? 'No Email';
      imageUrl.value = userDoc['photoURL'] ?? 'https://example.com/default.jpg';
    } catch (e) {
      Get.snackbar('Error', 'Failed to load user data');
    }
  }

  // Fungsi untuk memperbarui profile user
  Future<void> updateProfile({String? newName, String? newEmail, File? newImageFile}) async {
    try {
      String uid = _auth.currentUser!.uid;
      String? downloadUrl;

      // Upload gambar baru jika ada
      if (newImageFile != null) {
        Reference storageRef = FirebaseStorage.instance.ref().child('profile_images/$uid.png');
        UploadTask uploadTask = storageRef.putFile(newImageFile);
        TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
        downloadUrl = await snapshot.ref.getDownloadURL();
      }

      // Update Firestore dengan data baru
      Map<String, dynamic> updateData = {};
      if (newName != null && newName.isNotEmpty) updateData['fullName'] = newName;
      if (newEmail != null && newEmail.isNotEmpty) updateData['email'] = newEmail;
      if (downloadUrl != null) updateData['photoURL'] = downloadUrl;

      await FirebaseFirestore.instance.collection('users').doc(uid).update(updateData);

      // Update data lokal
      if (newName != null && newName.isNotEmpty) name.value = newName;
      if (newEmail != null && newEmail.isNotEmpty) email.value = newEmail;
      if (downloadUrl != null) imageUrl.value = downloadUrl;

      Get.snackbar('Success', 'Profile updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile');
    }
  }

  // Fungsi untuk mengambil gambar dari galeri dan mengupdate profile
  void pickImageAndEditProfile(String? newName, String? newEmail) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.getImage(source: ImageSource.gallery);

      File? newImageFile;
      if (pickedFile != null) {
        newImageFile = File(pickedFile.path);
      }

      updateProfile(newName: newName, newEmail: newEmail, newImageFile: newImageFile);
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image');
    }
  }

  // Fungsi untuk menampilkan modal BottomSheet saat logout
  void showLogoutModal() async {
    await Get.bottomSheet(
      SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white, // Background putih
            borderRadius: const BorderRadius.only(
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
              const Divider(thickness: 1), // Divider untuk memisahkan heading
              
              // Tombol Konfirmasi Keluar
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
                    Get.offAllNamed('/login'); // Arahkan ke halaman login setelah logout
                  } catch (e) {
                    Get.snackbar('Error', 'Gagal untuk logout');
                  }
                },
              ),
              
              // Divider antara opsi
              const Divider(thickness: 1),
              
              // Tombol Batal
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
                  Get.back(); // Tutup bottom sheet tanpa melakukan apapun
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
