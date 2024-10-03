import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';

class SnackBarCustom extends StatelessWidget {
  final String judul;
  final String pesan;
  final SnackPosition? posisi;

  const SnackBarCustom({
    Key? key,
    required this.judul,
    required this.pesan,
    this.posisi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void show() {
    Get.snackbar(
      judul,
      pesan,
      snackPosition: posisi ?? SnackPosition.TOP,
      duration: const Duration(seconds: 2),
      backgroundColor: whiteBackground1Color,
      margin: const EdgeInsets.only(
        top: 20,
        right: 20,
        left: 20,
      ),
    );
  }
}
