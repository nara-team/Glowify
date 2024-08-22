import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/app/modules/beranda/controllers/beranda_controller.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/app/theme/sized_theme.dart';

import 'package:glowify/widget/card_image_information.dart';
import 'package:glowify/widget/carousel_with_indicator.dart';
import 'package:glowify/widget/featurebutton.dart';

class BerandaView extends GetView<BerandaController> {
  const BerandaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<BerandaController>(() => BerandaController());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 80,
                decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: PaddingCustom().paddingHorizontal(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Nama Pengguna",
                        style: medium.copyWith(
                            fontSize: largeSize, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications_none_outlined,
                          size: 30,
                          color: whiteBackground2Color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const CarouselWithIndicator(),
              const SizedBox(height: 30),
              Padding(
                padding: PaddingCustom().paddingHorizontal(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Feature",
                      style: semiBold.copyWith(fontSize: mediumSize),
                    ),
                    const SizedBox(height: 10),
                    Obx(() {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: controller.fetureDraft.map((feature) {
                          return FeatureButton(
                            pathIcon: feature["iconPath"],
                            featureColor: const Color(0xFFf6d5d8),
                            titleBtn: feature["caption"],
                            tekan: () {
                              if (feature["route"].isNotEmpty) {
                                Get.toNamed(feature["route"]);
                              } else {
                                snackBarSoonFeature(
                                  "fitur ${feature["caption"]} belum tersedia",
                                  "Fitur ${feature["caption"]} sedang dalam pengembangan!",
                                );
                              }
                            },
                          );
                        }).toList(),
                      );
                    }),
                    const SizedBox(height: 30),
                    Text(
                      "Trending Tutorial",
                      style: semiBold.copyWith(fontSize: mediumSize),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 180,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            10,
                            (index) => CardImageInformation(index: index),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SnackbarController snackBarSoonFeature(judul, pesan) {
    return Get.snackbar(
      judul,
      pesan,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
      backgroundColor: whiteBackground1Color,
      margin: const EdgeInsets.only(
        top: 20,
        right: 20,
        left: 20,
      ),
    );
  }
}
