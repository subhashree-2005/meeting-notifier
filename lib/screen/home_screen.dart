import 'package:flutter/material.dart';

import '../models/meeting.dart';

import '../screen/meeting_list_screen.dart';
import '../screen/permission_screen.dart';
import '../screen/settings_screen.dart';

import '../services/meeting_parser.dart';
import '../services/meeting_service.dart';
import '../services/notification_bridge.dart';
import '../services/notification_listener_service.dart';
import '../services/reminder_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MeetingService _meetingService = MeetingService();

  final NotificationListenerService _listenerService =
      NotificationListenerService();

  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    await _meetingService.init();

    await _listenerService.init();

    await ReminderService.init();

    NotificationBridge.startListening(
      (notification) async {
        print("NEW NOTIFICATION");
        print(notification);

        final meeting =
            MeetingParser.parse(notification);

        print("PARSED MEETING:");
        print(meeting?.link);

        if (meeting != null) {
          await _meetingService.addMeeting(
            meeting,
          );

          print("SAVED TO DB");

          await ReminderService.showReminder(
            "📅 New Meeting Found",
            "${meeting.sender}\n${meeting.link}",
          );
        }
      },
    );
  }

  Future<void> addTestMeeting() async {
    final meeting = Meeting(
      title: "Project Review",
      dateTime: DateTime.now().add(
        const Duration(hours: 1),
      ),
      location: "Google Meet",
      sender: "Professor",
      link:
          "https://meet.google.com/test",
    );

    await _meetingService.addMeeting(
      meeting,
    );

    await ReminderService.showReminder(
      "Test Reminder",
      "Reminder system working",
    );

    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Test Meeting Added",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Meeting Notifier",
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.notifications_active,
                size: 100,
                color: Colors.blue,
              ),

              const SizedBox(height: 20),

              const Text(
                "Meetings from WhatsApp & Gmail",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const MeetingListScreen(),
                    ),
                  );
                },
                child: const Text(
                  "View All Meetings",
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: addTestMeeting,
                child: const Text(
                  "Add Test Meeting",
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const PermissionScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Enable Notification Access",
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const SettingsScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Settings",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}