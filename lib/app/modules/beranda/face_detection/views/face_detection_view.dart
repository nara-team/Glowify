import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/app/theme/sized_theme.dart';
import 'package:glowify/widget/appbarcustom.dart';
import 'package:glowify/widget/custom_button.dart';
import 'package:glowify/widget/snackbar_custom.dart';
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
                CustomButton(
                  text: controller.loading.value
                      ? 'Menganalisis...'
                      : 'Analisa Sekarang',
                  onPressed: allImagesSelected && !controller.loading.value
                      ? () {
                          controller.classifyImage();
                        }
                      : () {
                          if (!controller.loading.value) {
                            const SnackBarCustom(
                              judul: "perhatian",
                              pesan: "Harap isi semua gambar",
                              isHasIcon: true,
                              iconType: SnackBarIconType.warning,
                            ).show();
                          }
                        },
                  hasOutline: false,
                  buttonColor: controller.loading.value
                      ? abuLightColor
                      : (allImagesSelected ? primaryColor : abuLightColor),
                  textColor: whiteBackground1Color,
                  icon: null,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
