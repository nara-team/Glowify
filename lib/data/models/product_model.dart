import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String productId;
  final String productName;
  final String productDescription;
  final String productImage;

  ProductModel({
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.productImage,
  });

  factory ProductModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    return ProductModel(
      productId: doc.id,
      productName: doc['product_name'],
      productDescription: doc['product_description'],
      productImage: doc['product_image'],
    );
  }
}