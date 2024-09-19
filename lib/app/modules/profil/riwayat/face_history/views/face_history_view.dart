import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/widget/appbarcustom.dart';

import '../controllers/face_history_controller.dart';

class FaceHistoryView extends GetView<FaceHistoryController> {
  const FaceHistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: whiteBackground1Color,
      appBar: CustomAppBar(judul: "Riwayat Deteksi"),
      body: Center(
        child: Text(
          'Halaman Riwayat Deteksi',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
