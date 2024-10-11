import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
    double confidencePercentage = double.tryParse(confidence) ?? 0.0;
    double confidenceFraction = confidencePercentage / 100;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularPercentIndicator(
          radius: 80.0,
          lineWidth: 12.0,
          percent: confidenceFraction,
          center: Text(
            '${confidencePercentage.toStringAsFixed(1)}%',
            style: bold.copyWith(
              fontSize: largeSize,
              color: blackColor,
            ),
          ),
          progressColor: primaryColor,
          backgroundColor: abuLightColor,
          circularStrokeCap: CircularStrokeCap.round,
        ),
        const Gap(8),
        Text(
          area,
          textAlign: TextAlign.center,
          style: bold.copyWith(
            fontSize: regularSize,
            color: blackColor,
          ),
        ),
        Text(
          result,
          textAlign: TextAlign.center,
          style: bold.copyWith(
            fontSize: smallSize,
            color: blackColor,
          ),
        ),
      ],
    );
  }
}
