import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PassTf extends StatelessWidget {
  final TextEditingController controller;
  final RxString error;

  const PassTf({
    required this.controller,
    required this.error,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            errorText: error.value.isNotEmpty ? error.value : null,
          ),
        ),
      ],
    );
  }
}
