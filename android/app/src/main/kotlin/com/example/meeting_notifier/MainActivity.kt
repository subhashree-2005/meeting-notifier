package com.example.meeting_notifier

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    companion object {
        var channel: MethodChannel? = null
    }

    override fun configureFlutterEngine(
        flutterEngine: FlutterEngine
    ) {

        super.configureFlutterEngine(
            flutterEngine
        )

        channel = MethodChannel(
            flutterEngine
                .dartExecutor
                .binaryMessenger,
            "meeting_notifier_channel"
        )
    }
}