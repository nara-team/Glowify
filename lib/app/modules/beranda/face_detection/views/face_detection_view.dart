import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/app/theme/sized_theme.dart';
import 'package:glowify/widget/appbarcustom.dart';
import '../controllers/face_detection_controller.dart';
import '../../../../../widget/face_area_widget.dart';

class FaceDetectionView extends GetView<FaceDetectionController> {
  const FaceDetectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(judul: "Deteksi Kesehatan Wajah"),
      body: Obx(() {
        bool allImagesSelected = controller.imageForehead.value != null &&
            controller.imageCheek.value != null &&
            controller.imageNose.value != null;

        return SingleChildScrollView(
          child: Padding(
            padding: PaddingCustom().paddingAll(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FaceAreaWidget(
                  title: "Area Dahi",
                  image: controller.imageForehead.value,
                  onTap: () => controller.pickImage("forehead"),
                  onRemoveImage: () {
                    controller.removeImage("forehead");
                  },
                ),
                const SizedBox(height: 16),
                
                FaceAreaWidget(
                  title: "Area Pipi",
                  image: controller.imageCheek.value,
                  onTap: () => controller.pickImage("cheek"),
                  onRemoveImage: () {
                    controller.removeImage("cheek");
                  },
                ),
                const SizedBox(height: 16),
                
                FaceAreaWidget(
                  title: "Area Hidung",
                  image: controller.imageNose.value,
                  onTap: () => controller.pickImage("nose"),
                  onRemoveImage: () {
                    controller.removeImage("nose");
                  },
                ),
                const SizedBox(height: 32),
                
                ElevatedButton(
                  onPressed: allImagesSelected && !controller.loading.value
                      ? controller.classifyImage
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: PaddingCustom().paddingVertical(16),
                    elevation: 4,
                  ),
                  child: controller.loading.value
                      ? const CircularProgressIndicator(
                          color: whiteBackground1Color)
                      : Text(
                          'Analisa Sekarang',
                          style: bold.copyWith(
                            fontSize: largeSize,
                            color: whiteBackground1Color,
                          ),
                        ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
