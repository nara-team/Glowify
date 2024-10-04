import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glowify/data/models/product_model.dart';

class FaceHistoryModel {
  final String userId;
  final Map<String, dynamic> detailResultCondition;
  final Map<String, dynamic> imageResult;
  final String rekomendasiPerawatan;
  final List<String> rekomendasiProduk;
  final List<ProductModel> products;
  final Map<String, dynamic> resultCondition;
  final DateTime timeDetection;

  FaceHistoryModel({
    required this.userId,
    required this.detailResultCondition,
    required this.imageResult,
    required this.rekomendasiPerawatan,
    required this.rekomendasiProduk,
    required this.products,
    required this.resultCondition,
    required this.timeDetection,
  });

  factory FaceHistoryModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    return FaceHistoryModel(
      userId: doc['UserId'],
      detailResultCondition: doc['detail_result_condition'],
      imageResult: doc['image_result'],
      rekomendasiPerawatan: doc['rekomendasi_perawatan'],
      rekomendasiProduk: List<String>.from(doc['rekomendasi_produk']),
      products: [],
      resultCondition: doc['result_condition'],
      timeDetection:
          (doc['result_condition']['time_detection'] as Timestamp).toDate(),
    );
  }

  FaceHistoryModel copyWith({
    String? userId,
    Map<String, dynamic>? detailResultCondition,
    Map<String, dynamic>? imageResult,
    String? rekomendasiPerawatan,
    List<String>? rekomendasiProduk,
    List<ProductModel>? products,
    Map<String, dynamic>? resultCondition,
    DateTime? timeDetection,
  }) {
    return FaceHistoryModel(
      userId: userId ?? this.userId,
      detailResultCondition:
          detailResultCondition ?? this.detailResultCondition,
      imageResult: imageResult ?? this.imageResult,
      rekomendasiPerawatan: rekomendasiPerawatan ?? this.rekomendasiPerawatan,
      rekomendasiProduk: rekomendasiProduk ?? this.rekomendasiProduk,
      products: products ?? this.products,
      resultCondition: resultCondition ?? this.resultCondition,
      timeDetection: timeDetection ?? this.timeDetection,
    );
  }
}
