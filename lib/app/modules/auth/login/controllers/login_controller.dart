// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/widget/snackbar_custom.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  var isPasswordHidden = true.obs;
  final RxString emailError = ''.obs;
  final RxString passwordError = ''.obs;

  var isLogin = false.obs;
  RxBool isLoading = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  bool validateInputs() {
    emailError.value = '';
    passwordError.value = '';

    if (emailController.text.isEmpty) {
      emailError.value = 'Email tidak boleh kosong';
    } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(emailController.text)) {
      emailError.value = 'Email tidak valid';
    }

    if (passwordController.text.isEmpty) {
      passwordError.value = 'Password tidak boleh kosong';
    }

    if (emailError.value.isNotEmpty || passwordError.value.isNotEmpty) {
      return false;
    }

    return true;
  }

  Future<void> login() async {
    if (!validateInputs()) {
      const SnackBarCustom(
          judul: "Login gagal",
          pesan: "Periksa kembali form",
          isHasIcon: true,
          iconType: SnackBarIconType.warning,
        ).show();
      return;
    }

    isLoading.value = true;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Get.offAllNamed('/navbar');

      Future.delayed(const Duration(milliseconds: 300), () {
        const SnackBarCustom(
          judul: "Login berhasil",
          pesan: "selamat datang..",
          isHasIcon: true,
          iconType: SnackBarIconType.sukses,
        ).show();
      });
    } on FirebaseAuthException {
      // Get.snackbar('Login Failed', e.message ?? 'eror gak tau');
      const SnackBarCustom(
          judul: "Login gagal",
          pesan: "Periksa kembali email dan password Anda",
          isHasIcon: true,
          iconType: SnackBarIconType.gagal,
        ).show();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginWithGoogle() async {
    isLoading.value = true;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'fullName': googleUser.displayName,
        'email': googleUser.email,
        'createdAt': FieldValue.serverTimestamp(),
        'photoURL': googleUser.photoUrl
      }, SetOptions(merge: true));

      Get.offAllNamed('/navbar');
    } catch (e) {
      Get.snackbar('Google Sign-In Failed', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
