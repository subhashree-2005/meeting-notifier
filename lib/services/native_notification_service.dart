import 'package:flutter/services.dart';
import '../models/meeting.dart';
import '../services/meeting_service.dart';

class NativeNotificationService {
  static const MethodChannel _channel =
      MethodChannel('meeting_notifier_channel');

  static void startListening() {
    _channel.setMethodCallHandler((call) async {

      if (call.method == "notification_received") {

        final data =
            Map<String, dynamic>.from(call.arguments);

        final package =
            data["package"] ?? "";

        final title =
            data["title"] ?? "";

        final text =
            data["text"] ?? "";

        print("PACKAGE = $package");
        print("TITLE = $title");
        print("TEXT = $text");

        final lower =
            "$title $text".toLowerCase();

        bool isMeeting =
            lower.contains("meeting") ||
            lower.contains("google meet") ||
            lower.contains("gmeet") ||
            lower.contains("zoom") ||
            lower.contains("teams") ||
            lower.contains("webex");

        if (isMeeting) {

          await MeetingService().addMeeting(
            Meeting(
              title: title.isEmpty
                  ? "Meeting Detected"
                  : title,
              dateTime: DateTime.now(),
              location: "Detected From Notification",
              sender: package,
            ),
          );

          print("MEETING SAVED");
        }
      }
    });
  }
}