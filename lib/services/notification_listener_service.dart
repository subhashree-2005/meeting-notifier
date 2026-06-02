import '../services/meeting_service.dart';
import '../services/notification_service.dart';
import '../models/meeting.dart';

class NotificationListenerService {
  static final NotificationListenerService _instance =
      NotificationListenerService._internal();

  factory NotificationListenerService() => _instance;

  final MeetingService _meetingService = MeetingService();
  final NotificationService _notificationService =
      NotificationService();

  NotificationListenerService._internal();

  Future<void> init() async {
    await _meetingService.init();
    await _notificationService.init();

    print("Notification Service Ready");
  }

  Future<void> addTestMeeting() async {
    Meeting meeting = Meeting(
      title: "Project Review Meeting",
      dateTime: DateTime.now().add(
        const Duration(minutes: 30),
      ),
      location: "Google Meet",
      sender: "WhatsApp",
    );

    await _meetingService.addMeeting(meeting);

    await _notificationService.showNotification(
      100,
      "Meeting Saved",
      "Project Review Meeting added successfully",
    );
  }

  Future<void> testNotification() async {
    await _notificationService.showNotification(
      999,
      "Meeting Reminder",
      "This is a test notification",
    );
  }
}