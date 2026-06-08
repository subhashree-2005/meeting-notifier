class Meeting {
  final int? id;

  final String title;

  final DateTime dateTime;

  final String location;

  final String sender;

  final String link;

  final int? alarmMinutesBefore;

  Meeting({
    this.id,
    required this.title,
    required this.dateTime,
    required this.location,
    required this.sender,
    required this.link,
    this.alarmMinutesBefore = 10,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'date_time': dateTime.toIso8601String(),
      'location': location,
      'sender': sender,
      'link': link,
      'alarm_minutes_before': alarmMinutesBefore,
    };
  }

  factory Meeting.fromMap(
      Map<String, Object?> map) {
    return Meeting(
      id: map['id'] as int?,
      title: map['title'] as String,
      dateTime: DateTime.parse(
        map['date_time'] as String,
      ),
      location: map['location'] as String,
      sender: map['sender'] as String,
      link: map['link'] as String,
      alarmMinutesBefore:
          map['alarm_minutes_before'] as int?,
    );
  }
}