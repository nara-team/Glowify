import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController fullNameController;

  final RxString emailError = ''.obs;
  final RxString passwordError = ''.obs;
  final RxString fullNameError = ''.obs;

  RxBool isLoading = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    fullNameController = TextEditingController();
  }

  void validateInputs() {
    emailError.value = '';
    passwordError.value = '';
    fullNameError.value = '';

    // Validate email
    if (emailController.text.isEmpty) {
      emailError.value = 'Email tidak boleh kosong';
    } else if (!emailController.text.contains('@')) {
      emailError.value = 'Email tidak valid';
    }

    // Validate password
    if (passwordController.text.isEmpty) {
      passwordError.value = 'Password tidak boleh kosong';
    } else if (passwordController.text.length < 8) {
      passwordError.value = 'Password minimal 8 karakter';
    }

    // Validate full name
    if (fullNameController.text.isEmpty) {
      fullNameError.value = 'Nama lengkap tidak boleh kosong';
    }
  }

  Future<void> register() async {
    validateInputs();
    if (emailError.value.isEmpty && passwordError.value.isEmpty && fullNameError.value.isEmpty) {
      isLoading.value = true;
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // Simpan data user ke Firestore
        await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
          'id': userCredential.user!.uid, // Tambahkan ID pengguna
          'fullName': fullNameController.text,
          'email': emailController.text,
          'createdAt': FieldValue.serverTimestamp(),
        });

        // Setelah pendaftaran sukses, arahkan ke halaman login
        Get.offAllNamed('/login');
      } on FirebaseAuthException catch (e) {
        Get.snackbar('Register Failed', e.message ?? 'Unknown error');
      } finally {
        isLoading.value = false;
      }
    }
  }
}
