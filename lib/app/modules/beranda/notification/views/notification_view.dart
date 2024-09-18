import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/app/modules/beranda/notification/controllers/notification_controller.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/widget/appbarcustom.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<NotificationController>(() => NotificationController());

    return Scaffold(
      appBar: const CustomAppBar(judul: 'Notifikasi'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return ListView.builder(
            itemCount: controller.notifications.length,
            itemBuilder: (context, index) {
              final notification = controller.notifications[index];
              final time = controller.formatTime(notification["time"]);

              return Card(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: primaryColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 0,
                surfaceTintColor: whiteBackground1Color,
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  title: Text(
                    notification["title"] ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification["message"] ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Get.snackbar(
                      "Notifikasi Dipilih",
                      "Anda memilih: ${notification["title"]}",
                    );
                  },
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
