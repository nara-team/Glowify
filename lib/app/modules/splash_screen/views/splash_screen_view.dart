import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:glowify/app/theme/app_theme.dart';
// ignore: depend_on_referenced_packages
import 'package:page_transition/page_transition.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glowify/app/modules/login/views/login_view.dart';
import 'package:glowify/app/modules/navbar/views/navbar_view.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Logika untuk pengecekan login status setelah splash selesai
    return AnimatedSplashScreen(
      splash: Image.asset(
        imgPath('logotext3x.png'),
      ),
      backgroundColor: Colors.white,
      duration: 1500,
      pageTransitionType: PageTransitionType.fade,
      nextScreen: const SplashRedirectView(), // Ganti dengan widget yang melakukan pengecekan login
    );
  }
}

class SplashRedirectView extends StatelessWidget {
  const SplashRedirectView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Pengecekan login status
    return FutureBuilder(
      future: _checkUserLoginStatus(),
      builder: (context, snapshot) {
        // Sementara menunggu pengecekan status
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          // Jika pengecekan selesai, arahkan pengguna sesuai status login
          return snapshot.data == true
              ? const NavbarView() // Jika sudah login, arahkan ke halaman Navbar/Beranda
              : const LoginView(); // Jika belum login, arahkan ke halaman login
        }
      },
    );
  }

  // Fungsi untuk memeriksa apakah pengguna sudah login
  Future<bool> _checkUserLoginStatus() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user != null; // Mengembalikan true jika pengguna sudah login
  }
}
