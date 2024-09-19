import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:glowify/app/theme/sized_theme.dart';
import 'package:glowify/widget/card_image_information.dart';
import '../controllers/tutorial_controller.dart';
import 'package:glowify/app/theme/app_theme.dart';

class TutorialView extends GetView<TutorialController> {
  const TutorialView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FocusNode textFieldFocusNode = FocusNode();

    textFieldFocusNode.addListener(() {
      controller.isTextFieldFocused.value = textFieldFocusNode.hasFocus;
    });

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: PaddingCustom().paddingOnly(20, 30, 20, 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onChanged: (query) {
                  controller.searchNews(query);
                },
                focusNode: textFieldFocusNode,
                cursorColor: primaryColor,
                decoration: InputDecoration(
                  hintText: 'Cari disini..',
                  prefixIcon: const Icon(Icons.search, color: primaryColor),
                  filled: true,
                  fillColor: abuLightColor.withOpacity(0.5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const Gap(20),
              Obx(
                () {
                  final hasFocus = controller.isTextFieldFocused.value;
                  if (hasFocus) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Kategori Tutorial",
                          style: semiBold.copyWith(fontSize: mediumSize),
                        ),
                        const Gap(20),
                        Wrap(
                          spacing: 20,
                          runSpacing: 10,
                          children: categories.map((category) {
                            return Obx(() {
                              final isSelected =
                                  selectedCategory.value == category;
                              return ChoiceChip(
                                label: Text(
                                  category,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : primaryColor.withOpacity(0.7),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                selected: isSelected,
                                selectedColor: primaryColor,
                                backgroundColor: primaryColor.withOpacity(0.2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: BorderSide(
                                    color: primaryColor.withOpacity(0.4),
                                  ),
                                ),
                                onSelected: (selected) {
                                  selectedCategory.value = category;
                                },
                              );
                            });
                          }).toList(),
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              const Gap(20),
              Text(
                "Trending Tutorial",
                style: semiBold.copyWith(fontSize: mediumSize),
              ),
              const Gap(20),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Skeletonizer(
                      enabled: true,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 15,
                          childAspectRatio: 0.9,
                        ),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (controller.errorMessage.isNotEmpty) {
                    return Center(child: Text(controller.errorMessage.value));
                  } else {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 15,
                        childAspectRatio: 0.9,
                      ),
                      itemCount: controller.newsArticles.length,
                      itemBuilder: (context, index) {
                        final article = controller.newsArticles[index];
                        return TrendingTutorialItem(
                          iconPath: '${article.urlToImage}',
                          contentText: article.title,
                          onTap: () {
                            Get.toNamed('/tutorialdetail', arguments: article);
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
