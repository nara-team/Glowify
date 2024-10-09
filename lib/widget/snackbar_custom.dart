import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:iconsax/iconsax.dart';

enum SnackBarIconType {
  sukses,
  gagal,
  warning,
}

class SnackBarCustom extends StatelessWidget {
  final String judul;
  final String pesan;
  final Color? warna;
  final SnackPosition? posisi;
  final bool isHasIcon;
  final SnackBarIconType? iconType;

  const SnackBarCustom({
    Key? key,
    required this.judul,
    required this.pesan,
    this.posisi,
    this.warna,
    this.isHasIcon = false,
    this.iconType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Icon getIconByType(SnackBarIconType type) {
    switch (type) {
      case SnackBarIconType.sukses:
        return const Icon(Iconsax.tick_circle, color: Colors.green);
      case SnackBarIconType.gagal:
        return const Icon(Iconsax.close_circle, color: Colors.red);
      case SnackBarIconType.warning:
        return const Icon(Iconsax.danger, color: Colors.orange);
      default:
        return const Icon(Icons.info);
    }
  }

  void show() {
    Get.snackbar(
      judul,
      pesan,
      snackPosition: posisi ?? SnackPosition.TOP,
      duration: const Duration(seconds: 2),
      backgroundColor: warna ?? whiteBackground1Color,
      margin: const EdgeInsets.only(
        top: 20,
        right: 20,
        left: 20,
      ),
      icon: isHasIcon && iconType != null ? getIconByType(iconType!) : null,
    );
  }
}
