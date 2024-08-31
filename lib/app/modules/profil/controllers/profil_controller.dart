import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      name.value = userDoc['fullName'] ?? 'No Name';
      email.value = userDoc['email'] ?? 'No Email';
      imageUrl.value = userDoc['photoURL'] ?? 'https://example.com/default.jpg';
    } catch (e) {
      Get.snackbar('Error', 'Failed to load user data');
    }
  }

  Future<void> updateProfile({String? newName, String? newEmail, File? newImageFile}) async {
    try {
      String uid = _auth.currentUser!.uid;
      String? downloadUrl;

      // Upload new profile image if provided
      if (newImageFile != null) {
        Reference storageRef = FirebaseStorage.instance.ref().child('profile_images/$uid.png');
        UploadTask uploadTask = storageRef.putFile(newImageFile);
        TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
        downloadUrl = await snapshot.ref.getDownloadURL();
      }

      // Update Firestore with the new data
      Map<String, dynamic> updateData = {};
      if (newName != null && newName.isNotEmpty) updateData['fullName'] = newName;
      if (newEmail != null && newEmail.isNotEmpty) updateData['email'] = newEmail;
      if (downloadUrl != null) updateData['photoURL'] = downloadUrl;

      await FirebaseFirestore.instance.collection('users').doc(uid).update(updateData);

      // Update local data
      if (newName != null && newName.isNotEmpty) name.value = newName;
      if (newEmail != null && newEmail.isNotEmpty) email.value = newEmail;
      if (downloadUrl != null) imageUrl.value = downloadUrl;

      Get.snackbar('Success', 'Profile updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile');
    }
  }

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

  void logout() async {
    try {
      await _auth.signOut();
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar('Error', 'Failed to logout');
    }
  }
}
