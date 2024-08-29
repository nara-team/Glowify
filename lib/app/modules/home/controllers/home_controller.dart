import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxString userName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserName();
  }

  void fetchUserName() async {
    try {
      String uid = _auth.currentUser!.uid;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      userName.value = userDoc['fullName'] ?? 'No Name';
    } catch (e) {
      Get.snackbar('Error', 'Failed to load user data');
    }
  }

  void increment() => count.value++;

  // Fungsi Logout
  Future<void> logout() async {
    await _auth.signOut();
    Get.offAllNamed('/login');
  }
}
