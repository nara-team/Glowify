import 'package:faker/faker.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final faker = Faker();

  var chats = <Map<String, dynamic>>[].obs;
  var filteredChats = <Map<String, dynamic>>[].obs;

  var profileName = ''.obs;
  var profileEmail = ''.obs;
  var profileImage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    profileName.value = faker.person.name();
    profileEmail.value = faker.internet.email();
    profileImage.value = faker.image.loremPicsum(width: 200, height: 200);
    _generateChats();
    _sortChats();
    filteredChats.value = chats;
  }

  void _generateChats() {
    chats.value = List.generate(8, (index) {
      return {
        "profileImage": faker.image.loremPicsum(
          width: 200 + index,
          height: 200 + index,
        ),
        "username": faker.person.firstName(),
        "lastMessage": faker.lorem.sentence(),
        "date": faker.date.justTime(),
        "isRead": faker.randomGenerator.boolean(),
        "unreadCount": faker.randomGenerator.boolean()
            ? faker.randomGenerator.integer(3, min: 1)
            : 0,
      };
    });
  }

  void _sortChats() {
    chats.sort((a, b) {
      final aUnread = a["unreadCount"] > 0 ? 1 : 0;
      final bUnread = b["unreadCount"] > 0 ? 1 : 0;
      return bUnread.compareTo(aUnread);
    });
  }

  void search(String query) {
    filteredChats.value = chats.where((chat) {
      final usernameLower = chat["username"].toString().toLowerCase();
      final searchLower = query.toLowerCase();
      return usernameLower.contains(searchLower);
    }).toList();
  }
}