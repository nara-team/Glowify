import 'package:flutter/material.dart';
import 'package:glowify/widget/appbarcustom.dart';
import 'dart:io';
import '../../../../../widget/result_tile.dart';
import '../../../../../widget/treatment_recommendation.dart';
import '../../../../../widget/action_buttons.dart';

class ResultPage extends StatelessWidget {
  final List<String> results;
  final List<String> confidences;
  final File? imageForehead;
  final File? imageCheek;
  final File? imageNose;

  const ResultPage({super.key, 
    required this.results,
    required this.confidences,
    required this.imageForehead,
    required this.imageCheek,
    required this.imageNose,
  });

  @override
  Widget build(BuildContext context) {
    // String finalResult = _determineFinalResult();
    // String finalConfidence = _calculateFinalConfidence();

    return Scaffold(
      appBar: const CustomAppBar(judul: "Hasil Deteksi Wajah"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (imageForehead != null)
                  Image.file(imageForehead!, width: 80, height: 80),
                if (imageCheek != null)
                  Image.file(imageCheek!, width: 80, height: 80),
                if (imageNose != null)
                  Image.file(imageNose!, width: 80, height: 80),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Kondisi Wajah',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.sentiment_satisfied,
                  color: _getConditionColor(),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hari ini',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _getConditionText(),
                      style: TextStyle(
                        color: _getConditionColor(),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Detail Hasil Analisis',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 3,
              itemBuilder: (context, index) {
                return ResultTile(
                  area: index == 0
                      ? "Dahi"
                      : index == 1
                          ? "Pipi"
                          : "Hidung",
                  result: results[index],
                  confidence: confidences[index],
                );
              },
            ),
            const SizedBox(height: 16),
            TreatmentRecommendation(results: results),
            const SizedBox(height: 32),
            const ActionButtons(),
          ],
        ),
      ),
    );
  }

  String _determineFinalResult() {
    if (results.isEmpty) return "Tidak Ada Data";
    int healthyCount = results.where((result) => result == "Sehat").length;
    if (healthyCount == 3) {
      return "Sehat";
    } else if (healthyCount > 0) {
      return "Perlu Perhatian";
    } else {
      return "Butuh Perawatan";
    }
  }

  Color _getConditionColor() {
    String result = _determineFinalResult();
    switch (result) {
      case "Sehat":
        return Colors.green;
      case "Perlu Perhatian":
        return const Color.fromARGB(255, 255, 174, 0);
      case "Butuh Perawatan":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getConditionText() {
    String result = _determineFinalResult();
    switch (result) {
      case "Sehat":
        return "Sehat";
      case "Perlu Perhatian":
        return "Perlu Perhatian";
      case "Butuh Perawatan":
        return "Butuh Perawatan";
      default:
        return "Tidak Ada Data";
    }
  }

  // String _calculateFinalConfidence() {
  //   if (confidences.isEmpty) return "0.0";
  //   double average =
  //       confidences.map((s) => double.parse(s)).reduce((a, b) => a + b) /
  //           confidences.length;
  //   return average.toStringAsFixed(2);
  // }
}
