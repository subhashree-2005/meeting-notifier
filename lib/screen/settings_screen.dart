import 'package:flutter/material.dart';

import '../services/settings_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() =>
      _SettingsScreenState();
}

class _SettingsScreenState
    extends State<SettingsScreen> {

  bool vibration = true;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {

    vibration =
        await SettingsService.getVibration();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
        ),
      ),

      body: SwitchListTile(
        title: const Text(
          "Enable Vibration",
        ),

        value: vibration,

        onChanged: (value) async {

          await SettingsService.setVibration(
            value,
          );

          setState(() {
            vibration = value;
          });
        },
      ),
    );
  }
}