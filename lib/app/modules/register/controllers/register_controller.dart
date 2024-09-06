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

  RxBool isPasswordHidden = true.obs;  // Untuk toggle show/hide password
  RxBool isConfirmPasswordHidden = true.obs;  // Untuk toggle show/hide confirm password
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
    emailError.value = '';
    passwordError.value = '';
    confirmPasswordError.value = '';
    fullNameError.value = '';

    if (emailController.text.isEmpty) {
      emailError.value = 'Email tidak boleh kosong';
    } else if (!emailController.text.contains('@')) {
      emailError.value = 'Email tidak valid';
    }

    if (passwordController.text.isEmpty) {
      passwordError.value = 'Password tidak boleh kosong';
    } else if (passwordController.text.length < 8) {
      passwordError.value = 'Password minimal 8 karakter';
    }

    if (confirmPasswordController.text.isEmpty) {
      confirmPasswordError.value = 'Konfirmasi password tidak boleh kosong';
    } else if (confirmPasswordController.text != passwordController.text) {
      confirmPasswordError.value = 'Password tidak sesuai';
    }

    if (fullNameController.text.isEmpty) {
      fullNameError.value = 'Nama lengkap tidak boleh kosong';
    }
  }

  Future<void> register() async {
    validateInputs();
    if (emailError.value.isEmpty &&
        passwordError.value.isEmpty &&
        confirmPasswordError.value.isEmpty &&
        fullNameError.value.isEmpty) {
      isLoading.value = true;
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // Simpan data user ke Firestore
        await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
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
