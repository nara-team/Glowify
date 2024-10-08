import 'package:get/get.dart';

import '../modules/auth/login/bindings/login_binding.dart';
import '../modules/auth/login/views/login_view.dart';
import '../modules/auth/onboarding/bindings/onboarding_binding.dart';
import '../modules/auth/onboarding/views/onboarding_view.dart';
import '../modules/auth/register/bindings/register_binding.dart';
import '../modules/auth/register/views/register_view.dart';
import '../modules/auth/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/auth/splash_screen/views/splash_screen_view.dart';
import '../modules/beranda/booking/bindings/booking_binding.dart';
import '../modules/beranda/booking/views/booking_view.dart';
import '../modules/beranda/booking/views/bookingdetail_view.dart';
import '../modules/beranda/booking/views/buatjanji_view.dart';
import '../modules/beranda/face_detection/bindings/face_detection_binding.dart';
import '../modules/beranda/face_detection/views/face_detection_view.dart';
import '../modules/beranda/home/bindings/beranda_binding.dart';
import '../modules/beranda/home/views/beranda_view.dart';
import '../modules/beranda/konsultasi/bindings/konsultasi_binding.dart';
import '../modules/beranda/konsultasi/views/doctordetail_view.dart';
import '../modules/beranda/konsultasi/views/konsultasi_view.dart';
import '../modules/beranda/notification/views/notification_view.dart';
import '../modules/profil/riwayat/booking_history/views/booking_history_detail_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/navbar/bindings/navbar_binding.dart';
import '../modules/navbar/views/navbar_view.dart';
import '../modules/profil/informasi_akun/bindings/informasi_akun_binding.dart';
import '../modules/profil/informasi_akun/views/informasi_akun_view.dart';
import '../modules/profil/pusat_bantuan/bindings/pusat_bantuan_binding.dart';
import '../modules/profil/pusat_bantuan/views/pusat_bantuan_view.dart';
import '../modules/profil/riwayat/booking_history/bindings/booking_history_binding.dart';
import '../modules/profil/riwayat/booking_history/views/booking_history_view.dart';
import '../modules/profil/riwayat/detection_history/bindings/detection_history_binding.dart';
import '../modules/profil/riwayat/detection_history/views/detection_history_detail_view.dart';
import '../modules/profil/riwayat/detection_history/views/detection_history_view.dart';
import '../modules/profil/setting/bindings/profil_binding.dart';
import '../modules/profil/setting/views/profil_view.dart';
import '../modules/tutorial/bindings/tutorial_binding.dart';
import '../modules/tutorial/views/detailtutorial_view.dart';
import '../modules/tutorial/views/tutorial_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splashScreen;

  static final routes = [
    GetPage(
      name: _Paths.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.register,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.splashScreen,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.navbar,
      page: () => const NavbarView(),
      binding: NavbarBinding(),
    ),
    GetPage(
      name: _Paths.beranda,
      page: () => const BerandaView(),
      binding: BerandaBinding(),
    ),
    GetPage(
      name: _Paths.riwayat,
      page: () => const RiwayatBookingView(),
      binding: RiwayatBookingBinding(),
    ),
    GetPage(
      name: _Paths.bookinghistorydetail,
      page: () => const BookingHistoryDetailView(),
      binding: RiwayatBookingBinding(),
    ),
    GetPage(
      name: _Paths.profil,
      page: () => const ProfilView(),
      binding: ProfilBinding(),
    ),
    GetPage(
      name: _Paths.chat,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.tutorial,
      page: () => const TutorialView(),
      binding: TutorialBinding(),
    ),
    GetPage(
      name: _Paths.tutorialdetail,
      page: () => const TutorialDetailView(),
      binding: TutorialBinding(),
    ),
    GetPage(
      name: _Paths.faceDetection,
      page: () => const FaceDetectionView(),
      binding: FaceDetectionBinding(),
    ),
    GetPage(
      name: _Paths.booking,
      page: () => const BookingView(),
      binding: BookingBinding(),
    ),
    GetPage(
      name: _Paths.bookingdetail,
      page: () => const BookingDetailView(),
      binding: BookingBinding(),
    ),
    GetPage(
      name: _Paths.buatjanji,
      page: () => const BuatJanjiView(),
      binding: BookingBinding(),
    ),
    GetPage(
      name: _Paths.notifications,
      page: () => const NotificationView(),
    ),
    GetPage(
      name: _Paths.informasiakun,
      page: () => const InformasiAkunView(),
      binding: InformasiAkunBinding(),
    ),
    GetPage(
      name: _Paths.pusatBantuan,
      page: () => const PusatBantuanView(),
      binding: PusatBantuanBinding(),
    ),
    GetPage(
      name: _Paths.konsultasi,
      page: () => const KonsultasiView(),
      binding: KonsultasiBinding(),
    ),
    GetPage(
      name: _Paths.doctordetail,
      page: () => DoctordetailView(),
      binding: KonsultasiBinding(),
    ),
    GetPage(
      name: _Paths.onboarding,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.faceHistory,
      page: () => const FaceHistoryView(),
      binding: FaceHistoryBinding(),
    ),
    GetPage(
      name: _Paths.deteksihistorydetail,
      page: () => const DetectionHistoryDetailView(),
      binding: FaceHistoryBinding(),
    ),
  ];
}
