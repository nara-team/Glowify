import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/app/theme/sized_theme.dart';
import 'package:glowify/widget/appbarcustom.dart';
import 'package:glowify/widget/nodata_handling_widget.dart';
import 'package:glowify/widget/tabfilter_custom.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../controllers/detection_history_controller.dart';

class FaceHistoryView extends GetView<FaceHistoryController> {
  const FaceHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(judul: "Riwayat Deteksi Wajah"),
      body: SafeArea(
        child: Padding(
          padding: PaddingCustom().paddingHorizontalVertical(20, 10),
          child: Column(
            children: [
              TabFilterCustom(
                categories: const [
                  'Semua',
                  'sehat',
                  'perlu perhatian',
                  'butuh perawatan'
                ],
                selectedCategory: controller.activeFilter,
                onCategorySelected: (String category) {
                  controller.activeFilter.value = category;
                  controller.filterFaceHistory();
                },
                isScrollable: true,
                horizontal: 10,
                vertical: 5,
              ),
              const Gap(20),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Skeletonizer(
                          child: Card(
                            surfaceTintColor: whiteBackground1Color,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: primaryColor,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 2,
                            shadowColor: Colors.transparent,
                            margin: const EdgeInsets.only(bottom: 10),
                            child: ListTile(
                              leading: Container(
                                width: 50,
                                height: 50,
                                color: Colors.grey,
                              ),
                              title: Container(
                                width: double.infinity,
                                height: 20.0,
                                color: Colors.grey,
                              ),
                              subtitle: Container(
                                width: double.infinity,
                                height: 10.0,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }

                  if (controller.filteredFaceHistory.isEmpty) {
                    return const NodataHandling(
                      iconVariant: IconVariant.dokumen,
                      messageText: "Belum ada riwayat dengan kondisi ini",
                    );
                  } else {
                    return ListView.builder(
                      itemCount: controller.filteredFaceHistory.length,
                      itemBuilder: (context, index) {
                        final faceHistory =
                            controller.filteredFaceHistory[index];
                        final condition = faceHistory
                                .resultCondition['result_text']
                                ?.toString() ??
                            'unknown';

                        return Card(
                          surfaceTintColor: whiteBackground1Color,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: primaryColor,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 2,
                          shadowColor: Colors.transparent,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            onTap: () {
                              Get.toNamed(
                                "/detection-history-detail",
                                arguments: faceHistory,
                              );
                            },
                            leading: _getConditionIcon(condition),
                            title: Text(
                              'Kondisi: ${condition.capitalizeFirst}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Tanggal Deteksi: ${faceHistory.timeDetection}',
                            ),
                          ),
                        );
                      },
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Icon _getConditionIcon(String result) {
    switch (result) {
      case "sehat":
        return const Icon(
          Iconsax.emoji_happy,
          size: 35,
          color: Colors.green,
        );
      case "perlu perhatian":
        return const Icon(
          Iconsax.emoji_normal,
          size: 35,
          color: Color.fromARGB(255, 255, 174, 0),
        );
      case "butuh perawatan":
        return const Icon(
          Iconsax.emoji_sad,
          size: 35,
          color: Colors.red,
        );
      default:
        return const Icon(
          Iconsax.emoji_normal,
          size: 35,
          color: Colors.grey,
        );
    }
  }
}
