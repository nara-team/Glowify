import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await dotenv.load(fileName: "core/.env.dev");
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      theme: AppTheme.getAppTheme(),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
