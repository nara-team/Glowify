import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/app/modules/beranda/controllers/beranda_controller.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/app/theme/sized_theme.dart';

import 'package:glowify/widget/card_image_information.dart';
import 'package:glowify/widget/carousel_with_indicator.dart';
import 'package:glowify/widget/featurebutton.dart';

final List<Map<String, dynamic>> fetureDraft = [
  {
    "route": "",
    "iconPath": "assets/images/stethoscope.png",
    "caption": "Konsultasi\nDoctor",
  },
  {
    "route": "",
    "iconPath": "assets/images/face-recognition.png",
    "caption": "Deteksi\nKesehatan Wajah",
  },
  {
    "route": "",
    "iconPath": "assets/images/klinik.png",
    "caption": "Booking Klinik\nKecantikan",
  }
].obs;

class BerandaView extends GetView<BerandaController> {
  const BerandaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                      const Text(
                        "Nama Pengguna",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: whiteBackground2Color,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications_none_outlined,
                          size: 34,
                          color: whiteBackground2Color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const CarouselWithIndicator(),
              const SizedBox(height: 30),
              Padding(
                padding: PaddingCustom().paddingHorizontal(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Feature"),
                    const SizedBox(height: 20),
                    Obx(() {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: fetureDraft.map((feature) {
                          return FeatureButton(
                            pathIcon: feature["iconPath"],
                            featureColor: primaryColor,
                            titleBtn: feature["caption"],
                            tekan: () {
                              if (feature["route"].isNotEmpty) {
                                Get.toNamed(feature["route"]);
                              } else {
                                snackBarSoonFeature(
                                  "fitur ${feature["caption"]} belum tersedia",
                                  "Fitur ${feature["caption"]} sedang dalam pengembangan!",
                                );
                              }
                            },
                          );
                        }).toList(),
                      );
                    }),
                    const SizedBox(height: 30),
                    const Text("Trending Tutorial"),
                    const SizedBox(height: 30),
                    SizedBox(
                      height: 180,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        clipBehavior: Clip.none,
                        children: List.generate(
                          10,
                          (index) => CardImageInformation(index: index),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SnackbarController snackBarSoonFeature(judul, pesan) {
    return Get.snackbar(
      judul,
      pesan,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
      backgroundColor: whiteBackground1Color,
      margin: const EdgeInsets.only(
        top: 20,
        right: 20,
        left: 20,
      ),
    );
  }
}
