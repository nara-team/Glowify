import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/keamanan_controller.dart';
import 'package:glowify/app/theme/app_theme.dart'; // Import your app theme
// import 'package:glowify/app/theme/sized_theme.dart'; // Import your size theme

class KeamananView extends GetView<KeamananController> {
  const KeamananView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keamanan'),
        backgroundColor: primaryColor, // Consistent with the theme
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Header Section
            Text(
              'Pengaturan Keamanan',
              style: semiBold.copyWith(fontSize: largeSize), // Using theme
            ),
            const SizedBox(height: 20),

            // Two-Factor Authentication Section
            Obx(() {
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: Icon(
                    Icons.security,
                    color: primaryColor, // Consistent with the theme
                  ),
                  title: const Text('Aktifkan Autentikasi Dua Faktor'),
                  trailing: Switch(
                    value: controller.isTwoFactorEnabled.value,
                    onChanged: (value) {
                      controller.toggleTwoFactor(value);
                    },
                    activeColor: primaryColor, // Consistent with the theme
                  ),
                ),
              );
            }),

            const SizedBox(height: 20),

            // Password Update Section
            Text(
              'Perbarui Kata Sandi',
              style: semiBold.copyWith(fontSize: mediumSize), // Using theme
            ),
            const SizedBox(height: 10),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Kata Sandi Baru',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor, width: 2.0), // Consistent with the theme
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
