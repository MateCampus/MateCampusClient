package com.litCitrus.zamongcampus

import io.flutter.embedding.android.FlutterActivity

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.os.Build
import android.os.Bundle

class MainActivity: FlutterActivity() {
    private val CHANNEL_ID = "testChannel01"   // Channel for notification
    private var notificationManager: NotificationManager? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        createNotificationChannel("fcm_default_channel", "일반", "전체 알림입니다.")
        createNotificationChannel("fcm_ads_channel", "광고", "광고 관련 알림입니다.")
        createNotificationChannel("fcm_message_channel", "메세지 전체", "메세지 전체 관련 알림입니다.")
    }

    private fun createNotificationChannel(channelId: String, name: String, channelDescription: String) {
        // Create the NotificationChannel, but only on API 26+ because
        // the NotificationChannel class is new and not in the support library
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            /** 
             * 여기서 권한 물어보는 작업이 필요할 것 같다. 
             * IOS는 알아서 물어보는 것 같던데.. 흠 
             * 추가로, flutter code에서 바꿀 수 있는지까지 확인할 것. 
             * */
            val importance = NotificationManager.IMPORTANCE_HIGH // set importance
            val channel = NotificationChannel(channelId, name, importance).apply {
                description = channelDescription
            }
            // Register the channel with the system
            notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager?.createNotificationChannel(channel)
        }
    }
}
