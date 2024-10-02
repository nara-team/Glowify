import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/sized_theme.dart';
import 'package:glowify/widget/appbarcustom.dart';
import '../controllers/informasi_akun_controller.dart';
import 'package:glowify/app/theme/app_theme.dart';

class InformasiAkunView extends GetView<InformasiAkunController> {
  const InformasiAkunView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(judul: "Informasi Akun"),
      body: Padding(
        padding: PaddingCustom().paddingHorizontalVertical(20, 10),
        child: ListView(
          children: [
            Text(
              'Pengaturan Keamanan',
              style: semiBold.copyWith(fontSize: largeSize),
            ),
            const Gap(20),
            Obx(() {
              return Card(
                surfaceTintColor: whiteBackground1Color,
                shadowColor: Colors.transparent,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: abuLightColor, // Warna outline
                    width: 1, // Ketebalan outline
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: const Icon(
                    Icons.security,
                    color: primaryColor,
                  ),
                  title: const Text('Aktifkan Autentikasi Dua Faktor'),
                  trailing: Switch(
                    value: controller.isTwoFactorEnabled.value,
                    onChanged: (value) {
                      controller.toggleTwoFactor(value);
                    },
                    activeColor: primaryColor,
                  ),
                ),
              );
            }),
            const Gap(20),
            Text(
              'Perbarui Kata Sandi',
              style: semiBold.copyWith(fontSize: mediumSize),
            ),
            const Gap(10),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Kata Sandi Baru',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor, width: 2.0),
                ),
              ),
              onChanged: (password) {
                controller.updatePasswordStrength(password);
              },
            ),
            const SizedBox(height: 10),
            Obx(() {
              return Text(
                'Kekuatan Kata Sandi: ${controller.passwordStrength.value}',
                style: TextStyle(
                  fontSize: smallSize,
                  fontWeight: FontWeight.w500,
                  color: controller.passwordStrength.value == 'Strong'
                      ? Colors.green
                      : Colors.red,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
