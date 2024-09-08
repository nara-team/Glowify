import 'package:flutter/material.dart';
import 'package:glowify/app/theme/app_theme.dart';

class TrendingTutorialItem extends StatelessWidget {
  final String iconPath;
  final String contentText;
  final VoidCallback onTap;

  const TrendingTutorialItem({
    Key? key,
    required this.iconPath,
    required this.contentText,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 150,
          margin: const EdgeInsets.only(right: 16.0),
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: whiteBackground1Color,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: blackColor.withOpacity(0.1),
                blurRadius: 1,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(5),
                ),
                child: Image.asset(
                  iconPath,
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              // ================= alternatif code =================
              // child: Image.network(
                //   iconPath,
                //   height: 100,
                //   width: double.infinity,
                //   fit: BoxFit.cover,
                //   errorBuilder: (context, error, stackTrace) {
                //     return const Icon(
                //       Icons.broken_image,
                //       size: 100,
                //     );
                //   },
                // ),
              const SizedBox(height: 8.0),
              Text(
                contentText,
                style: regular.copyWith(fontSize: regularSize),
                textAlign: TextAlign.justify,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ));
  }
}
