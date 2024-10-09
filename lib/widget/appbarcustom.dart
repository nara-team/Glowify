import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:iconsax/iconsax.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String judul;

  final List<Widget>? actions;

  const CustomAppBar({
    Key? key,
    required this.judul,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 3,
      title: Text(
        judul,
        style: const TextStyle(
          color: whiteBackground1Color,
          fontSize: largeSize,
        ),
      ),
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Iconsax.arrow_circle_left4,
          color: whiteBackground1Color,
          size: 26,
        ),
      ),
      backgroundColor: primaryColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
