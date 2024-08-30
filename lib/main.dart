import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Cek apakah user sudah login
  User? user = FirebaseAuth.instance.currentUser;
  String initialRoute = user == null ? Routes.LOGIN : Routes.NAVBAR;

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      theme: AppTheme.getAppTheme(),
      initialRoute: initialRoute,
      getPages: AppPages.routes,
    ),
  );
}
