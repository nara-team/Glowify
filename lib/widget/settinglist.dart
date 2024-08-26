import 'package:flutter/material.dart';
import 'package:glowify/app/theme/app_theme.dart';

class SettingList extends StatelessWidget {
  final IconData icon;
  final String title;

  const SettingList({
    Key? key,
    required this.icon,
    required this.title,
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
      onTap: () {
        debugPrint("nantinya route ke $title");
      },
    );
  }
}
