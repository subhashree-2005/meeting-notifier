package com.example.meeting_notifier

import android.service.notification.NotificationListenerService
import android.service.notification.StatusBarNotification
import android.util.Log

class NotificationListener : NotificationListenerService() {

    override fun onNotificationPosted(
        sbn: StatusBarNotification
    ) {

        val extras = sbn.notification.extras

        val title =
            extras.getString("android.title") ?: ""

        val text =
            extras.getCharSequence("android.text")
                ?.toString() ?: ""

        Log.d(
            "MEETING_NOTIFIER",
            "PACKAGE=${sbn.packageName}"
        )

        Log.d(
            "MEETING_NOTIFIER",
            "TITLE=$title"
        )

        Log.d(
            "MEETING_NOTIFIER",
            "TEXT=$text"
        )

        val data = HashMap<String, String>()

        data["package"] =
            sbn.packageName

        data["title"] =
            title

        data["text"] =
            text

        MainActivity.channel?.invokeMethod(
            "notification_received",
            data
        )
    }
}