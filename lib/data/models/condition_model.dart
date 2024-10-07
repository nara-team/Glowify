import 'package:cloud_firestore/cloud_firestore.dart';

class ConditionModel {
  final List<String> productId;
  final String todo;

  ConditionModel({required this.productId, required this.todo});

  factory ConditionModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return ConditionModel(
      productId: data['product_id'] != null
          ? List<String>.from(data['product_id'])
          : [],
      todo: data['todo'] ?? '',
    );
  }
}
