import 'dart:convert';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

class LocalNotificationManager {
  static const defaultNotificationChannelId = 'default_notification_channel';

  static Future<void> initialize() async {
    await requestLocalNotificationPermission();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        ?.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(
          const AndroidNotificationChannel(
            defaultNotificationChannelId,
            'High Importance Notifications',
            importance: Importance.max,
          ),
        );
    await flutterLocalNotificationsPlugin?.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
      onDidReceiveNotificationResponse: _onDidReceiveLocalNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:
          _onDidReceiveLocalNotificationResponse,
    );
  }

  static Future<bool?> requestLocalNotificationPermission() async {
    if (Platform.isIOS) {
      return await flutterLocalNotificationsPlugin
          ?.resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else {
      final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      return flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    }
  }

  static Future<void> showNotification(Map<String, dynamic> data) async {
    if (flutterLocalNotificationsPlugin == null) {
      await initialize();
    }

    flutterLocalNotificationsPlugin?.show(
      data.hashCode,
      data['title'],
      data['body'],
      const NotificationDetails(
        android: AndroidNotificationDetails(
          defaultNotificationChannelId,
          'High Importance Notifications',
        ),
      ),
      payload: jsonEncode(data),
    );
  }

  static Future<void> clearNotification() async {
    flutterLocalNotificationsPlugin ??= FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin?.cancelAll();
  }

  static Future<void> cancelNotification(int id) async {
    flutterLocalNotificationsPlugin ??= FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin?.cancel(id);
  }

  static void _onDidReceiveLocalNotificationResponse(
      NotificationResponse notification) {
    if (notification.payload == null) return;
  }
}
