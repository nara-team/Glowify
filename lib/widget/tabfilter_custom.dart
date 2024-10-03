import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/app/theme/sized_theme.dart';

class TabFilterCustom extends StatelessWidget {
  final List<String> categories;
  final RxString selectedCategory;
  final Function(String) onCategorySelected;
  final bool isRow;
  final bool isScrollable; 
  final double horizontal;
  final double vertical;

  const TabFilterCustom({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
    this.isRow = false,
    this.isScrollable = false, 
    required this.horizontal,
    required this.vertical,
  });

  @override
  Widget build(BuildContext context) {
    if (isScrollable) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categories.map((category) {
            return Obx(() {
              final isSelected = selectedCategory.value == category;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ChoiceChip(
                  labelPadding: PaddingCustom()
                      .paddingHorizontalVertical(horizontal, vertical),
                  showCheckmark: false,
                  checkmarkColor: whiteBackground1Color,
                  label: Text(
                    category,
                    style: TextStyle(
                      color: isSelected ? whiteBackground1Color : blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  selected: isSelected,
                  selectedColor: primaryColor,
                  backgroundColor: whiteBackground1Color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      color: primaryColor,
                    ),
                  ),
                  onSelected: (selected) {
                    onCategorySelected(category);
                  },
                ),
              );
            });
          }).toList(),
        ),
      );
    }

    return isRow
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: categories.map((category) {
              return Obx(() {
                final isSelected = selectedCategory.value == category;
                return ChoiceChip(
                  labelPadding: PaddingCustom()
                      .paddingHorizontalVertical(horizontal, vertical),
                  showCheckmark: false,
                  checkmarkColor: whiteBackground1Color,
                  label: Text(
                    category,
                    style: TextStyle(
                      color: isSelected ? whiteBackground1Color : blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  selected: isSelected,
                  selectedColor: primaryColor,
                  backgroundColor: whiteBackground1Color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      color: primaryColor,
                    ),
                  ),
                  onSelected: (selected) {
                    onCategorySelected(category);
                  },
                );
              });
            }).toList(),
          )
        : Wrap(
            spacing: 20,
            runSpacing: 10,
            children: categories.map((category) {
              return Obx(() {
                final isSelected = selectedCategory.value == category;
                return ChoiceChip(
                  labelPadding: PaddingCustom()
                      .paddingHorizontalVertical(horizontal, vertical),
                  showCheckmark: false,
                  checkmarkColor: whiteBackground1Color,
                  label: Text(
                    category,
                    style: TextStyle(
                      color: isSelected ? whiteBackground1Color : blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  selected: isSelected,
                  selectedColor: primaryColor,
                  backgroundColor: whiteBackground1Color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      color: primaryColor,
                    ),
                  ),
                  onSelected: (selected) {
                    onCategorySelected(category);
                  },
                );
              });
            }).toList(),
          );
  }
}
