part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const LOGIN = _Paths.LOGIN;
  static const REGISTER = _Paths.REGISTER;
  static const SPLASH_SCREEN = _Paths.SPLASH_SCREEN;
  static const NAVBAR = _Paths.NAVBAR;
  static const BERANDA = _Paths.BERANDA;
  static const RIWAYAT = _Paths.RIWAYAT;
  static const PROFIL = _Paths.PROFIL;
  static const CHAT = _Paths.CHAT;
  static const TUTORIAL = _Paths.TUTORIAL;
  static const FACE_DETECTION = _Paths.FACE_DETECTION;
  static const NOTIFICATIONS = _Paths.NOTIFICATIONS;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const SPLASH_SCREEN = '/splash-screen';
  static const NAVBAR = '/navbar';
  static const BERANDA = '/beranda';
  static const RIWAYAT = '/riwayat';
  static const PROFIL = '/profil';
  static const CHAT = '/chat';
  static const TUTORIAL = '/tutorial';
  static const FACE_DETECTION = '/face-detection';
  static const NOTIFICATIONS = '/notifications';
}
