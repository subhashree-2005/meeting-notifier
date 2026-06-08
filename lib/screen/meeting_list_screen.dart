import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/meeting.dart';
import '../services/meeting_service.dart';

class MeetingListScreen extends StatelessWidget {
  const MeetingListScreen({super.key});

  Future<void> openMeeting(String link) async {
    if (link.isEmpty) return;

    final uri = Uri.parse(link);

    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }

  Future<void> clearMeetings(BuildContext context) async {
    await MeetingService().deleteAllMeetings();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const MeetingListScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "All Meetings",
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete_forever,
            ),
            onPressed: () async {
              await clearMeetings(context);
            },
          ),
        ],
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
              child: Text(
                "No meetings yet.",
              ),
            );
          }

          final meetings = snapshot.data!;

          return ListView.builder(
            itemCount: meetings.length,
            itemBuilder: (context, index) {
              final m = meetings[index];

              return Card(
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [

                      Text(
                        m.sender,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "Platform: ${m.location}",
                      ),

                      const SizedBox(height: 5),

                      const Text(
                        "Link:",
                      ),

                      SelectableText(
                        m.link,
                      ),

                      const SizedBox(height: 5),

                      Text(
                        m.dateTime.toString(),
                      ),

                      const SizedBox(height: 10),

                      ElevatedButton.icon(
                        onPressed: () {
                          openMeeting(m.link);
                        },
                        icon: const Icon(
                          Icons.video_call,
                        ),
                        label: const Text(
                          "Join Meeting",
                        ),
                      ),
                    ],
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