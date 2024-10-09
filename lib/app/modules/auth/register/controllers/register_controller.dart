import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/widget/snackbar_custom.dart';

class RegisterController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController fullNameController;
  late TextEditingController confirmPasswordController;

  final RxString emailError = ''.obs;
  final RxString passwordError = ''.obs;
  final RxString confirmPasswordError = ''.obs;
  final RxString fullNameError = ''.obs;

  final RxBool emailValid = false.obs;
  final RxBool passwordValid = false.obs;
  final RxBool confirmPasswordValid = false.obs;
  final RxBool fullNameValid = false.obs;

  RxBool isPasswordHidden = true.obs;
  RxBool isConfirmPasswordHidden =
      true.obs; 
  RxBool isLoading = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    fullNameController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  void validateInputs() {
    emailError.value = '';
    passwordError.value = '';
    confirmPasswordError.value = '';
    fullNameError.value = '';
    emailValid.value = false;
    passwordValid.value = false;
    confirmPasswordValid.value = false;
    fullNameValid.value = false;

    if (emailController.text.isEmpty) {
      emailError.value = 'Email tidak boleh kosong';
    } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(emailController.text)) {
      emailError.value = 'Email tidak valid';
    } else {
      emailValid.value = true;
    }

    if (passwordController.text.isEmpty) {
      passwordError.value = 'Password tidak boleh kosong';
    } else if (passwordController.text.length < 8) {
      passwordError.value = 'Password minimal 8 karakter';
    } else if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).+$')
        .hasMatch(passwordController.text)) {
      passwordError.value = 'Password harus mengandung huruf dan angka';
    } else {
      passwordValid.value = true; 
    }

    
    if (confirmPasswordController.text.isEmpty) {
      confirmPasswordError.value = 'Konfirmasi password tidak boleh kosong';
    } else if (confirmPasswordController.text != passwordController.text) {
      confirmPasswordError.value = 'Password tidak sesuai';
    } else {
      confirmPasswordValid.value = true;
    }

    
    if (fullNameController.text.isEmpty) {
      fullNameError.value = 'Nama lengkap tidak boleh kosong';
    } else {
      fullNameValid.value = true; 
    }
  }

  Future<void> register() async {
    validateInputs();
    if (emailValid.value &&
        passwordValid.value &&
        confirmPasswordValid.value &&
        fullNameValid.value) {
      isLoading.value = true;
      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'fullName': fullNameController.text,
          'email': emailController.text,
          'createdAt': FieldValue.serverTimestamp(),
          'photoURL' : 'https://firebasestorage.googleapis.com/v0/b/glowifyapp-9bf8d.appspot.com/o/profile_images%2Fprofile_nul.png?alt=media&token=8c8bfe0d-a31a-4b62-921d-152d90c5ad60'
        });

        Get.offAllNamed('/login');
        Future.delayed(const Duration(milliseconds: 300), () {
        const SnackBarCustom(
          judul: "Register berhasil",
          pesan: "login ke akunmu yang terdaftar",
          isHasIcon: true,
          iconType: SnackBarIconType.sukses,
        ).show();
      });
      } on FirebaseAuthException catch (e) {
        Get.snackbar('Register Failed', e.message ?? 'Unknown error');
      } finally {
        isLoading.value = false;
      }
    }
  }
}
