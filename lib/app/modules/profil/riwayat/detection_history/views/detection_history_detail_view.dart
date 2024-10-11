import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:glowify/app/modules/beranda/face_detection/views/result_page.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/app/theme/sized_theme.dart';
import 'package:glowify/data/models/facehistory_model.dart';
import 'package:glowify/widget/appbarcustom.dart';
import 'package:glowify/widget/nodata_handling_widget.dart';
import 'package:glowify/widget/result_tile.dart';
import 'package:iconsax/iconsax.dart';

import '../controllers/detection_history_detail_controller.dart';

class DetectionHistoryDetailView
    extends GetView<DetectionHistoryDetailController> {
  const DetectionHistoryDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final FaceHistoryModel faceHistory = Get.arguments as FaceHistoryModel;

    final imageForehead = faceHistory.imageResult['dahi'];
    final imageCheek = faceHistory.imageResult['pipi'];
    final imageNose = faceHistory.imageResult['hidung'];

    return Scaffold(
      appBar: const CustomAppBar(judul: "Riwayat Deteksi"),
      body: SingleChildScrollView(
        padding: PaddingCustom().paddingAll(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (imageForehead != null && imageForehead.isNotEmpty)
                  Image.network(imageForehead, width: 80, height: 80),
                if (imageCheek != null && imageCheek.isNotEmpty)
                  Image.network(imageCheek, width: 80, height: 80),
                if (imageNose != null && imageNose.isNotEmpty)
                  Image.network(imageNose, width: 80, height: 80),
              ],
            ),
            const Gap(16),
            Text(
              'Kondisi Wajah',
              style: bold.copyWith(
                fontSize: largeSize,
              ),
            ),
            const Gap(8),
            Row(
              children: [
                _getConditionIcon(
                    faceHistory.resultCondition['result_text'] ?? 'unknown'),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      faceHistory.timeDetection.toString(),
                      style: regular.copyWith(fontSize: regularSize),
                    ),
                    Text(
                      faceHistory.resultCondition['result_text']?.toString() ??
                          'Tidak diketahui',
                      style: medium.copyWith(
                          color: blackColor, fontSize: mediumSize),
                    ),
                  ],
                ),
              ],
            ),
            const Gap(16),
            Text(
              'Detail Hasil Analisis',
              style: bold.copyWith(
                fontSize: regularSize,
              ),
            ),
            const Gap(8),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.7,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: faceHistory.detailResultCondition.length,
              itemBuilder: (context, index) {
                String key =
                    faceHistory.detailResultCondition.keys.elementAt(index);
                Map<String, dynamic> areaData =
                    faceHistory.detailResultCondition[key];

                String areaName = areaData['name'] ?? 'Unknown Area';
                String presentation = areaData['persentation'] ?? '0.0';
                String status = areaData['status'] ?? 'unknown';

                return ResultTile(
                  area: areaName,
                  result: status,
                  confidence: presentation,
                );
              },
            ),
            const Gap(16),
            Text(
              'Rekomendasi Perawatan',
              style: bold.copyWith(
                fontSize: largeSize,
              ),
            ),
            const Gap(8),
            Text(
              faceHistory.rekomendasiPerawatan.isNotEmpty
                  ? faceHistory.rekomendasiPerawatan
                  : 'Tidak ada rekomendasi perawatan untuk kondisi ini',
              style: const TextStyle(fontSize: regularSize),
            ),
            const Gap(16),
            Text(
              'Rekomendasi Produk',
              style: bold.copyWith(
                fontSize: largeSize,
              ),
            ),
            const Gap(8),
            SizedBox(
              height: 220,
              child: faceHistory.products.isNotEmpty
                  ? PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: faceHistory.products.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                            product: faceHistory.products[index]);
                      },
                    )
                  : const Center(
                      child: NodataHandling(
                          iconVariant: IconVariant.dokumen,
                          messageText:
                              "Tidak ada rekomendasi produk untuk kondisi ini"),
                    ),
            ),
            const Gap(32),
            const Text(
              "Disclaimer: Fitur ini menggunakan AI yang menganalisis kondisi wajah dengan tujuan merekomendasikan produk kecantikan. Ini tidak boleh digunakan sebagai, atau sebagai pengganti, nasihat medis.",
              textAlign: TextAlign.justify,
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }

  Icon _getConditionIcon(String result) {
    switch (result.toLowerCase()) {
      case "sehat":
        return const Icon(Iconsax.emoji_happy, size: 35, color: Colors.green);
      case "perlu perhatian":
        return const Icon(Iconsax.emoji_normal,
            size: 35, color: Color.fromARGB(255, 255, 174, 0));
      case "butuh perawatan":
        return const Icon(Iconsax.emoji_sad, size: 35, color: Colors.red);
      default:
        return const Icon(Iconsax.emoji_normal, size: 35, color: Colors.grey);
    }
  }
}
