import 'package:flutter/material.dart';
import '../models/meeting.dart';
import '../services/meeting_service.dart';

class MeetingListScreen extends StatelessWidget {
  const MeetingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Meetings"),
      ),
      body: FutureBuilder<List<Meeting>>(
        future: MeetingService().getAllMeetings(),
        builder: (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No meetings yet."),
            );
          }

          final meetings = snapshot.data!;

          return ListView.builder(
            itemCount: meetings.length,
            itemBuilder: (context, index) {

              final m = meetings[index];

              return Card(
                child: ListTile(
                  title: Text(m.title),
                  subtitle: Text(
                    "${m.location}\n${m.sender}",
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}