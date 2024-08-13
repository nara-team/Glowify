import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  final RxString emailError = ''.obs;
  final RxString passwordError = ''.obs;

  var isLogin = false.obs;
  RxBool isLoading = false.obs;
  final count = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  void validateInputs() {
    emailError.value = '';
    passwordError.value = '';

    //for email
    if (emailController.text.isEmpty) {
      emailError.value = 'Email tidak boleh kosong';
    } else if (emailController.text.contains('@') == false) {
      emailError.value = 'Email tidak valid';
    }

    //for password
    if (passwordController.text.isEmpty) {
      passwordError.value = 'Password tidak boleh kosong';
    } else if (passwordController.text.length < 8) {
      passwordError.value = 'Password minimal 8 karakter';
    }
  }
}
