import 'package:get/get.dart';

import '../modules/beranda/home/bindings/beranda_binding.dart';
import '../modules/beranda/home/views/beranda_view.dart';
import '../modules/beranda/booking/bindings/booking_binding.dart';
import '../modules/beranda/booking/views/booking_view.dart';
import '../modules/beranda/booking/views/bookingdetail_view.dart';
import '../modules/beranda/booking/views/buatjanji_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/beranda/face_detection/bindings/face_detection_binding.dart';
import '../modules/beranda/face_detection/views/face_detection_view.dart';
import '../modules/profil/keamanan/bindings/keamanan_binding.dart';
import '../modules/profil/keamanan/views/keamanan_view.dart';
import '../modules/beranda/konsultasi/bindings/konsultasi_binding.dart';
import '../modules/beranda/konsultasi/views/doctordetail_view.dart';
import '../modules/beranda/konsultasi/views/konsultasi_view.dart';
import '../modules/auth/login/bindings/login_binding.dart';
import '../modules/auth/login/views/login_view.dart';
import '../modules/navbar/bindings/navbar_binding.dart';
import '../modules/navbar/views/navbar_view.dart';
import '../modules/beranda/notification/views/notification_view.dart';
import '../modules/auth/onboarding/bindings/onboarding_binding.dart';
import '../modules/auth/onboarding/views/onboarding_view.dart';
import '../modules/profil/setting/bindings/profil_binding.dart';
import '../modules/profil/setting/views/profil_view.dart';
import '../modules/profil/pusat_bantuan/bindings/pusat_bantuan_binding.dart';
import '../modules/profil/pusat_bantuan/views/pusat_bantuan_view.dart';
import '../modules/auth/register/bindings/register_binding.dart';
import '../modules/auth/register/views/register_view.dart';
import '../modules/profil/riwayat/bindings/riwayat_binding.dart';
import '../modules/profil/riwayat/views/riwayat_view.dart';
import '../modules/auth/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/auth/splash_screen/views/splash_screen_view.dart';
import '../modules/tutorial/bindings/tutorial_binding.dart';
import '../modules/tutorial/views/detailtutorial_view.dart';
import '../modules/tutorial/views/tutorial_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.NAVBAR,
      page: () => const NavbarView(),
      binding: NavbarBinding(),
    ),
    GetPage(
      name: _Paths.BERANDA,
      page: () => const BerandaView(),
      binding: BerandaBinding(),
    ),
    GetPage(
      name: _Paths.RIWAYAT,
      page: () => const RiwayatView(),
      binding: RiwayatBinding(),
    ),
    GetPage(
      name: _Paths.PROFIL,
      page: () => const ProfilView(),
      binding: ProfilBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.TUTORIAL,
      page: () => const TutorialView(),
      binding: TutorialBinding(),
    ),
    GetPage(
      name: _Paths.TUTORIALDETAIL,
      page: () => const TutorialDetailView(),
      binding: TutorialBinding(),
    ),
    GetPage(
      name: _Paths.FACE_DETECTION,
      page: () => const FaceDetectionView(),
      binding: FaceDetectionBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING,
      page: () => const BookingView(),
      binding: BookingBinding(),
    ),
    GetPage(
      name: _Paths.BOOKINGDETAIL,
      page: () => const BookingDetailView(),
      binding: BookingBinding(),
    ),
    GetPage(
      name: _Paths.BUATJANJI,
      page: () => const BuatJanjiView(),
      binding: BookingBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => const NotificationView(),
    ),
    GetPage(
      name: _Paths.KEAMANAN,
      page: () => const KeamananView(),
      binding: KeamananBinding(),
    ),
    GetPage(
      name: _Paths.PUSAT_BANTUAN,
      page: () => const PusatBantuanView(),
      binding: PusatBantuanBinding(),
    ),
    GetPage(
      name: _Paths.KONSULTASI,
      page: () => const KonsultasiView(),
      binding: KonsultasiBinding(),
    ),
    GetPage(
      name: _Paths.DOCTORDETAIL,
      page: () => DoctordetailView(),
      binding: KonsultasiBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
  ];
}
