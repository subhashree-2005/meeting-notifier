import 'package:flutter/services.dart';

class NotificationBridge {
  static const MethodChannel _channel =
      MethodChannel(
    'meeting_notifier_channel',
  );

  static void startListening(
    Function(Map<dynamic, dynamic>)
        onNotification,
  ) {
    _channel.setMethodCallHandler(
      (call) async {

        if (call.method ==
            "notification_received") {

          final data =
              Map<dynamic, dynamic>.from(
            call.arguments,
          );

          print(
            "NOTIFICATION RECEIVED",
          );

          print(data);

          onNotification(data);
        }
      },
    );
  }
}