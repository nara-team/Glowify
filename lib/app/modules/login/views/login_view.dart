import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/widget/button.dart';
import '../controllers/login_controller.dart';
import '../../../../widget/EmailTf.dart';
import '../../../../widget/passTf.dart';
import 'package:auth_buttons/auth_buttons.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Selamat Datang Kembali!', style: bold.copyWith(fontSize: 24)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Masuk kembali ke akunmu, dan nikmati fitur dari Glowify',
              style: TextStyle(fontSize: 16, color: abuDarkColor),
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
              padding: const EdgeInsets.only(top: 1, bottom: 20),
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => print('Lupa kata sandi'),
                child: const Text('Lupa kata sandi?',
                    style: TextStyle(fontSize: 14)),
              ),
            ),
            BtnLoginPrimary(
                btnText: 'Login',
                onPressed: () => controller.login(),
                isLoading: controller.isLoading),
            const SizedBox(height: 20),
            Center(
              child: GoogleAuthButton(
                onPressed: () => controller.loginWithGoogle(),
                text: 'Login dengan Google',
                style: AuthButtonStyle(
                    textStyle:
                        medium.copyWith(fontSize: 12, color: Colors.black),
                    iconSize: 24),
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
                            const TextStyle(fontSize: 14, color: primaryColor),
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
