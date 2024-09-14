import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/app/modules/notification/controllers/notification_controller.dart';
import 'package:glowify/widget/appbarcustom.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<NotificationController>(() => NotificationController());

    return Scaffold(
      appBar: CustomAppBar(judul: "Notifikasi"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.notifications.isEmpty) {
            return Center(
              child: Text("Tidak ada notifikasi"),
            );
          }

          return ListView.builder(
            itemCount: controller.notifications.length,
            itemBuilder: (context, index) {
              final notification = controller.notifications[index];
              final time = controller.formatTime(DateTime.parse(notification["time"]));

              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.grey),
                ),
                onDismissed: (direction) {
                  controller.deleteNotification(index);
                  Get.snackbar("Notifikasi Dihapus", "Notifikasi berhasil dihapus.");
                },
                child: Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(
                      notification["title"] ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            notification["message"] ?? '',
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
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
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
