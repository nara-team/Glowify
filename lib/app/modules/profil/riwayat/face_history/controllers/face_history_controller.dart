import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glowify/data/models/facehistory_model.dart';
import 'package:glowify/data/models/product_model.dart';

class FaceHistoryController extends GetxController {
  var faceHistory = FaceHistoryModel(
    userId: '',
    detailResultCondition: {},
    imageResult: {},
    rekomendasiPerawatan: '',
    rekomendasiProduk: [],
    products: [],
    resultCondition: {},
    timeDetection: DateTime.now(),
  ).obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    fetchFaceHistory();
  }

  Future<void> fetchFaceHistory() async {
    try {
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
        var faceHistoryData =
            FaceHistoryModel.fromDocumentSnapshot(snapshot.docs.first);

        List<ProductModel> products = [];
        for (String productId in faceHistoryData.rekomendasiProduk) {
          DocumentSnapshot productSnapshot =
              await firestore.collection('product').doc(productId).get();
          if (productSnapshot.exists) {
            products.add(ProductModel.fromDocumentSnapshot(productSnapshot));
          }
        }

        faceHistory.value = faceHistoryData.copyWith(products: products);
      } else {
        debugPrint('No face history found for this user');
      }
    } catch (e) {
      debugPrint('Error fetching face history: $e');
    }
  }
}
