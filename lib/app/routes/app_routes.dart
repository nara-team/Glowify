part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const navbar = _Paths.navbar;
  static const login = _Paths.login;
  static const register = _Paths.register;
  static const splashScreen = _Paths.splashScreen;
  static const beranda = _Paths.beranda;
  static const riwayat = _Paths.riwayat;
  static const profil = _Paths.profil;
  static const chat = _Paths.chat;
  static const tutorial = _Paths.tutorial;
  static const tutorialdetail = _Paths.tutorialdetail;
  static const faceDetection = _Paths.faceDetection;
  static const booking = _Paths.booking;
  static const bookingdetail = _Paths.bookingdetail;
  static const notifications = _Paths.notifications;
  static const informasiakun = _Paths.informasiakun;
  static const pusatBantuan = _Paths.pusatBantuan;
  static const konsultasi = _Paths.konsultasi;
  static const doctordetail = _Paths.doctordetail;
  static const onboarding = _Paths.onboarding;
  static const chatroom = _Paths.chat + _Paths.chatroom;
  static const buatjanji = _Paths.buatjanji;
  static const faceHistory = _Paths.faceHistory;
}

abstract class _Paths {
  _Paths._();
  static const navbar = '/navbar';
  static const login = '/login';
  static const register = '/register';
  static const splashScreen = '/splash-screen';
  static const beranda = '/beranda';
  static const riwayat = '/riwayatbooking';
  static const profil = '/profil';
  static const chat = '/chat';
  static const tutorial = '/tutorial';
  static const tutorialdetail = '/tutorialdetail';
  static const faceDetection = '/face-detection';
  static const booking = '/booking';
  static const bookingdetail = '/bookingdetail';
  static const notifications = '/notifications';
  static const informasiakun = '/informasiakun';
  static const pusatBantuan = '/pusat-bantuan';
  static const konsultasi = '/konsultasi';
  static const doctordetail = '/doctordetail';
  static const onboarding = '/onboarding';
  static const chatroom = '/chatroom';
  static const buatjanji = '/buatjanji';
  static const faceHistory = '/face-history';
}
