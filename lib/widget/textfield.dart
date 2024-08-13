import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:glowify/app/theme/app_theme.dart';

class EmailTf extends StatelessWidget {
  final TextEditingController controller;
  final RxString error;

  const EmailTf({super.key, required this.controller, required this.error});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email',
          style: medium.copyWith(fontSize: 14, color: abuDarkColor),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: abuLightColor),
          ),
          child: TextField(
            controller: controller,
            autocorrect: false,
            style: regular.copyWith(
              fontSize: 14,
              color: abuDarkColor,
            ),
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                hintText: 'Masukkan Email'),
          ),
        ),
        Obx(() => error.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  error.value,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              )
            : const SizedBox.shrink()),
      ],
    );
  }
}

class PassTf extends StatefulWidget {
  final TextEditingController controller;
  final RxString error;

  const PassTf({super.key, required this.controller, required this.error});

  @override
  _PassTfState createState() => _PassTfState();
}

class _PassTfState extends State<PassTf> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kata Sandi',
          style: medium.copyWith(fontSize: 14, color: abuDarkColor),
        ),
        const SizedBox(height: 8),
        Container(
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: abuLightColor,
            ),
          ),
          child: TextField(
            controller: widget.controller,
            autocorrect: false,
            obscureText: _obscureText,
            style: regular.copyWith(
              fontSize: 14,
              color: abuDarkColor,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              hintText: 'Masukkan Kata Sandimu',
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: abuMedColor,
                ),
                onPressed: _togglePasswordVisibility,
              ),
            ),
          ),
        ),
        Obx(() => widget.error.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  widget.error.value,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              )
            : const SizedBox.shrink()),
      ],
    );
  }
}
