import 'package:flutter/material.dart';
import 'package:glowify/app/theme/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String judul;
  final EdgeInsetsGeometry padding;
  final List<Widget>? actions;

  const CustomAppBar({
    Key? key,
    required this.judul,
    this.padding = const EdgeInsets.symmetric(horizontal: 20.0),
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        judul,
        style: const TextStyle(
          color: Colors.white,
          fontSize: largeSize,
        ),
      ),
      backgroundColor: primaryColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      actions: actions,
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // Ukuran default AppBar
}
