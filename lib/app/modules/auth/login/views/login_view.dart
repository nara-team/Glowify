import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/widget/custom_button.dart';
import 'package:glowify/widget/custom_textfield.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());

    return Scaffold(
      backgroundColor: whiteBackground1Color,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              const Center(
                child: Text(
                  'Selamat Datang Kembali!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: blackColor,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  'Masuk kembali ke akunmu, dan nikmati fitur dari Glowify',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: blackColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFieldNormal(
                      hintText: 'Masukkan Email',
                      controller: controller.emailController,
                      isRequired: true,
                      onChanged: (value) {
                        controller.validateInputs();
                      },
                    ),
                    if (controller.emailError.value.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            controller.emailError.value,
                            style: const TextStyle(
                              color: primaryColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      )
                    else if (controller.emailController.text.isNotEmpty)
                      const Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Email valid',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFieldNormal(
                      hintText: 'Masukkan Kata Sandi',
                      controller: controller.passwordController,
                      isPassword: true,
                      isRequired: true,
                      onChanged: (value) {
                        controller.validateInputs();
                      },
                    ),
                    if (controller.passwordError.value.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            controller.passwordError.value,
                            style: const TextStyle(
                              color: primaryColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      )
                    else if (controller.passwordController.text.isNotEmpty)
                      const Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Password valid',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Lupa Kata Sandi?',
                    style: TextStyle(color: primaryColor),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: CustomButton(
                  text: 'Masuk',
                  onPressed: () {
                    controller.login();
                  },
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: CustomButton(
                  text: 'Login dengan Google',
                  onPressed: () {
                    controller.loginWithGoogle();
                  },
                  hasOutline: true,
                  icon: SvgPicture.asset(
                    'assets/images/google_logo.svg',
                    height: 20,
                  ),
                  buttonColor: primaryColor,
                  textColor: primaryColor,
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Belum punya akun? ',
                    style: const TextStyle(
                      color: blackColor,
                      fontSize: regularSize,
                    ),
                    children: [
                      TextSpan(
                        text: 'Daftar',
                        style: bold.copyWith(
                          color: primaryColor,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.offNamed('/register');
                          },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
