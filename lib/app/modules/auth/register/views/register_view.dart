import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import '../../../../../widget/custom_button.dart';
import '../../../../../widget/custom_textfield.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(RegisterController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Buat Akun',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  'Masukkan data diri dan daftarkan akunmu\nuntuk menikmati fitur dari Glowify',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
              Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFieldNormal(
                        hintText: 'Nama Lengkap Kamu',
                        controller: controller.fullNameController,
                        isRequired: true,
                        onTap: () {},
                        onChanged: (value) {
                          controller.validateInputs();
                        },
                      ),
                      if (controller.fullNameError.value.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              controller.fullNameError.value,
                              style: const TextStyle(
                                color: primaryColor,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        )
                      else if (controller.fullNameValid.value)
                        const Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Nama lengkap valid',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                    ],
                  )),
              const SizedBox(height: 20),
              Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFieldNormal(
                        hintText: 'Masukkan Email',
                        controller: controller.emailController,
                        isRequired: true,
                        onTap: () {},
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
                              textAlign: TextAlign.left,
                            ),
                          ),
                        )
                      else if (controller.emailValid.value)
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
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                    ],
                  )),
              const SizedBox(height: 20),
              Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFieldNormal(
                        hintText: 'Masukkan Kata Sandi',
                        controller: controller.passwordController,
                        isPassword: true,
                        isRequired: true,
                        onTap: () {},
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
                              textAlign: TextAlign.left,
                            ),
                          ),
                        )
                      else if (controller.passwordValid.value)
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
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                    ],
                  )),
              const SizedBox(height: 20),
              Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFieldNormal(
                        hintText: 'Masukkan Ulang Kata Sandi',
                        controller: controller.confirmPasswordController,
                        isPassword: true,
                        isRequired: true,
                        onTap: () {},
                        onChanged: (value) {
                          controller.validateInputs();
                        },
                      ),
                      if (controller.confirmPasswordError.value.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              controller.confirmPasswordError.value,
                              style: const TextStyle(
                                color: primaryColor,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        )
                      else if (controller.confirmPasswordValid.value)
                        const Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Konfirmasi password valid',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                    ],
                  )),
              const SizedBox(height: 30),
              Center(
                child: CustomButton(
                  text: 'Daftar',
                  onPressed: () {
                    controller.register();
                  },
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Sudah punya akun? ',
                    style: const TextStyle(color: Colors.black54, fontSize: 14),
                    children: [
                      TextSpan(
                        text: 'Masuk',
                        style: const TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.offNamed('/login');
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
