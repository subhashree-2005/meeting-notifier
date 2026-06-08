import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ReminderService {
  static final FlutterLocalNotificationsPlugin notifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const android =
        AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const settings =
        InitializationSettings(
      android: android,
    );

    await notifications.initialize(
      settings,
    );
  }

  static Future<void> showReminder(
    String title,
    String body,
  ) async {

    const androidDetails =
        AndroidNotificationDetails(
      'meeting_channel',
      'Meeting Reminder',
      importance: Importance.max,
      priority: Priority.high,
    );

    const details =
        NotificationDetails(
      android: androidDetails,
    );

    await notifications.show(
      DateTime.now()
          .millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      details,
    );
  }
}