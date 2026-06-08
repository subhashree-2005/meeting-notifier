import 'package:flutter/material.dart';

import 'screen/home_screen.dart';
import 'services/reminder_service.dart';
import 'services/notification_bridge.dart';
import 'services/meeting_parser.dart';
import 'services/meeting_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ReminderService.init();

  NotificationBridge.startListening(
    (data) async {
      print("NEW NOTIFICATION");
      print(data);

      final meeting =
          MeetingParser.parse(data);

      if (meeting != null) {
        await MeetingService()
            .addMeeting(meeting);

        print("MEETING SAVED");
        print(meeting.title);
      }
    },
  );

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meeting Notifier',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}