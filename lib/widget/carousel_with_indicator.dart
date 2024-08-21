import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:glowify/app/theme/app_theme.dart';

class CarouselWithIndicator extends StatefulWidget {
  const CarouselWithIndicator({super.key});

  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;
  final List<Widget> _imageSliders = [
    InkWell(
      child: Container(
        height: 150,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/banner_home.png"),
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      onTap: () {
        debugPrint("route test");
      },
    ),
    InkWell(
      child: Container(
        height: 150,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/banner_home.png"),
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      onTap: () {
        debugPrint("route test");
      },
    ),
    InkWell(
      child: Container(
        height: 150,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/banner_home.png"),
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      onTap: () {
        debugPrint("route test");
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
                          ? whiteBackground1Color
                          : primaryColor)
                      .withOpacity(_current == entry.key ? 0.8 : 0.2),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
