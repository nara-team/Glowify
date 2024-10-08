import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';

class BottomSheetAction {
  final IconData icon;
  final String label;
  final Color? iconColor;
  final VoidCallback onTap;

  BottomSheetAction({
    required this.icon,
    required this.label,
    this.iconColor,
    required this.onTap,
  });
}

Future<T?> showCustomBottomSheet<T>({
  required String title,
  required List<BottomSheetAction> actions,
}) async {
  return await Get.bottomSheet<T>(
    SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          color: whiteBackground1Color,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
              child: Text(
                title,
                style: bold.copyWith(
                  fontSize: largeSize,
                  color: blackColor,
                ),
              ),
            ),
            const Divider(thickness: 1),
            ...actions.asMap().entries.map((entry) {
              int index = entry.key;
              BottomSheetAction action = entry.value;
              return Column(
                children: [
                  ListTile(
                    leading: Icon(
                      action.icon,
                      color: action.iconColor ?? blackColor,
                    ),
                    title: Text(
                      action.label,
                      style: medium.copyWith(
                        fontSize: mediumSize,
                        color: action.iconColor ?? blackColor,
                      ),
                    ),
                    onTap: action.onTap,
                  ),
                  if (index != actions.length - 1) const Divider(thickness: 1),
                ],
              );
            }).toList(),
            const Gap(10),
          ],
        ),
      ),
    ),
  );
}
