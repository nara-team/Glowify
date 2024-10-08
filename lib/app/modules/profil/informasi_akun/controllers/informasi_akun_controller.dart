import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/widget/custom_bottomsheet.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

class InformasiAkunController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  var isEditing = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final RxString name = ''.obs;
  final RxString email = ''.obs;
  final RxString imageUrl = ''.obs;

  var selectedImageFile = Rx<File?>(null);

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

      nameController.text = name.value;
      emailController.text = email.value;
    } catch (e) {
      debugPrint("Error fetching user data: $e");
    }
  }

  void toggleEditingMode() {
    isEditing.value = !isEditing.value;
  }

  Future<void> showImagePickerBottomSheet(BuildContext context) async {
    final picker = ImagePicker();
    File? pickedImage;

    await showCustomBottomSheet(
      title: 'Pilih Gambar',
      actions: [
        BottomSheetAction(
          icon: Iconsax.camera,
          label: 'Kamera',
          onTap: () async {
            final pickedFile =
                await picker.pickImage(source: ImageSource.camera);
            if (pickedFile != null) {
              pickedImage = File(pickedFile.path);
            }
            Get.back();
          },
        ),
        BottomSheetAction(
          icon: Iconsax.gallery,
          label: 'Pilih dari Galeri',
          onTap: () async {
            final pickedFile =
                await picker.pickImage(source: ImageSource.gallery);
            if (pickedFile != null) {
              pickedImage = File(pickedFile.path);
            }
            Get.back();
          },
        ),
      ],
    );

    if (pickedImage != null) {
      selectedImageFile.value = pickedImage;
    }
  }

  Future<void> updateProfile() async {
    try {
      String uid = _auth.currentUser!.uid;
      String? downloadUrl;

      if (selectedImageFile.value != null) {
        downloadUrl = await uploadImage(selectedImageFile.value!);
      }

      Map<String, dynamic> updateData = {
        'fullName': nameController.text,
        'email': emailController.text,
      };

      if (downloadUrl != null) {
        updateData['photoURL'] = downloadUrl;
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update(updateData);

      name.value = nameController.text;
      email.value = emailController.text;
      if (downloadUrl != null) imageUrl.value = downloadUrl;

      Get.snackbar("Success", "Profile updated successfully.");
    } catch (e) {
      Get.snackbar("Error", "Failed to update profile: $e");
    }
  }

  Future<String?> uploadImage(File imageFile) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Get.snackbar("Error", "Please log in before uploading an image.");
        return null;
      } else {
        debugPrint("User authenticated: ${user.email}");
      }

      String uid = user.uid;
      Reference storageRef =
          FirebaseStorage.instance.ref().child('profile_images/$uid.png');
      UploadTask uploadTask = storageRef.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      debugPrint("Error uploading image: $e");
      return null;
    }
  }

  Future<void> changePassword() async {
    if (oldPasswordController.text.isEmpty ||
        newPasswordController.text.isEmpty) {
      Get.snackbar("Error", "Please enter both old and new passwords.");
      return;
    }

    try {
      User? user = _auth.currentUser;
      String email = user!.email!;

      AuthCredential credential = EmailAuthProvider.credential(
          email: email, password: oldPasswordController.text);
      await user.reauthenticateWithCredential(credential);

      await user.updatePassword(newPasswordController.text);

      Get.snackbar("Success", "Password updated successfully.");
    } catch (e) {
      Get.snackbar("Error", "Failed to update password: $e");
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    super.onClose();
  }
}
