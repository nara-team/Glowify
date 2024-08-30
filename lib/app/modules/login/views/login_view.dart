import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../../../../widget/EmailTf.dart';
import '../../../../widget/passTf.dart';
import '../../../../widget/BtnLogin.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Silahkan mengisi email dan password yang sudah terdaftar.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            EmailTf(
              controller: controller.emailController,
              error: controller.emailError,
            ),
            const SizedBox(height: 18),
            PassTf(
              controller: controller.passwordController,
              error: controller.passwordError,
            ),
            Container(
              padding: const EdgeInsets.only(top: 1, bottom: 30),
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => print('Lupa kata sandi'),
                child: const Text('Lupa kata sandi?',
                    style: TextStyle(fontSize: 14)),
              ),
            ),
            BtnLogin(
              btnText: 'Login',
              onPressed: () => controller.login(),
              isLoading: controller.isLoading,
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.login),
                label: const Text('Login with Google'),
                onPressed: () => controller.loginWithGoogle(),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: RichText(
                text: TextSpan(
                  text: 'Belum punya akun?',
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                  children: [
                    TextSpan(
                        text: ' Daftar Sekarang',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.offNamed('/register')),
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
