import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {

  static Future<bool> getVibration() async {
    final prefs =
        await SharedPreferences.getInstance();

    return prefs.getBool("vibration") ?? true;
  }

  static Future<void> setVibration(
      bool value) async {

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setBool(
      "vibration",
      value,
    );
  }
}