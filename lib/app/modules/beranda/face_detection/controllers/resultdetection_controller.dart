import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/data/models/condition_model.dart';
import 'package:glowify/data/models/product_model.dart';

class ResultDetectionController extends GetxController {
  var condition = ConditionModel(productId: [], todo: '').obs;
  var products = <ProductModel>[].obs;
  var loading = true.obs;

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

  String _generateConditionId(List<String> results) {
    List<String> ids = [];

    for (int i = 0; i < results.length; i++) {
      if (results[i] == "Sehat") {
        ids.add("$i");
      } else {
        ids.add("$i!");
      }
    }

    return ids.join("");
  }
}
