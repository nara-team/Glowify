import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/app/modules/beranda/notification/controllers/notification_controller.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/app/theme/sized_theme.dart';
import 'package:glowify/widget/appbarcustom.dart';
import 'package:glowify/widget/snackbar_custom.dart';
import 'package:glowify/widget/tabfilter_custom.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<NotificationController>(() => NotificationController());

    return Scaffold(
      appBar: const CustomAppBar(judul: 'Notifikasi'),
      body: SafeArea(
        child: Padding(
          padding: PaddingCustom().paddingHorizontalVertical(
            15,
            20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TabFilterCustom(
                categories: const ['Semua', 'read', 'unread'],
                selectedCategory: controller.activeFilter,
                onCategorySelected: (category) {
                  controller.activeFilter.value = category;
                },
                isRow: true,
                horizontal: 27,
                vertical: 3,
              ),
              TextButton(
                onPressed: () {
                  debugPrint("semua pesan sudah ditandai terbaca");
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
                child: Text(
                  "Tandai semua sudah baca",
                  style: regular.copyWith(
                    decoration: TextDecoration.underline,
                    decorationColor: primaryColor,
                    decorationThickness: 2,
                    color: primaryColor,
                    fontSize: regularSize,
                  ),
                ),
              ),
              Expanded(
                child: Obx(() {
                  final filteredNotifications = controller.filteredNotification;
                  final isUnreadTab = controller.activeFilter.value == 'unread';

                  if (isUnreadTab && filteredNotifications.isEmpty) {
                    return const Center(
                      child: Text(
                        "Semua notifikasi sudah terbaca",
                        style: TextStyle(
                          fontSize: mediumSize,
                          color: abuMedColor,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: filteredNotifications.length,
                    itemBuilder: (context, index) {
                      final notification = filteredNotifications[index];
                      final time = controller.formatTime(notification["time"]);
                      final isUnread = notification["status"] == "unread";

                      return Column(
                        children: [
                          Card(
                            surfaceTintColor: whiteBackground1Color,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: primaryColor,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 2,
                            shadowColor: Colors.transparent,
                            margin: const EdgeInsets.only(bottom: 10),
                            color: isUnread
                                ? Colors.blue.shade50
                                : whiteBackground1Color,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor:
                                    isUnread ? primaryColor : abuMedColor,
                                child: const Icon(
                                  Icons.notifications,
                                  color: whiteBackground1Color,
                                ),
                              ),
                              title: Text(
                                notification["title"] ?? '',
                                style: TextStyle(
                                  fontWeight: isUnread
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  fontSize: 16,
                                  color: isUnread ? primaryColor : blackColor,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    notification["message"] ?? '',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: isUnread
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    time,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: abuMedColor,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                SnackBarCustom(
                                  judul: "Notifikasi Ditekan",
                                  pesan:
                                      "Anda memilih ${notification["title"]}",
                                ).show();
                              },
                            ),
                          ),
                          if (index < filteredNotifications.length - 1)
                            const Divider(
                              color: abuMedColor,
                              thickness: 0.5,
                            ),
                        ],
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
