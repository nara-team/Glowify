import 'package:flutter/material.dart';
import 'package:glowify/app/theme/sized_theme.dart';

class ResultTile extends StatelessWidget {
  final String area;
  final String result;
  final String confidence;

  const ResultTile({
    super.key,
    required this.area,
    required this.result,
    required this.confidence,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      height: 96,
      padding: PaddingCustom().paddingAll(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$confidence%',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Area $area',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            result,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: result == "Sehat" ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
