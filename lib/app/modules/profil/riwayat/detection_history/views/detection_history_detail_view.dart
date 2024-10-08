import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/widget/appbarcustom.dart';

import '../controllers/detection_history_detail_controller.dart';

class DetectionHistoryDetailView
    extends GetView<DetectionHistoryDetailController> {
  const DetectionHistoryDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(judul: "Riwayat Deteksi"),
      body: Center(
        child: Text(
          'halaman detail histori deteksi wajah',
          style: bold.copyWith(
            fontSize: largeSize,
          ),
        ),
      ),
    );
  }
}
