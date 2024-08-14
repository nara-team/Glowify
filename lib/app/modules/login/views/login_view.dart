import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:get/get.dart';
import 'package:glowify/widget/button.dart';
import 'package:glowify/widget/textfield.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Login',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Silahkan mengisi email dan password yang sudah terdaftar.',
                style: regular.copyWith(fontSize: regularSize),
              ),
              const SizedBox(
                height: 20,
              ),
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
              Container(
                padding: const EdgeInsets.only(top: 1, bottom: 30),
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      print('Lupa kata sandi');
                    },
                    child: Text(
                      'Lupa kata sandi?',
                      style: medium.copyWith(fontSize: regularSize),
                    )),
              ),
              BtnLogin(
                  btnText: 'Login',
                  onPressed: () {
                    controller.validateInputs();

                    if (controller.emailError.value.isEmpty &&
                        controller.passwordError.value.isEmpty) {
                      print('login');
                    }
                  },
                  isLoading: controller.isLoading),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: RichText(
                    text: TextSpan(
                        text: 'Belum punya akun?',
                        style: regular.copyWith(fontSize: smallSize),
                        children: [
                      TextSpan(
                          text: ' Daftar Sekarang',
                          style: medium.copyWith(
                              fontSize: smallSize, color: primaryColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.offNamed('/register');
                              print('klik daftar');
                            })
                    ])),
              ),
            ],
          ),
        ));
  }
}
