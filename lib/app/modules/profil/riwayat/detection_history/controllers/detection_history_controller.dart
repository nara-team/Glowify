import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glowify/data/models/facehistory_model.dart';
import 'package:glowify/data/models/product_model.dart';

class FaceHistoryController extends GetxController {
  var faceHistoryList = <FaceHistoryModel>[].obs;
  var filteredFaceHistory = <FaceHistoryModel>[].obs;
  var activeFilter = 'Semua'.obs;
  var isLoading = true.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    fetchFaceHistory();
  }

  Future<void> fetchFaceHistory() async {
    try {
      isLoading.value = true;
      String userId = auth.currentUser?.uid ?? '';

      if (userId.isEmpty) {
        debugPrint('User not logged in');
        return;
      }

      QuerySnapshot snapshot = await firestore
          .collection('face_history')
          .where('UserId', isEqualTo: userId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        List<FaceHistoryModel> histories = await Future.wait(
          snapshot.docs.map((doc) async {
            FaceHistoryModel faceHistory =
                FaceHistoryModel.fromDocumentSnapshot(doc);

            List<Future<ProductModel?>> productFutures =
                faceHistory.rekomendasiProduk.map((productId) async {
              DocumentSnapshot productSnapshot =
                  await firestore.collection('product').doc(productId).get();
              if (productSnapshot.exists) {
                return ProductModel.fromDocumentSnapshot(productSnapshot);
              }
              return null;
            }).toList();

            List<ProductModel> products = (await Future.wait(productFutures))
                .where((product) => product != null)
                .cast<ProductModel>()
                .toList();

            return faceHistory.copyWith(products: products);
          }).toList(),
        );

        faceHistoryList.assignAll(histories);
        filterFaceHistory();
      } else {
        debugPrint('No face history found for this user');
        filteredFaceHistory.clear();
      }
    } catch (e) {
      debugPrint('Error fetching face history: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void filterFaceHistory() {
    if (activeFilter.value == 'Semua') {
      filteredFaceHistory.assignAll(faceHistoryList);
    } else {
      filteredFaceHistory.assignAll(
        faceHistoryList.where((history) {
          final resultText = history.resultCondition['result_text']
                  ?.toString()
                  .toLowerCase() ??
              '';
          return resultText == activeFilter.value.toLowerCase();
        }).toList(),
      );
    }
  }
}
