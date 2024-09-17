import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glowify/app/modules/chat/controllers/chatroom_controller.dart';
import 'package:glowify/app/modules/chat/views/chatroom_view.dart';

import '../../../../data/models/doctor_model.dart';
import '../../../../data/models/klinik_model.dart';

class DoctordetailController extends GetxController {
  var klinik = Klinik().obs;

  @override
  void onInit() {
    super.onInit();
    final doctor = Get.arguments as Doctor;
    fetchClinicByDoctorId(doctor.doctorId!);
  }

  Future<void> fetchClinicByDoctorId(String doctorId) async {
    try {
      QuerySnapshot clinicSnapshot = await FirebaseFirestore.instance
          .collection('klinik')
          .where('id_doktor', arrayContains: doctorId)
          .get();

      if (clinicSnapshot.docs.isNotEmpty) {
        var clinicData = clinicSnapshot.docs.first;
        klinik.value = Klinik.fromFirestore(clinicData);
      } else {
        klinik.value = Klinik(
          namaKlinik: 'Tidak diketahui',
          alamatKlinik: {
            'desa': '',
            'kecamatan': '',
            'kabupaten': '',
            'provinsi': ''
          },
        );
      }
    } catch (e) {
      print('Error fetching clinic data: $e');
    }
  }

  Future<void> startChat(
    String userId,
    String doctorId,
    String doctorName,
    String doctorProfilePicture,
  ) async {
    try {
      print("Checking existing chats...");

      // Query untuk mengecek apakah chat antara user dan dokter sudah ada
      QuerySnapshot chatSnapshot = await FirebaseFirestore.instance
          .collection('chats')
          .where('userId', isEqualTo: userId)
          .where('doctorId', isEqualTo: doctorId)
          .get();

      String chatId = '';

      if (chatSnapshot.docs.isNotEmpty) {
        // Jika chat sudah ada, ambil chatId yang ada
        print("Chat exists!");
        chatId = chatSnapshot.docs.first.id;
      } else {
        // Jika belum ada, buat chat baru
        print("Creating new chat...");
        DocumentReference chatDocRef =
            await FirebaseFirestore.instance.collection('chats').add({
          'userId': userId,
          'doctorId': doctorId,
          'doctorName': doctorName,
          'doctorProfilePicture': doctorProfilePicture,
          'userName':
              FirebaseAuth.instance.currentUser!.displayName ?? 'Anonymous',
          'lastMessage': '',
          'lastMessageTime': FieldValue.serverTimestamp(),
          'chatCreatedAt': FieldValue.serverTimestamp(),
        });
        chatId = chatDocRef.id;
      }

      // Melakukan query ulang untuk mendapatkan chatId yang terbaru dari database
      DocumentSnapshot chatDocSnapshot = await FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId)
          .get();

      if (chatDocSnapshot.exists) {
        // Jika dokumen ditemukan, ambil `chatId` dari dokumen tersebut
        chatId = chatDocSnapshot.id;

        // Setelah mendapatkan chatId, navigasi ke chatroom
        if (chatId.isNotEmpty) {
          print("Navigating to chatroom with chatId: $chatId");
          Get.to(
            () => ChatroomView(
              chatId: chatId,
              doctorName: doctorName,
              doctorProfilePicture: doctorProfilePicture,
            ),
          );
          Get.lazyPut<ChatroomController>(
            () => ChatroomController(),
          );
        } else {
          print('Error: chatId is still empty after query');
          Get.snackbar('Error', 'Gagal memulai chat. chatId tidak valid.');
        }
      } else {
        print('Error: Chat document does not exist.');
        Get.snackbar(
            'Error', 'Gagal memulai chat. Dokumen chat tidak ditemukan.');
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', 'Gagal memulai chat: $e');
    }
  }
}
