import '../models/meeting.dart';

class MeetingParser {
  static final Set<String> processed = {};

  static Meeting? parse(
    Map<dynamic, dynamic> notification,
  ) {
    final package =
        notification["package"]?.toString() ?? "";

    final title =
        notification["title"]?.toString() ?? "";

    final text =
        notification["text"]?.toString() ?? "";

    print("PACKAGE = $package");
    print("TITLE = $title");
    print("TEXT = $text");

    // Ignore our own notifications
    if (package ==
        "com.example.meeting_notifier") {
      return null;
    }

    final unique =
        "$package|$title|$text";

    if (processed.contains(unique)) {
      return null;
    }

    processed.add(unique);

    final combined =
        "$title $text".toLowerCase();

    bool isMeeting =
        combined.contains("meet.google.com") ||
        combined.contains("google meet") ||
        combined.contains("g.co/meet") ||
        combined.contains("zoom.us") ||
        combined.contains("zoom") ||
        combined.contains("teams") ||
        combined.contains("meeting") ||
        combined.contains("meet link") ||
        combined.contains("join meeting") ||
        combined.contains("conference");

    print("IS MEETING = $isMeeting");

    if (!isMeeting) {
      return null;
    }

    String platform = "Meeting";

    if (combined.contains("meet.google.com") ||
        combined.contains("google meet")) {
      platform = "Google Meet";
    } else if (combined.contains("zoom")) {
      platform = "Zoom";
    } else if (combined.contains("teams")) {
      platform = "Microsoft Teams";
    }

    String link = "";

    final regex = RegExp(
      r'https?:\/\/[^\s]+',
    );

    final match =
        regex.firstMatch(text);

    if (match != null) {
      link = match.group(0)!;
    }

    return Meeting(
      title: title,
      dateTime: DateTime.now(),
      location: platform,
      sender: title,
      link: link,
    );
  }
}