import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/data/models/condition_model.dart';
import 'package:glowify/data/models/facehistory_model.dart';
import 'package:glowify/data/models/product_model.dart';

class ResultDetectionController extends GetxController {
  var condition = ConditionModel(productId: [], todo: '').obs;
  var products = <ProductModel>[].obs;
  var loading = true.obs;
  var results = <String>[];
  var confidences = <String>[];

  void fetchCondition(List<String> results) async {
    String conditionId = _generateConditionId(results);
    debugPrint("Results: $results");
    debugPrint("Condition ID: $conditionId");

    try {
      DocumentSnapshot conditionSnapshot = await FirebaseFirestore.instance
          .collection('condition')
          .doc(conditionId)
          .get();

      if (conditionSnapshot.exists) {
        condition.value =
            ConditionModel.fromDocumentSnapshot(conditionSnapshot);
        debugPrint("TODO: ${condition.value.todo}");
        debugPrint("Product IDs: ${condition.value.productId}");
        fetchProducts(condition.value.productId);
      } else {
        debugPrint('Condition not found for the given results.');
      }
    } catch (e) {
      debugPrint('Error fetching condition: $e');
    } finally {
      loading.value = false;
    }
  }

  void fetchProducts(List<String> productIds) async {
    try {
      List<ProductModel> fetchedProducts = [];
      for (var productId in productIds) {
        DocumentSnapshot productSnapshot = await FirebaseFirestore.instance
            .collection('product')
            .doc(productId)
            .get();

        if (productSnapshot.exists) {
          fetchedProducts
              .add(ProductModel.fromDocumentSnapshot(productSnapshot));
          debugPrint("Product Name: ${productSnapshot['product_name']}");
        } else {
          debugPrint("Product not found for ID: $productId");
        }
      }
      products.value = fetchedProducts;

      // ignore: invalid_use_of_protected_member
      debugPrint("Total Products: ${products.value.length}");
    } catch (e) {
      debugPrint('Error fetching products: $e');
    }
  }

  Future<void> simpanRiwayat(
    List<String> results,
    List<String> confidences,
    File? imageForehead,
    File? imageCheek,
    File? imageNose,
  ) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid ?? 'unknown';

      final docRef =
          FirebaseFirestore.instance.collection('face_history').doc();

      final String generatedId = docRef.id;
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_detection_result/$userId/$generatedId');

      String? urlForehead;
      String? urlCheek;
      String? urlNose;

      if (imageForehead != null) {
        final ref = storageRef.child('image_forehead.jpeg');
        final uploadTask = await ref.putFile(imageForehead);
        urlForehead = await uploadTask.ref.getDownloadURL();
      }

      if (imageCheek != null) {
        final ref = storageRef.child('image_cheek.jpeg');
        final uploadTask = await ref.putFile(imageCheek);
        urlCheek = await uploadTask.ref.getDownloadURL();
      }

      if (imageNose != null) {
        final ref = storageRef.child('image_nose.jpeg');
        final uploadTask = await ref.putFile(imageNose);
        urlNose = await uploadTask.ref.getDownloadURL();
      }

      final faceHistory = FaceHistoryModel(
        userId: userId,
        detailResultCondition: {
          'area_dahi': {
            'name': 'Area Dahi',
            'persentation': confidences[0],
            'status': results[0] == "Sehat" ? 'sehat' : 'butuh perawatan',
          },
          'area_hidung': {
            'name': 'Area Hidung',
            'persentation': confidences[2],
            'status': results[2] == "Sehat" ? 'sehat' : 'butuh perawatan',
          },
          'area_pipi': {
            'name': 'Area Pipi',
            'persentation': confidences[1],
            'status': results[1] == "Sehat" ? 'sehat' : 'butuh perawatan',
          },
        },
        imageResult: {
          'dahi': urlForehead ?? '',
          'hidung': urlNose ?? '',
          'pipi': urlCheek ?? '',
        },
        rekomendasiPerawatan: condition.value.todo,
        rekomendasiProduk: condition.value.productId,
        products: products,
        resultCondition: {
          'result_text': _determineFinalResult(results),
        },
        timeDetection: DateTime.now(),
      );

      final dataToSave = {
        'UserId': faceHistory.userId,
        'detail_result_condition': faceHistory.detailResultCondition,
        'image_result': faceHistory.imageResult,
        'rekomendasi_perawatan': faceHistory.rekomendasiPerawatan,
        'rekomendasi_produk': faceHistory.rekomendasiProduk,
        'result_condition': faceHistory.resultCondition,
        'time_detection': Timestamp.fromDate(faceHistory.timeDetection),
      };

      await docRef.set(dataToSave);

      Get.snackbar(
        'Berhasil',
        'Hasil analisis berhasil disimpan!',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      debugPrint('Error saving data to Firestore: $e');
      Get.snackbar(
        'Gagal',
        'Gagal menyimpan hasil analisis: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  String _determineFinalResult(List<String> results) {
    int healthyCount = results.where((result) => result == "sehat").length;
    if (healthyCount == 3) {
      return "sehat";
    } else if (healthyCount > 0) {
      return "perlu perhatian";
    } else {
      return "butuh perawatan";
    }
  }

  String _generateConditionId(List<String> results) {
    List<String> ids = [];

    for (int i = 0; i < results.length; i++) {
      if (results[i] == "sehat") {
        ids.add("$i");
      } else {
        ids.add("$i!");
      }
    }

    return ids.join("");
  }
}
