import 'package:get/get.dart';

class BerandaController extends GetxController {
  final List<Map<String, dynamic>> fetureDraft = [
    {
      "route": "",
      "iconPath": "assets/images/stethoscope.png",
      "caption": "Konsultasi\nDoctor",
    },
    {
      "route": "",
      "iconPath": "assets/images/face-recognition.png",
      "caption": "Deteksi\nKesehatan Wajah",
    },
    {
      "route": "",
      "iconPath": "assets/images/klinik.png",
      "caption": "Booking Klinik\nKecantikan",
    }
  ].obs;
}
