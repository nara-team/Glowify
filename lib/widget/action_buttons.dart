import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/sized_theme.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            padding: PaddingCustom().paddingHorizontalVertical(24, 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onPressed: () {
            Get.toNamed('/konsultasi');
          },
          child: const Text(
            'Konsultasi Ke Dokter',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: const BorderSide(color: Colors.redAccent),
            ),
          ),
          onPressed: () {
            Get.offAllNamed('/navbar');
          },
          child: const Text(
            'Kembali ke Beranda',
            style: TextStyle(color: Colors.redAccent, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
