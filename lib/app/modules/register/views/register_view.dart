import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import '../controllers/register_controller.dart';
import '../../../../widget/EmailTf.dart'; // Ensure these imports are correct
import '../../../../widget/passTf.dart'; // Ensure these imports are correct
import '../../../../widget/BtnLogin.dart'; // Ensure these imports are correct


class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(RegisterController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Silahkan mengisi informasi berikut untuk mendaftar.',

              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: controller.fullNameController,
              decoration: InputDecoration(
                labelText: 'Nama Lengkap',
                errorText: controller.fullNameError.value.isNotEmpty
                    ? controller.fullNameError.value
                    : null,
              ),
            ),
            const SizedBox(height: 18),
            EmailTf(
              controller: controller.emailController,
              error: controller.emailError,
            ),
            const SizedBox(height: 18),
            PassTf(
              controller: controller.passwordController,
              error: controller.passwordError,
            ),
            const SizedBox(height: 30),
            BtnLogin(
              btnText: 'Register',
              onPressed: () => controller.register(),
              isLoading: controller.isLoading,
            ),
            const SizedBox(height: 10),
            Center(
              child: RichText(
                text: TextSpan(
                  text: 'Sudah punya akun?',
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                  children: [
                    TextSpan(
                      text: ' Login Sekarang',
                      style: const TextStyle(fontSize: 14, color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.offNamed('/login'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
