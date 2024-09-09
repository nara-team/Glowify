part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const NAVBAR = _Paths.NAVBAR;
  static const LOGIN = _Paths.LOGIN;
  static const SPLASH_SCREEN = _Paths.SPLASH_SCREEN;
  static const BERANDA = _Paths.BERANDA;
  static const PROFIL = _Paths.PROFIL;
  static const CHAT = _Paths.CHAT;
  static const NOTIFICATION = _Paths.NOTIFICATION;
  static const BOOKING = _Paths.BOOKING;
  static const FACE_DETECTION = _Paths.FACE_DETECTION;
}

abstract class _Paths {
  _Paths._();
  static const NAVBAR = '/navbar';
  static const LOGIN = '/login';
  static const SPLASH_SCREEN = '/splash-screen';
  static const BERANDA = '/beranda';
  static const PROFIL = '/profil';
  static const CHAT = '/chat';
  static const NOTIFICATION= '/notification';
  static const BOOKING = '/booking';
  static const FACE_DETECTION = '/face-detection';
}
