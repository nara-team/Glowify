import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/app/theme/sized_theme.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final Future<void> Function() onConfirm;
  final VoidCallback? onCancel;
  final String textKonfirmasi;
  final String? textBatal;

  ConfirmationDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.onConfirm,
    this.onCancel,
    required this.textKonfirmasi,
    this.textBatal,
  }) : super(key: key);

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  static void show({
    required String title,
    required String content,
    required Future<void> Function() onConfirm,
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
        ValueListenableBuilder<bool>(
          valueListenable: isLoading,
          builder: (context, loading, child) {
            return ElevatedButton(
              onPressed: loading
                  ? null
                  : () async {
                      isLoading.value = true;
                      try {
                        await onConfirm();
                      } finally {
                        isLoading.value = false;
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: loading ? Colors.grey : primaryColor,
                padding: PaddingCustom().paddingHorizontalVertical(
                  15,
                  6,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text(
                loading ? 'Menyimpan...' : textKonfirmasi,
                style: const TextStyle(
                  color: whiteBackground1Color,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
