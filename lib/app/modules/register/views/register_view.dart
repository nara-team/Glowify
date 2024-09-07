import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/widget/button.dart';
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
        title: Text('Buat Akun', style: bold.copyWith(fontSize: 24)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Masukkan data diri dan daftarkan akunmu untuk menikmati fitur dari Glowify',
              style: TextStyle(fontSize: 16, color: abuDarkColor),
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
            BtnLoginPrimary(
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
                      style: const TextStyle(fontSize: 14, color: primaryColor),
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
