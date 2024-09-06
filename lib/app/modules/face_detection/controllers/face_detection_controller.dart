import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import '../views/result_page.dart'; // Import ResultPage correctly

class FaceDetectionController extends GetxController {
  var imageForehead = Rx<File?>(null);
  var imageCheek = Rx<File?>(null);
  var imageNose = Rx<File?>(null);
  var loading = false.obs;
  var results = <String>[];
  var confidences = <String>[];

  @override
  void onInit() {
    super.onInit();
    loadModel();
  }

  Future<void> loadModel() async {
    String? res = await Tflite.loadModel(
      model: "assets/face_health_detection/model.tflite",
      labels: "assets/face_health_detection/labels.txt",
    );
    print(res);
  }

  Future<void> pickImage(String area) async {
    final picker = ImagePicker();
    final pickedFile = await Get.bottomSheet<File?>(
      SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.photo_camera),
              title: Text('Ambil dari Kamera'),
              onTap: () async {
                final pickedFile = await picker.pickImage(source: ImageSource.camera);
                Get.back(result: pickedFile != null ? File(pickedFile.path) : null);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Pilih dari Galeri'),
              onTap: () async {
                final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                Get.back(result: pickedFile != null ? File(pickedFile.path) : null);
              },
            ),
          ],
        ),
      ),
    );

    if (pickedFile != null) {
      if (area == "forehead") {
        imageForehead.value = pickedFile;
      } else if (area == "cheek") {
        imageCheek.value = pickedFile;
      } else if (area == "nose") {
        imageNose.value = pickedFile;
      }
    }
  }

  Future<void> classifyImage() async {
    loading.value = true;

    var recognitionsForehead = await Tflite.runModelOnImage(
      path: imageForehead.value!.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    var recognitionsCheek = await Tflite.runModelOnImage(
      path: imageCheek.value!.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    var recognitionsNose = await Tflite.runModelOnImage(
      path: imageNose.value!.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    loading.value = false;
    results = [
      recognitionsForehead != null && recognitionsForehead.isNotEmpty
          ? recognitionsForehead[0]["label"]
          : '',
      recognitionsCheek != null && recognitionsCheek.isNotEmpty
          ? recognitionsCheek[0]["label"]
          : '',
      recognitionsNose != null && recognitionsNose.isNotEmpty
          ? recognitionsNose[0]["label"]
          : ''
    ];

    confidences = [
      recognitionsForehead != null && recognitionsForehead.isNotEmpty
          ? (recognitionsForehead[0]["confidence"] * 100.0).toStringAsFixed(2)
          : '0.0',
      recognitionsCheek != null && recognitionsCheek.isNotEmpty
          ? (recognitionsCheek[0]["confidence"] * 100.0).toStringAsFixed(2)
          : '0.0',
      recognitionsNose != null && recognitionsNose.isNotEmpty
          ? (recognitionsNose[0]["confidence"] * 100.0).toStringAsFixed(2)
          : '0.0'
    ];

    Get.to(() => ResultPage(
      results: results,
      confidences: confidences,
      imageForehead: imageForehead.value,
      imageCheek: imageCheek.value,
      imageNose: imageNose.value,
    ));
  }

  @override
  void onClose() {
    Tflite.close();
    super.onClose();
  }
}
