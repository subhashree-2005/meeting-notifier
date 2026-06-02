import 'package:flutter/material.dart';

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification Access"),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            "Go to:\n\nSettings → Notifications → Notification Access\n\nEnable Meeting Notifier",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}