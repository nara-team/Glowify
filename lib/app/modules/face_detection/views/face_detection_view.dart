import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/widget/appbarcustom.dart';
import '../controllers/face_detection_controller.dart';
import '../../../../widget/face_area_widget.dart';
// import 'result_page.dart';

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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FaceAreaWidget(
                  title: "Area Dahi",
                  image: controller.imageForehead.value,
                  onTap: () => controller.pickImage("forehead"),
                ),
                SizedBox(height: 16),
                FaceAreaWidget(
                  title: "Area Pipi",
                  image: controller.imageCheek.value,
                  onTap: () => controller.pickImage("cheek"),
                ),
                SizedBox(height: 16),
                FaceAreaWidget(
                  title: "Area Hidung",
                  image: controller.imageNose.value,
                  onTap: () => controller.pickImage("nose"),
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: allImagesSelected && !controller.loading.value
                      ? controller.classifyImage
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    elevation: 4,
                  ),
                  child: controller.loading.value
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'Analisis AI',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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
