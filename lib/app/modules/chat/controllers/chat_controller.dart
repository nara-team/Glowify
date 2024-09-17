import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glowify/data/models/chat_model.dart';

class ChatController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final RxString name = ''.obs;
  final RxString email = ''.obs;
  final RxString imageUrl = ''.obs;

  void fetchUserData() async {
    try {
      String uid = _auth.currentUser!.uid;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      name.value = userDoc['fullName'] ?? 'No Name';
      email.value = userDoc['email'] ?? 'No Email';
      imageUrl.value = userDoc['photoURL'] ?? 'https://example.com/default.jpg';
    } catch (e) {
      Get.snackbar('Error', 'Failed to load user data');
    }
  }

  var chats = <Chat>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
    fetchChats();
  }

  void fetchChats() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      FirebaseFirestore.instance
          .collection('chats')
          .where('userId', isEqualTo: uid)
          .orderBy('lastMessageTime', descending: true)
          .snapshots()
          .listen((snapshot) async {
        chats.value = await Future.wait(snapshot.docs.map((doc) async { 
          var chatData = Chat.fromFirestore(doc);

          // Fetch doctor data
          DocumentSnapshot doctorSnapshot = await FirebaseFirestore.instance
              .collection('doctor')
              .doc(chatData.doctorId)
              .get();

          if (doctorSnapshot.exists) {
            var doctorData = doctorSnapshot.data() as Map<String, dynamic>;
            chatData = chatData.copyWith(
              doctorProfilePicture: doctorData['profilePicture'] ?? '',
            );
          }

          return chatData;
        }).toList());
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to load chats');
      print('Error fetching chats: $e');
    }
  }
}
