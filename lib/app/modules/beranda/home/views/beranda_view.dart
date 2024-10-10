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
import 'package:glowify/widget/nodata_handling_widget.dart';
import 'package:glowify/widget/snackbar_custom.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BerandaView extends GetView<BerandaController> {
  const BerandaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BerandaController controller = Get.put(BerandaController());
    final TutorialController tutorialController =
        Get.find<TutorialController>();
    final NavbarController navbarController = Get.find<NavbarController>();

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
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (!controller.isLoading.value &&
                        controller.targets.isNotEmpty) {
                      Future.delayed(const Duration(milliseconds: 500), () {
                        controller.showTutorial(Scaffold.of(context).context);
                      });
                    }
                  });

                  return Column(
                    children: [
                      const Gap(20),
                      Obx(
                        () => controller.isbannerLoading.value
                            ? Skeletonizer(
                                enabled: controller.isLoading.value,
                                child: SizedBox(
                                  height: 150,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 3,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: PaddingCustom()
                                            .paddingHorizontal(8),
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: abuLightColor,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : controller.bannerSliders.isEmpty
                                ? const NodataHandling(
                                    iconVariant: IconVariant.dokumen,
                                    messageText: "tidak ada banner",
                                    iconSizeVariant: IconSize.kecil,
                                  )
                                : CarouselWithIndicator(
                                    images: controller.bannerSliders
                                        .map((banner) => {
                                              "iconPath": banner.image,
                                              "route": banner.route,
                                            })
                                        .toList(),
                                  ),
                      ),
                      const Gap(30),
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
                            if (controller.mainFeatures.isEmpty)
                              const Center(
                                child: Text(
                                  "Tidak ada fitur yang tersedia",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 16),
                                ),
                              )
                            else
                              Wrap(
                                spacing: 25.0,
                                runSpacing: 8.0,
                                alignment: WrapAlignment.start,
                                children: List.generate(
                                  controller.mainFeatures.length,
                                  (index) {
                                    var feature =
                                        controller.mainFeatures[index];
                                    return FeatureButton(
                                      key: controller.featureButtonKeys[index],
                                      pathIcon: feature.icon ?? '',
                                      featureColor: const Color(0xFFf6d5d8),
                                      titleBtn: feature.title ?? 'No Title',
                                      tekan: () {
                                        if (feature.route != null &&
                                            feature.route!.isNotEmpty) {
                                          Get.toNamed(feature.route!);
                                        } else {
                                          SnackBarCustom(
                                            judul:
                                                "Fitur ${feature.title} belum tersedia",
                                            pesan:
                                                "Fitur ${feature.title} sedang dalam pengembangan!",
                                          ).show();
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                            const SizedBox(height: 30),
                            Text(
                              "Trending Tutorial",
                              style: semiBold.copyWith(fontSize: mediumSize),
                            ),
                            const SizedBox(height: 20),
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
                                          padding: PaddingCustom()
                                              .paddingHorizontal(8),
                                          child: Container(
                                            width: 150,
                                            decoration: BoxDecoration(
                                              color: whiteBackground1Color,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              } else if (tutorialController
                                  .errorMessage.isNotEmpty) {
                                return const NodataHandling(
                                  iconVariant: IconVariant.dokumen,
                                  messageText: "Belum ada tutorial",
                                );
                              } else {
                                final itemCount =
                                    tutorialController.newsArticles.length > 4
                                        ? 4
                                        : tutorialController
                                            .newsArticles.length;
                                return SizedBox(
                                  height: 200,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: itemCount + 1,
                                    itemBuilder: (context, index) {
                                      if (index == itemCount) {
                                        return Padding(
                                          padding: PaddingCustom()
                                              .paddingHorizontal(8),
                                          child: GestureDetector(
                                            onTap: () {
                                              navbarController
                                                  .changeTabIndex(3);
                                            },
                                            child: Container(
                                              width: 150,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Lihat Semua',
                                                  style: bold.copyWith(
                                                      fontSize: mediumSize,
                                                      color: primaryColor),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      final article = tutorialController
                                          .newsArticles[index];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: TrendingTutorialItem(
                                          iconPath: article.urlToImage!,
                                          contentText: article.title,
                                          onTap: () {
                                            Get.toNamed('/tutorialdetail',
                                                arguments: article);
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
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
