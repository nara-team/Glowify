import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glowify/app/theme/app_theme.dart';

enum IconVariant {
  pencarian,
  dokumen,
  chat
}

enum IconSize {
  kecil,
  besar,
}

class NodataHandling extends StatelessWidget {
  final IconVariant iconVariant;
  final String messageText;
  final IconSize iconSizeVariant;

  const NodataHandling({
    Key? key,
    required this.iconVariant,
    required this.messageText,
    this.iconSizeVariant = IconSize.kecil,
  }) : super(key: key);

  String iconAsset(IconVariant variant) {
    switch (variant) {
      case IconVariant.pencarian:
        return 'assets/icons/search-off-ol.svg';
      case IconVariant.dokumen:
        return 'assets/icons/note-remove-ol.svg';
      case IconVariant.chat:
        return 'assets/icons/message-remove.svg';
    }
  }

  double iconSize(IconSize size) {
    switch (size) {
      case IconSize.kecil:
        return 40;
      case IconSize.besar:
        return 60;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconAsset(iconVariant),
            height: iconSize(iconSizeVariant),
            colorFilter: const ColorFilter.mode(
              abuLightColor,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            messageText,
            style: const TextStyle(
              fontSize: 16,
              color: abuLightColor,
            ),
          ),
        ],
      ),
    );
  }
}
