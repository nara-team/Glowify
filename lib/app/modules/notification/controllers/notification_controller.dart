import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // for JSON encoding/decoding
import 'package:timeago/timeago.dart' as timeago;

class NotificationController extends GetxController {
  var notifications = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeFCM();
    _loadSavedNotifications();
  }

  // Initialize Firebase Cloud Messaging (FCM)
  void _initializeFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        _addNotificationToHistory(
          message.notification!.title,
          message.notification!.body,
        );
      }
    });

    // Handle background and terminated state
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        _addNotificationToHistory(
          message.notification!.title,
          message.notification!.body,
        );
      }
    });
  }

  // Add received notification to local history and save it
  void _addNotificationToHistory(String? title, String? body) async {
    final now = DateTime.now();
    Map<String, dynamic> newNotification = {
      "title": title ?? "No Title",
      "message": body ?? "No Message",
      "time": now.toIso8601String(),
    };

    // Insert the new notification at the top of the list
    notifications.insert(0, newNotification);

    // Save notifications to SharedPreferences
    await _saveNotificationsToStorage();
  }

  // Load saved notifications from SharedPreferences
  void _loadSavedNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedNotifications = prefs.getStringList('notifications');
    
    if (storedNotifications != null) {
      notifications.assignAll(storedNotifications.map((e) => json.decode(e)).cast<Map<String, dynamic>>());
    }
  }

  // Save current notifications list to SharedPreferences
  Future<void> _saveNotificationsToStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> encodedNotifications = notifications.map((e) => json.encode(e)).toList();
    await prefs.setStringList('notifications', encodedNotifications);
  }

  // Delete a notification by index
  void deleteNotification(int index) async {
    notifications.removeAt(index);
    await _saveNotificationsToStorage(); // Simpan ulang setelah dihapus
  }

  // Format time using timeago
  String formatTime(DateTime dateTime) {
    return timeago.format(dateTime, locale: 'en_short');
  }
}
