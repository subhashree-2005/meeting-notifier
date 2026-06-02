import 'package:flutter/material.dart';
import '../services/meeting_service.dart';
import '../services/notification_listener_service.dart';
import '../screen/meeting_list_screen.dart';
import '../screen/permission_screen.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meeting Notifier"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                  fontWeight: FontWeight.bold,
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
                onPressed: () async {
                  await _listenerService.addTestMeeting();

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Meeting Added Successfully",
                        ),
                      ),
                    );
                  }
                },
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
            ],
          ),
        ),
      ),
    );
  }
}