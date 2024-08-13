import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  //TODO: Implement RegisterController
  late TextEditingController nameController;
  late TextEditingController notelpController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  final RxString nameError = ''.obs;
  final RxString notelpError = ''.obs;
  final RxString emailError = ''.obs;
  final RxString passwordError = ''.obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    notelpController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  void validateInputs() {
    nameError.value = '';
    notelpError.value = '';
    emailError.value = '';
    passwordError.value = '';

    //for name
    if (nameController.text.isEmpty) {
      nameError.value = 'Name tidak boleh kosong';
    }

    //for notelp
    if (notelpController.text.isEmpty) {
      notelpError.value = 'Nomor telepon tidak boleh kosong';
    } else if (notelpController.text.length < 10) {
      notelpError.value = 'Nomor telepon minimal 10 digit';
    } else if (!notelpController.text.startsWith('08')) {
      notelpError.value = 'Nomor telepon tidak valid';
    }

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
