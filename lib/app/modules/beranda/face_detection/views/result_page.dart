import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/app/theme/sized_theme.dart';
import 'package:glowify/data/models/product_model.dart';
import 'package:glowify/widget/appbarcustom.dart';
import 'package:glowify/widget/custom_button.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../widget/result_tile.dart';
import '../controllers/resultdetection_controller.dart';

class ResultPage extends GetView<ResultDetectionController> {
  final List<String> results;
  final List<String> confidences;
  final File? imageForehead;
  final File? imageCheek;
  final File? imageNose;

  const ResultPage({
    super.key,
    required this.results,
    required this.confidences,
    required this.imageForehead,
    required this.imageCheek,
    required this.imageNose,
  });

  @override
  Widget build(BuildContext context) {
    final ResultDetectionController controller =
        Get.put(ResultDetectionController());

    controller.fetchCondition(results);

    return Scaffold(
      appBar: const CustomAppBar(judul: "Hasil Deteksi Wajah"),
      body: Obx(() {
        if (controller.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (imageForehead != null)
                    Image.file(imageForehead!, width: 80, height: 80),
                  if (imageCheek != null)
                    Image.file(imageCheek!, width: 80, height: 80),
                  if (imageNose != null)
                    Image.file(imageNose!, width: 80, height: 80),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Kondisi Wajah',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _getConditionIcon(_determineFinalResult()),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hari ini',
                        style: bold.copyWith(
                          fontSize: regularSize,
                        ),
                      ),
                      Text(
                        _getConditionText(),
                        style: TextStyle(
                          color: _getConditionColor(),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Detail Hasil Analisis',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: results.length,
                itemBuilder: (context, index) {
                  return ResultTile(
                    area: index == 0
                        ? "Dahi"
                        : index == 1
                            ? "Pipi"
                            : "Hidung",
                    result: results[index],
                    confidence: confidences[index],
                  );
                },
              ),
              const Gap(30),
              const Text(
                'Rekomendasi Perawatan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                controller.condition.value.todo.isNotEmpty
                    ? controller.condition.value.todo
                    : 'Tidak ada rekomendasi perawatan untuk kondisi ini',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),
              const Text(
                'Rekomendasi Produk',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Obx(() {
                return SizedBox(
                  height: 220,
                  child: controller.loading.value
                      ? _buildSkeletonLoader()
                      : controller.products.isNotEmpty
                          ? PageView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.products.length,
                              itemBuilder: (context, index) {
                                return ProductCard(
                                    product: controller.products[index]);
                              },
                            )
                          : const Center(
                              child: Text(
                                'Tidak ada rekomendasi produk untuk kondisi ini',
                              ),
                            ),
                );
              }),
              const SizedBox(height: 32),
              const Text(
                "Disclaimer: Fitur ini menggunakan AI yang menganalisis kondisi wajah dengan tujuan merekomendasikan produk kecantikan. Ini tidak boleh digunakan sebagai, atau sebagai pengganti, nasihat medis. Jika Anda memiliki kekhawatiran medis mengenai kulit Anda, konsultasikan dengan Tenaga Medis",
                textAlign: TextAlign.justify,
              ),
              const Gap(20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomButton(
                    text: 'Konsultasi Ke Dokter',
                    onPressed: () {
                      Get.toNamed('/konsultasi');
                    },
                    hasOutline: false,
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Kembali ke Beranda',
                    onPressed: () {
                      Get.offAllNamed('/navbar');
                    },
                    hasOutline: true,
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSkeletonLoader() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 2,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Skeletonizer(
            child: Container(
              width: 160,
              height: 220,
              decoration: BoxDecoration(
                color: whiteBackground1Color,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        );
      },
    );
  }

  String _determineFinalResult() {
    if (results.isEmpty) return "Tidak Ada Data";
    int healthyCount = results.where((result) => result == "Sehat").length;
    if (healthyCount == 3) {
      return "Sehat";
    } else if (healthyCount > 0) {
      return "Perlu Perhatian";
    } else {
      return "Butuh Perawatan";
    }
  }

  Icon _getConditionIcon(String result) {
    switch (result) {
      case "Sehat":
        return const Icon(
          Iconsax.emoji_happy,
          size: 35,
          color: Colors.green,
        );
      case "Perlu Perhatian":
        return const Icon(
          Iconsax.emoji_normal,
          size: 35,
          color: Color.fromARGB(255, 255, 174, 0),
        );
      case "Butuh Perawatan":
        return const Icon(
          Iconsax.emoji_sad,
          size: 35,
          color: Colors.red,
        );
      default:
        return const Icon(
          Iconsax.emoji_normal,
          size: 35,
          color: Colors.grey,
        );
    }
  }

  Color _getConditionColor() {
    String result = _determineFinalResult();
    switch (result) {
      case "Sehat":
        return Colors.green;
      case "Perlu Perhatian":
        return const Color.fromARGB(255, 255, 174, 0);
      case "Butuh Perawatan":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getConditionText() {
    String result = _determineFinalResult();
    switch (result) {
      case "Sehat":
        return "Sehat";
      case "Perlu Perhatian":
        return "Perlu Perhatian";
      case "Butuh Perawatan":
        return "Butuh Perawatan";
      default:
        return "Tidak Ada Data";
    }
  }
}

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => debugPrint('${product.productName} tapped'),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 120,
              width: double.infinity,
              child: Image.network(
                product.productImage,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: PaddingCustom().paddingAll(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.productName,
                    style: bold.copyWith(
                      fontSize: mediumSize,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    product.productDescription,
                    style: const TextStyle(
                      fontSize: regularSize,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
