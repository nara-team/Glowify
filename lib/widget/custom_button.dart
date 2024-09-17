import 'package:flutter/material.dart';
import 'package:glowify/app/theme/app_theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool hasOutline;
  final Widget? icon;
  final Color? buttonColor;
  final Color? textColor;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.hasOutline = false, // Default tidak menggunakan outline
    this.icon,
    this.buttonColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: hasOutline
          ? OutlinedButton.icon(
              icon: icon ?? const SizedBox(), // Menampilkan icon jika ada
              label: Text(
                text,
                style: medium.copyWith(
                  fontSize: mediumSize,
                  color: textColor ?? primaryColor, // Warna teks disesuaikan
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: buttonColor ?? primaryColor, // Warna border
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: onPressed,
            )
          : ElevatedButton.icon(
              icon: icon ?? const SizedBox(),
              label: Text(
                text,
                style: medium.copyWith(
                  fontSize: mediumSize,
                  color: textColor ?? whiteBackground1Color, // Warna teks default
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor ?? primaryColor, // Warna tombol
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: onPressed,
            ),
    );
  }
}
