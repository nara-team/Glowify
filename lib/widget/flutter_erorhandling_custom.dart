import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glowify/app/theme/app_theme.dart';

class CustomErrorWidget {
  static Widget builder(FlutterErrorDetails errorDetails) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset("assets/images/bug.svg"),
              const Gap(30),
              Text(
                'Ada yang salah nih kayaknya',
                style: bold.copyWith(
                  fontSize: largeSize,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
