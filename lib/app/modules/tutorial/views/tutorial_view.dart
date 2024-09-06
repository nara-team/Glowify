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
    final TutorialController controller = Get.put(TutorialController());

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: PaddingCustom().paddingOnly(20, 30, 20, 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                child: Obx(() => TextField(
                      controller: controller.searchController,
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
                        suffixIcon: controller.searchQuery.value.isNotEmpty
                            ? IconButton(
                                icon: const Icon(
                                  Icons.clear,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  controller.clearSearch();
                                },
                              )
                            : null,
                      ),
                    )),
              ),
              const Gap(20),
              Text(
                "Kategori Tutorial",
                style: semiBold.copyWith(fontSize: mediumSize),
              ),
              const Gap(20),
              Obx(() => Wrap(
                    spacing: 20,
                    runSpacing: 10,
                    children: controller.categories.map((category) {
                      final isSelected =
                          controller.selectedCategory.value == category;
                      return GestureDetector(
                        onTap: () {
                          controller.selectedCategory.value = category;
                        },
                        child: Container(
                          padding:
                              PaddingCustom().paddingHorizontalVertical(12, 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? primaryColor
                                : whiteBackground1Color,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: primaryColor.withOpacity(0.2),
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
                              color: isSelected
                                  ? Colors.white
                                  : primaryColor.withOpacity(0.6),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  )),
              const Gap(20),
              Text(
                "Trending Tutorial",
                style: semiBold.copyWith(fontSize: mediumSize),
              ),
              const Gap(20),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (controller.filteredArticles.isEmpty) {
                    return const Center(child: Text('No articles found.'));
                  } else {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 15,
                        childAspectRatio: 0.9,
                      ),
                      itemCount: controller.filteredArticles.length,
                      itemBuilder: (context, index) {
                        final article = controller.filteredArticles[index];
                        return TrendingTutorialItem(
                          iconPath:
                              'assets/images/card_information_tutorial_sample.png',
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
