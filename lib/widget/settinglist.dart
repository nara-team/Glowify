import 'package:flutter/material.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:iconsax/iconsax.dart';

class SettingList extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const SettingList({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: blackColor),
      title: Text(
        title,
        style: medium.copyWith(
          fontSize: 16,
          color: blackColor,
        ),
      ),
      trailing: const Icon(
        Iconsax.arrow_right,
        color: blackColor,
      ),
      onTap: onTap ??
          () {
            debugPrint("nantinya route ke $title");
          },
    );
  }
}
