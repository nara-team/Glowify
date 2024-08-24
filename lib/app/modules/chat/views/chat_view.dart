import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/app/theme/sized_theme.dart';
import 'package:gap/gap.dart';

import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SearchView();
  }
}

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.put(ChatController());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: PaddingCustom().paddingOnly(20, 30, 20, 4),
          child: Column(
            children: [
              Row(
                children: [
                  Obx(() => CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            NetworkImage(controller.profileImage.value),
                      )),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => Text(
                              controller.profileName.value,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            )),
                        Obx(() => Text(
                              controller.profileEmail.value,
                              style: const TextStyle(
                                fontSize: 14,
                                color: abuMedColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            )),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.edit_outlined,
                      color: abuMedColor,
                      size: 32,
                    ),
                    onPressed: () {
                      debugPrint("edit kah?");
                    },
                  ),
                ],
              ),
              const Gap(20),
              Container(
                decoration: BoxDecoration(
                  color: whiteBackground1Color,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(1, 2),
                    ),
                  ],
                ),
                child: TextField(
                  style: const TextStyle(fontSize: 16),
                  onChanged: (value) {
                    controller.search(value);
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: whiteBackground1Color,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Search...",
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
              const Gap(20),
              Expanded(
                child: Obx(() {
                  int itemCount = controller.filteredChats.isEmpty
                      ? 0
                      : controller.filteredChats.length + 1;
                  return ListView.builder(
                    itemCount: itemCount,
                    itemBuilder: (context, index) {
                      if (index == controller.filteredChats.length) {
                        return const Gap(160);
                      }
                      final chat = controller.filteredChats[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(chat["profileImage"]),
                          radius: 25.0,
                        ),
                        title: Text(
                          chat["username"],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          chat["lastMessage"],
                          style: const TextStyle(
                            color: abuMedColor,
                          ),
                        ),
                        trailing: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              chat["date"],
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            if (chat["unreadCount"] > 0)
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 16,
                                  minHeight: 16,
                                ),
                                child: Text(
                                  '${chat["unreadCount"]}',
                                  style: const TextStyle(
                                    color: whiteBackground1Color,
                                    fontSize: 10,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                          ],
                        ),
                        onTap: () {},
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("Tambah Chat Baru");
        },
        backgroundColor: primaryColor,
        child: const Icon(
          Icons.chat,
          color: whiteBackground1Color,
        ),
      ),
    );
  }
}