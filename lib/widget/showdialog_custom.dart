import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/app/theme/sized_theme.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final String textKonfirmasi;
  final String? textBatal;

  const ConfirmationDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.onConfirm,
    this.onCancel,
    required this.textKonfirmasi,
    this.textBatal,
  }) : super(key: key);

  static void show({
    required String title,
    required String content,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    required String textKonfirmasi,
    String? textBatal,
  }) {
    Get.dialog(
      ConfirmationDialog(
        title: title,
        content: content,
        onConfirm: onConfirm,
        onCancel: onCancel,
        textKonfirmasi: textKonfirmasi,
        textBatal: textBatal,
      ),
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        title,
        style: medium.copyWith(
          fontSize: largeSize,
        ),
      ),
      content: Text(
        content,
        style: regular.copyWith(
          fontSize: regularSize,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (onCancel != null) {
              onCancel!();
            } else {
              Get.back();
            }
          },
          child: Text(
            textBatal ?? 'Batal',
            style: const TextStyle(
              color: primaryColor,
              fontSize: mediumSize,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Get.back();
            onConfirm();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            padding: PaddingCustom().paddingHorizontalVertical(
              15,
              6,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Text(
            textKonfirmasi,
            style: const TextStyle(
              color: whiteBackground1Color,
            ),
          ),
        ),
      ],
    );
  }
}
