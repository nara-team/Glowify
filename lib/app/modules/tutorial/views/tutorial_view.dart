import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/sized_theme.dart';
import 'package:glowify/widget/card_image_information.dart';
import '../controllers/tutorial_controller.dart';
import 'package:glowify/app/theme/app_theme.dart';

class TutorialView extends GetView<TutorialController> {
  const TutorialView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar Section
              Container(
                decoration: BoxDecoration(
                  color: whiteBackground1Color,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(1, 2),
                    ),
                  ],
                ),
                child: TextField(
                  style: const TextStyle(fontSize: 16),
                  onChanged: (query) {
                    controller.searchNews(query);
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: whiteBackground1Color,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Search...",
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
              const Gap(20),
              // Category Section
              Text(
                "Kategori Tutorial",
                style: semiBold.copyWith(fontSize: mediumSize),
              ),
              const Gap(20),
              Obx(() => Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: controller.categories.map((category) {
                      final isSelected = controller.selectedCategory.value == category;
                      return GestureDetector(
                        onTap: () {
                          controller.selectedCategory.value = category;
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor.withOpacity(0.2) : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected ? primaryColor : primaryColor.withOpacity(0.2),
                            ),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: blackColor.withOpacity(0.1),
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ]
                                : [],
                          ),
                          child: Text(
                            category,
                            style: medium.copyWith(
                              color: isSelected ? primaryColor : primaryColor.withOpacity(0.6),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  )),
              const Gap(20),
              // Trending Tutorial Section
              Text(
                "Trending Tutorial",
                style: semiBold.copyWith(fontSize: mediumSize),
              ),
              const Gap(20),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (controller.errorMessage.isNotEmpty) {
                    return Center(child: Text(controller.errorMessage.value));
                  } else {
                    return GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 15,
                        childAspectRatio: 0.9,
                      ),
                      itemCount: controller.newsArticles.length,
                      itemBuilder: (context, index) {
                        final article = controller.newsArticles[index];
                        return TrendingTutorialItem(
                          iconPath: 'assets/images/card_information_tutorial_sample.png',
                          contentText: article.title,
                          onTap: () {
                            debugPrint('Artikel diklik: ${article.title}');
                          },
                        );
                      },
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
