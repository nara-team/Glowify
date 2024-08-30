import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailTf extends StatelessWidget {
  final TextEditingController controller;
  final RxString error;

  const EmailTf({
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
          decoration: InputDecoration(
            labelText: 'Email',
            errorText: error.value.isNotEmpty ? error.value : null,
          ),
        ),
      ],
    );
  }
}
