import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:glowify/app/modules/tutorial/controllers/detailtutorial_controller.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/app/theme/sized_theme.dart';
import 'package:glowify/widget/appbarcustom.dart';
import 'package:intl/intl.dart';
import 'package:glowify/data/models/news_article.dart';

class TutorialDetailView extends GetView<TutorialDetailController> {
  const TutorialDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NewsArticle article = Get.arguments;

    return Scaffold(
      appBar: const CustomAppBar(
        judul: "Artikel untuk kamu",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: PaddingCustom().paddingHorizontalVertical(20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (article.urlToImage != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      article.urlToImage!,
                      fit: BoxFit.cover,
                    ),
                  ),
                const Gap(16.0),
                Text(
                  article.title,
                  style: bold.copyWith(
                    fontSize: largeSize,
                    color: blackColor,
                  ),
                ),
                const Gap(1),
                const Gap(8.0),
                Text(
                  'Published At: ${DateFormat.yMMMMd().format(article.publishedAt)}',
                  style: medium.copyWith(
                    fontSize: regularSize,
                    color: abuMedColor,
                  ),
                ),
                const Gap(16.0),
                Text(
                  article.description,
                  textAlign: TextAlign.justify,
                  style: medium.copyWith(
                    fontSize: regularSize,
                    color: blackColor,
                  ),
                ),
                const Gap(16.0),
                const Gap(16.0),
                ElevatedButton(
                  onPressed: () {
                    debugPrint("Baca Selengkapnya ditekan");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Baca Selengkapnya',
                    style: semiBold.copyWith(
                      fontSize: mediumSize,
                      color: whiteBackground1Color,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
