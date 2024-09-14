import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Tambahkan ini
import 'dart:convert'; // Tambahkan ini
import 'app/routes/app_pages.dart';

// Initialize the FlutterLocalNotificationsPlugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

// Background handler for Firebase Messaging
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message: ${message.messageId}');
  // Simpan notifikasi FCM ke SharedPreferences
  await _saveNotificationToStorage(message.notification?.title, message.notification?.body);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "core/.env.dev");
  await Firebase.initializeApp();

  // Initialize the local notifications plugin
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Inisialisasi handler notifikasi background
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Meminta permission notifikasi setelah login
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    // Tampilkan notifikasi lokal selamat datang hanya sekali
    await _showWelcomeNotificationIfNeeded();
  }

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      theme: AppTheme.getAppTheme(),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}

// Function to show welcome notification only once
Future<void> _showWelcomeNotificationIfNeeded() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? hasShownWelcomeNotification = prefs.getBool('hasShownWelcomeNotification');

  if (hasShownWelcomeNotification != true) {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'welcome_channel', 'Welcome Channel',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Selamat Datang',
      'Selamat datang di Glowify!',
      platformChannelSpecifics,
      payload: 'welcome_payload',
    );

    // Simpan status notifikasi telah ditampilkan
    await prefs.setBool('hasShownWelcomeNotification', true);
  }
}

// Function to save notification to SharedPreferences
Future<void> _saveNotificationToStorage(String? title, String? body) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> notifications = prefs.getStringList('notifications') ?? [];
  Map<String, dynamic> newNotification = {
    "title": title ?? "No Title",
    "message": body ?? "No Message",
    "time": DateTime.now().toIso8601String(),
  };
  notifications.insert(0, json.encode(newNotification));
  await prefs.setStringList('notifications', notifications);
}

// Function to show notifications as a popup in the foreground
void showLocalNotification(RemoteMessage message) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'channel_id', 'channel_name',
    importance: Importance.max,
    priority: Priority.high,
    showWhen: false,
  );
  const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0,
    message.notification?.title,
    message.notification?.body,
    platformChannelSpecifics,
    payload: 'Notification Payload',
  );

  // Simpan notifikasi ke SharedPreferences
  await _saveNotificationToStorage(message.notification?.title, message.notification?.body);
}
