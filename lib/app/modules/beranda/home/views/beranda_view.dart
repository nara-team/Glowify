import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:glowify/app/modules/beranda/home/controllers/beranda_controller.dart';
import 'package:glowify/app/modules/navbar/controllers/navbar_controller.dart';
import 'package:glowify/app/modules/tutorial/controllers/tutorial_controller.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/app/theme/sized_theme.dart';
import 'package:glowify/widget/card_image_information.dart';
import 'package:glowify/widget/carousel_with_indicator.dart';
import 'package:glowify/widget/featurebutton.dart';
import 'package:glowify/widget/snackbar_custom.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BerandaView extends GetView<BerandaController> {
  const BerandaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BerandaController controller = Get.put(BerandaController());
    final TutorialController tutorialController = Get.find<TutorialController>();
    final NavbarController navbarController = Get.find<NavbarController>();

    // Menambahkan GlobalKey untuk setiap FeatureButton
    controller.featureButtonKeys.addAll(
      List.generate(
        controller.fetureDraftModel.length,
        (index) => GlobalKey(),
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initTargets(controller.fetureDraftModel);
      controller.showTutorial(context);
    });

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
                    Obx(
                      () => Text(
                        controller.userName.value.isNotEmpty
                            ? "Hi, ${controller.userName.value}"
                            : "Hi, Nama Pengguna",
                        style: medium.copyWith(
                          fontSize: largeSize,
                          color: whiteBackground1Color,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.toNamed('/notifications');
                      },
                      icon: const Icon(
                        Iconsax.notification5,
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
                          Container(
                            key: controller.featureHighlightKey,
                            child: Text(
                              "Feature",
                              style: semiBold.copyWith(fontSize: mediumSize),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Obx(() {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                controller.fetureDraftModel.length,
                                (index) {
                                  return FeatureButton(
                                    key: controller.featureButtonKeys[index],
                                    pathIcon: controller.fetureDraftModel[index]["iconPath"],
                                    featureColor: const Color(0xFFf6d5d8),
                                    titleBtn: controller.fetureDraftModel[index]["caption"],
                                    tekan: () {
                                      if (controller.fetureDraftModel[index]["route"].isNotEmpty) {
                                        Get.toNamed(controller.fetureDraftModel[index]["route"]);
                                      } else {
                                        SnackBarCustom(
                                          judul:
                                              "fitur ${controller.fetureDraftModel[index]["caption"]} belum tersedia",
                                          pesan:
                                              "Fitur ${controller.fetureDraftModel[index]["caption"]} sedang dalam pengembangan!",
                                        ).show();
                                      }
                                    },
                                  );
                                },
                              ),
                            );
                          }),
                          const SizedBox(height: 30),
                          Text(
                            "Trending Tutorial",
                            style: semiBold.copyWith(fontSize: mediumSize),
                          ),
                          const SizedBox(height: 20),
                          const Gap(5),
                          Obx(() {
                            if (tutorialController.isLoading.value) {
                              return Skeletonizer(
                                enabled: tutorialController.isLoading.value,
                                child: SizedBox(
                                  height: 200,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 4,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Container(
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color: whiteBackground1Color,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            } else if (tutorialController.errorMessage.isNotEmpty) {
                              return Center(
                                child: Text(tutorialController.errorMessage.value),
                              );
                            } else {
                              final itemCount = tutorialController.newsArticles.length > 4
                                  ? 4
                                  : tutorialController.newsArticles.length;

                              return SizedBox(
                                height: 200,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: itemCount + 1,
                                  itemBuilder: (context, index) {
                                    if (index == itemCount) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            navbarController.changeTabIndex(2);
                                          },
                                          child: Container(
                                            width: 150,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                'Lihat Semua',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: primaryColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }

                                    final article = tutorialController.newsArticles[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: TrendingTutorialItem(
                                        iconPath: article.urlToImage!,
                                        contentText: article.title,
                                        onTap: () {
                                          Get.toNamed('/tutorialdetail', arguments: article);
                                        },
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                          }),
                          const SizedBox(height: 30),
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
