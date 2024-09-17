import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  void validateInputs() {
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
    } else if (passwordController.text.length < 8) {
      passwordError.value = 'Password minimal 8 karakter';
    } else if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).+$')
        .hasMatch(passwordController.text)) {
      passwordError.value = 'Password harus mengandung huruf dan angka';
    }
  }

  Future<void> login() async {
    validateInputs();
    if (emailError.value.isEmpty && passwordError.value.isEmpty) {
      isLoading.value = true;
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        Get.offAllNamed('/navbar');
      } on FirebaseAuthException catch (e) {
        Get.snackbar('Login Failed', e.message ?? 'Unknown error');
      } finally {
        isLoading.value = false;
      }
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
      }, SetOptions(merge: true));

      Get.offAllNamed('/navbar');
    } catch (e) {
      Get.snackbar('Google Sign-In Failed', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
