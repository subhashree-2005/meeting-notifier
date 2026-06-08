import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/meeting.dart';

class MeetingService {
  static final MeetingService _instance =
      MeetingService._internal();

  factory MeetingService() => _instance;

  MeetingService._internal();

  Database? _db;

  Future<void> init() async {
    if (_db != null) return;

    final path = join(
      await getDatabasesPath(),
      'meetings.db',
    );

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE meetings(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          date_time TEXT,
          location TEXT,
          sender TEXT,
          link TEXT,
          alarm_minutes_before INTEGER
        )
        ''');
      },
    );
  }

  Future<int> addMeeting(
      Meeting meeting) async {
    await init();

    return await _db!.insert(
      'meetings',
      meeting.toMap(),
    );
  }

  Future<List<Meeting>> getAllMeetings() async {
    await init();
Future<int> getTotalMeetings() async {
  await init();

  final result = await _db!.rawQuery(
    'SELECT COUNT(*) as count FROM meetings',
  );

  return result.first['count'] as int;
}

Future<int> getWhatsAppMeetings() async {
  await init();

  final result = await _db!.rawQuery(
    "SELECT COUNT(*) as count FROM meetings WHERE location='WhatsApp'",
  );

  return result.first['count'] as int;
}

Future<int> getGmailMeetings() async {
  await init();

  final result = await _db!.rawQuery(
    "SELECT COUNT(*) as count FROM meetings WHERE location='Gmail'",
  );

  return result.first['count'] as int;
}
    final maps =
        await _db!.query('meetings');

    return maps.map((e) {
      return Meeting.fromMap(e);
    }).toList();
  }

  Future<void> deleteAllMeetings() async {
    await init();

    await _db!.delete('meetings');
  }
}