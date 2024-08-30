import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';

class CarouselWithIndicator extends StatefulWidget {
  final List<Map<String, dynamic>> images;

  const CarouselWithIndicator({super.key, required this.images});

  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _imageSliders = widget.images.map((imageData) {
      return InkWell(
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imageData["iconPath"]),
              fit: BoxFit.cover,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
        ),
        onTap: () {
          if (imageData["route"].isNotEmpty) {
            Get.toNamed(imageData["route"]);
          } else {
            debugPrint("route test");
          }
        },
      );
    }).toList();

    return Column(
      children: [
        CarouselSlider(
          items: _imageSliders,
          options: CarouselOptions(
            autoPlay: false,
            enlargeCenterPage: true,
            height: 150,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _imageSliders.asMap().entries.map((entry) {
            return GestureDetector(
              child: Container(
                width: 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? primaryColor
                          : primaryColor)
                      .withOpacity(_current == entry.key ? 0.9 : 0.2),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
