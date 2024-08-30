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
                    Obx(() => Text(
                          controller.userName.value.isNotEmpty
                              ? controller.userName.value
                              : "Nama Pengguna",
                          style: medium.copyWith(
                              fontSize: largeSize, color: whiteBackground1Color),
                        )),
                    IconButton(
                      onPressed: () {
                        controller.logout();
                      },
                      icon: const Icon(
                        Icons.logout,
                        size: 30,
                        color: whiteBackground2Color,
                      ),
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
                    Column(
                      children: [
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                              Text(
                                "Trending Tutorial",
                                style: semiBold.copyWith(fontSize: mediumSize),
                              ),
                              const SizedBox(height: 20),
                              Obx(() {
                                return SizedBox(
                                  height: 400,
                                  child: GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 1,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 1,
                                    ),
                                    itemCount:
                                        controller.trendingTutorialModel.length,
                                    itemBuilder: (context, index) {
                                      final item = controller
                                          .trendingTutorialModel[index];
                                      return TrendingTutorialItem(
                                        iconPath: item["iconPath"],
                                        contentText: item["contentText"],
                                        onTap: () {
                                          if (item["route"].isNotEmpty) {
                                            Get.toNamed(item["route"]);
                                          } else {
                                            const SnackBarCustom(
                                              judul: "fitur belum tersedia",
                                              pesan:
                                                  "Fitur sedang dalam pengembangan!",
                                            );
                                          }
                                        },
                                      );
                                    },
                                  ),
                                );
                              }),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ],
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
