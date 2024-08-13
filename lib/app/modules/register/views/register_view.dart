import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/widget/button.dart';
import 'package:glowify/widget/textfield.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Register',
            style: semiBold.copyWith(fontSize: largeSize),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Silahkan masukkan data diri anda.',
                style: regular.copyWith(fontSize: regularSize),
              ),
              const SizedBox(
                height: 20,
              ),
              NameTf(
                controller: controller.nameController,
                error: controller.nameError,
              ),
              const SizedBox(height: 18),
              NotelpTf(
                controller: controller.notelpController,
                error: controller.notelpError,
              ),
              const SizedBox(height: 18),
              EmailTf(
                controller: controller.emailController,
                error: controller.emailError,
              ),
              const SizedBox(
                height: 18,
              ),
              PassTf(
                controller: controller.passwordController,
                error: controller.passwordError,
              ),
              const SizedBox(
                height: 40,
              ),
              BtnLogin(
                  btnText: 'Daftar Akun',
                  onPressed: () {
                    controller.validateInputs();

                    if (controller.nameError.value.isEmpty &&
                        controller.notelpError.value.isEmpty &&
                        controller.emailError.value.isEmpty &&
                        controller.passwordError.value.isEmpty) {
                      print('daftar');
                    }
                  },
                  isLoading: controller.isLoading),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: RichText(
                    text: TextSpan(
                        text: 'Sudah punya akun? ',
                        style: regular.copyWith(fontSize: smallSize),
                        children: [
                      TextSpan(
                          text: 'Masuk Sekarang',
                          style: medium.copyWith(
                              fontSize: smallSize, color: primaryColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('klik masuk');
                            })
                    ])),
              ),
            ],
          ),
        ));
  }
}
