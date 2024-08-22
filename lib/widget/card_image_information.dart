import 'package:flutter/material.dart';
import 'package:glowify/app/theme/app_theme.dart';

class CardImageInformation extends StatelessWidget {
  final int index;

  const CardImageInformation({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              'assets/images/banner_home.png',
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Cara Memutihkan Kulit dan Faktor Penyebab Gelapnya Kulit',
            style: regular.copyWith(fontSize: regularSize),
            textAlign: TextAlign.justify,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
