import 'package:flutter/material.dart';

class ResultTile extends StatelessWidget {
  final String area;
  final String result;
  final String confidence;

  const ResultTile({
    required this.area,
    required this.result,
    required this.confidence,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96, // Sesuaikan lebar sesuai gambar
      height: 96, // Sesuaikan tinggi sesuai gambar
      padding: EdgeInsets.all(8.0), // Padding lebih kecil
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0), // Sudut lebih bulat
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
            style: TextStyle(
              fontSize: 16, 
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Area $area',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 4),
          Text(
            result,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: result == "Sehat" ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
