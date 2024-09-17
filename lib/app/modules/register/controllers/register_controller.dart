import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  RxBool isPasswordHidden = true.obs; // Untuk toggle show/hide password
  RxBool isConfirmPasswordHidden =
      true.obs; // Untuk toggle show/hide confirm password
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

  // Toggle visibilitas password
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  // Toggle visibilitas konfirmasi password
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  void validateInputs() {
    // Reset semua error dan validasi
    emailError.value = '';
    passwordError.value = '';
    confirmPasswordError.value = '';
    fullNameError.value = '';
    emailValid.value = false;
    passwordValid.value = false;
    confirmPasswordValid.value = false;
    fullNameValid.value = false;

    // Validasi Email
    if (emailController.text.isEmpty) {
      emailError.value = 'Email tidak boleh kosong';
    } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(emailController.text)) {
      emailError.value = 'Email tidak valid';
    } else {
      emailValid.value = true;
    }

    // Validasi Password
    if (passwordController.text.isEmpty) {
      passwordError.value = 'Password tidak boleh kosong';
    } else if (passwordController.text.length < 8) {
      passwordError.value = 'Password minimal 8 karakter';
    } else if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).+$')
        .hasMatch(passwordController.text)) {
      passwordError.value = 'Password harus mengandung huruf dan angka';
    } else {
      passwordValid.value = true; // Password valid
    }

    // Validasi Konfirmasi Password
    if (confirmPasswordController.text.isEmpty) {
      confirmPasswordError.value = 'Konfirmasi password tidak boleh kosong';
    } else if (confirmPasswordController.text != passwordController.text) {
      confirmPasswordError.value = 'Password tidak sesuai';
    } else {
      confirmPasswordValid.value = true; // Konfirmasi password valid
    }

    // Validasi Nama Lengkap
    if (fullNameController.text.isEmpty) {
      fullNameError.value = 'Nama lengkap tidak boleh kosong';
    } else {
      fullNameValid.value = true; // Nama lengkap valid
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

        // Simpan data user ke Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'fullName': fullNameController.text,
          'email': emailController.text,
          'createdAt': FieldValue.serverTimestamp(),
        });

        Get.offAllNamed('/login');
      } on FirebaseAuthException catch (e) {
        Get.snackbar('Register Failed', e.message ?? 'Unknown error');
      } finally {
        isLoading.value = false;
      }
    }
  }
}
