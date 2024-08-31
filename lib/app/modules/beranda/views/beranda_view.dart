import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/app/modules/beranda/controllers/beranda_controller.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/app/theme/sized_theme.dart';
import 'package:glowify/widget/card_image_information.dart';
import 'package:glowify/widget/carousel_with_indicator.dart';
import 'package:glowify/widget/featurebutton.dart';
import 'package:glowify/widget/snackbar_custom.dart';

class BerandaView extends GetView<BerandaController> {
  const BerandaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<BerandaController>(() => BerandaController());
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Greeting Section
            Container(
              height: 100,
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => Text(
                              controller.userName.value.isNotEmpty
                                  ? "Hi, ${controller.userName.value}"
                                  : "Hi, Nama Pengguna",
                              style: medium.copyWith(
                                  fontSize: largeSize, color: Colors.white),
                            )),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.notifications,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Get.toNamed('/notifications');
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    CarouselWithIndicator(
                      images: controller.imagesliderModel,
                    ),
                    const SizedBox(height: 30),
                    // Feature Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Features",
                            style: semiBold.copyWith(fontSize: mediumSize),
                          ),
                          const SizedBox(height: 10),
                          Obx(() {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: controller.fetureDraftModel
                                  .map((feature) {
                                return FeatureButton(
                                  pathIcon: feature["iconPath"],
                                  featureColor: const Color(0xFFf6d5d8),
                                  titleBtn: feature["caption"],
                                  tekan: () {
                                    if (feature["route"].isNotEmpty) {
                                      Get.toNamed(feature["route"]);
                                    } else {
                                      SnackBarCustom(
                                        judul:
                                            "fitur ${feature["caption"]} belum tersedia",
                                        pesan:
                                            "Fitur ${feature["caption"]} sedang dalam pengembangan!",
                                      ).show();
                                    }
                                  },
                                );
                              }).toList(),
                            );
                          }),
                          const SizedBox(height: 30),
                          // Trending Tutorial Section
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Trending Tutorial",
                                style: semiBold.copyWith(fontSize: mediumSize),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Navigate to the full list of tutorials
                                  Get.toNamed('/all-tutorials');
                                },
                                child: Text(
                                  "See All",
                                  style: medium.copyWith(
                                      fontSize: smallSize,
                                      color: const Color.fromARGB(255, 255, 131, 173)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                        
                          Obx(() {
                            return SizedBox(
                              height: 200, // Lebar sedikit lebih besar dari sebelumnya
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.trendingTutorialModel.length,
                                itemBuilder: (context, index) {
                                  final item = controller.trendingTutorialModel[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 10, bottom: 20), // Padding bawah ditambahkan
                                    child: TrendingTutorialItem(
                                      iconPath: item["iconPath"],
                                      contentText: item["contentText"],
                                      onTap: () {
                                        if (item["route"].isNotEmpty) {
                                          Get.toNamed(item["route"]);
                                        } else {
                                          SnackBarCustom(
                                            judul: "Fitur belum tersedia",
                                            pesan: "Fitur sedang dalam pengembangan!",
                                          ).show();
                                        }
                                      },
                                    ),
                                  );
                                },
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
