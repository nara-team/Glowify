import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:glowify/app/modules/beranda/controllers/beranda_controller.dart';
import 'package:glowify/app/modules/tutorial/controllers/tutorial_controller.dart';
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
    final TutorialController tutorialcontroller =
        Get.find<TutorialController>();
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
                              ? "Hi, ${controller.userName.value}"
                              : "Hi, Nama Pengguna",
                          style: medium.copyWith(
                              fontSize: largeSize, color: Colors.white),
                        )),
                    IconButton(
                      onPressed: () {
                        Get.toNamed('/notifications');
                      },
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    CarouselWithIndicator(
                      images: controller.imagesliderModel,
                    ),
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
                              children:
                                  controller.fetureDraftModel.map((feature) {
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Trending Tutorial",
                                style: semiBold.copyWith(fontSize: mediumSize),
                              ),
                              const SizedBox(height: 20),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Lihat Semua",
                                  style: medium.copyWith(
                                    fontSize: smallSize,
                                    color: primaryColor,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Gap(5),
                          Obx(() {
                            if (tutorialcontroller.isLoading.value) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (tutorialcontroller
                                .errorMessage.isNotEmpty) {
                              return Center(
                                child:
                                    Text(tutorialcontroller.errorMessage.value),
                              );
                            } else {
                              return SizedBox(
                                height: 200,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 4,
                                  itemBuilder: (context, index) {
                                    final article =
                                        tutorialcontroller.newsArticles[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: TrendingTutorialItem(
                                        iconPath: article.urlToImage!,
                                        contentText: article.title,
                                        onTap: () {
                                          debugPrint(
                                              'Artikel diklik: ${article.title}');
                                        },
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                          }),
                          const SizedBox(
                            height: 30,
                          ),
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
