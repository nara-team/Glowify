import 'package:flutter/material.dart';
import 'package:glowify/app/theme/app_theme.dart';

class CustomTextField extends StatelessWidget {
  final Function(String) onChanged;
  final bool filled;
  final String hintText;

  const CustomTextField({
    Key? key,
    required this.onChanged,
    this.filled = true,
    this.hintText = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: filled ? whiteBackground1Color : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(1, 2),
          ),
        ],
      ),
      child: TextField(
        style: const TextStyle(fontSize: 16),
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: filled,
          fillColor: filled ? whiteBackground1Color : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          hintText: hintText,
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}
