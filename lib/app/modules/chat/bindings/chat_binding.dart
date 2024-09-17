import 'package:get/get.dart';

import '../controllers/chat_controller.dart';
import '../controllers/chatroom_controller.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(
      () => ChatController(),
    );
    Get.lazyPut<ChatroomController>(
      () => ChatroomController(),
    );
  }
}
