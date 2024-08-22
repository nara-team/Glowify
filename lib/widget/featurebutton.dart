import 'package:flutter/material.dart';
import 'package:glowify/app/theme/app_theme.dart';

class FeatureButton extends StatelessWidget {
  final String pathIcon;
  final Color featureColor;
  final String titleBtn;
  final VoidCallback tekan;
  const FeatureButton({
    required this.pathIcon,
    required this.featureColor,
    required this.titleBtn,
    required this.tekan,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: tekan,
          child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: featureColor,
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(pathIcon),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          titleBtn,
          textAlign: TextAlign.center,
          style: regular.copyWith(fontSize: regularSize),
        ),
      ],
    );
  }
}
