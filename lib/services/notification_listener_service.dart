import 'package:flutter_notification_listener/flutter_notification_listener.dart';

class NotificationListenerService {

  Future<void> init() async {

    bool? permission =
        await NotificationsListener.hasPermission;

    if (permission != true) {

      await NotificationsListener
          .openPermissionSettings();

      return;
    }

    print(
      "NOTIFICATION PERMISSION GRANTED",
    );
  }
}