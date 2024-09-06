part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const NAVBAR = _Paths.NAVBAR;
  static const LOGIN = _Paths.LOGIN;
  static const REGISTER = _Paths.REGISTER;
  static const SPLASH_SCREEN = _Paths.SPLASH_SCREEN;
  static const BERANDA = _Paths.BERANDA;
  static const RIWAYAT = _Paths.RIWAYAT;
  static const PROFIL = _Paths.PROFIL;
  static const CHAT = _Paths.CHAT;
  static const TUTORIAL = _Paths.TUTORIAL;
  static const FACE_DETECTION = _Paths.FACE_DETECTION;
  static const BOOKING = _Paths.BOOKING;
  static const BOOKINGDETAIL = _Paths.BOOKINGDETAIL;
  static const NOTIFICATIONS = _Paths.NOTIFICATIONS;
  static const KEAMANAN = _Paths.KEAMANAN;
  static const PUSAT_BANTUAN = _Paths.PUSAT_BANTUAN;
}

abstract class _Paths {
  _Paths._();
  static const NAVBAR = '/navbar';
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const SPLASH_SCREEN = '/splash-screen';
  static const BERANDA = '/beranda';
  static const RIWAYAT = '/riwayat';
  static const PROFIL = '/profil';
  static const CHAT = '/chat';
  static const TUTORIAL = '/tutorial';
  static const FACE_DETECTION = '/face-detection';
  static const BOOKING = '/booking';
  static const BOOKINGDETAIL = '/bookingdetail';
  static const NOTIFICATIONS = '/notifications';
  static const KEAMANAN = '/keamanan';
  static const PUSAT_BANTUAN = '/pusat-bantuan';
}
