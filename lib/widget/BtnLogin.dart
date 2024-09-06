import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BtnLogin extends StatelessWidget {
  final String btnText;
  final VoidCallback onPressed;
  final RxBool isLoading;

  const BtnLogin({
    required this.btnText,
    required this.onPressed,
    required this.isLoading,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ElevatedButton(
        onPressed: isLoading.value ? null : onPressed,
        child: isLoading.value
            ? CircularProgressIndicator()
            : Text(btnText),
      ),
    );
  }
}
