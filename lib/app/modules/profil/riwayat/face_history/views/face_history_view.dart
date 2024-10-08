import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/data/models/product_model.dart';
import 'package:glowify/widget/appbarcustom.dart';
import '../controllers/face_history_controller.dart';
import 'package:intl/intl.dart';

class FaceHistoryView extends GetView<FaceHistoryController> {
  const FaceHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBackground1Color,
      appBar: const CustomAppBar(judul: "Riwayat Deteksi"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            if (controller.faceHistory.value.userId.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final faceHistory = controller.faceHistory.value;

            final String formattedTimeDetection =
                DateFormat('yyyy-MM-dd - kk:mm')
                    .format(faceHistory.timeDetection);

            return ListView(
              children: [
                const Text(
                  "Rekomendasi Perawatan:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  faceHistory.rekomendasiPerawatan,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 20),
                _buildAreaInfo("Area Dahi",
                    faceHistory.detailResultCondition['area_dahi']),
                _buildAreaInfo("Area Hidung",
                    faceHistory.detailResultCondition['area_hidung']),
                _buildAreaInfo("Area Pipi",
                    faceHistory.detailResultCondition['area_pipi']),
                const SizedBox(height: 20),
                const Text(
                  "Hasil Gambar:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Image.network(faceHistory.imageResult['dahi'], height: 150),
                const SizedBox(height: 10),
                Image.network(faceHistory.imageResult['hidung'], height: 150),
                const SizedBox(height: 10),
                Image.network(faceHistory.imageResult['pipi'], height: 150),
                const SizedBox(height: 20),
                const Text(
                  "Rekomendasi Produk:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                ...faceHistory.products
                    .map((product) => _buildProductCard(product))
                    .toList(),
                const SizedBox(height: 20),
                const Text(
                  "Kondisi Hasil Deteksi:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Hasil Deteksi: ${faceHistory.resultCondition['result_text'] ?? 'Tidak tersedia'}",
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 8),
                Text(
                  "Waktu Deteksi: $formattedTimeDetection",
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildAreaInfo(String title, Map<String, dynamic> area) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title:",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Text("Nama: ${area['name']}"),
        Text("Presentasi: ${area['persentation']}%"),
        Text("Status: ${area['status']}"),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildProductCard(ProductModel product) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading:
            Image.network(product.productImage, width: 50, fit: BoxFit.cover),
        title: Text(product.productName),
        subtitle: Text(product.productDescription),
      ),
    );
  }
}
