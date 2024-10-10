import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
            ),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: _buildIcon(pathIcon),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          titleBtn,
          textAlign: TextAlign.center,
          // maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: regular.copyWith(
            fontSize: regularSize,
          ),
        ),
      ],
    );
  }

  Widget _buildIcon(String pathIcon) {
    if (pathIcon.startsWith('http')) {
      return SvgPicture.network(
        pathIcon,
        fit: BoxFit.contain,
        placeholderBuilder: (context) => const CircularProgressIndicator(
          color: whiteBackground1Color,
        ),
      );
    } else {
      return SvgPicture.asset(
        pathIcon,
        fit: BoxFit.contain,
      );
    }
  }
}
