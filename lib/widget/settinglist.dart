import 'package:flutter/material.dart';
import 'package:glowify/app/theme/app_theme.dart';

class SettingList extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap; // Add onTap as a parameter

  const SettingList({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap, // Optional parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: blackColor),
      title: Text(
        title,
        style: medium.copyWith(
          fontSize: 16,
          color: blackColor.withOpacity(0.6),
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: blackColor.withOpacity(0.5),
      ),
      onTap: onTap ?? () {
        debugPrint("nantinya route ke $title");
      }, // Use the custom onTap or a default debug print
    );
  }
}
