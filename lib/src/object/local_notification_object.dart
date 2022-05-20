import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationObject {
  static final _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    // final IOSInitializationSettings initializationSettingsIOS =
    //     IOSInitializationSettings(
    //         onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettingsIOS = const IOSInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  static void selectNotification(String? payload) async {
    print('foreground 클릭했을 때 오는 곳! ');
    print("$payload");
  }

  static void showNotification2(RemoteMessage message) async {
    // fcm_default_channel, fcm_ads_channel, fcm_message_channel
    NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
            message.notification?.android?.channelId ?? "fcm_default_channel",
            korNameOfChannelId(message.notification?.android?.channelId),
            importance: Importance.max,
            priority: Priority.high),
        iOS: const IOSNotificationDetails());
    if (message.notification != null) {
      await _flutterLocalNotificationsPlugin.show(
        0,
        message.notification?.title,
        message.notification?.body,
        notificationDetails,
        payload: json.encode(message.data),
      );
    }
  }

  static korNameOfChannelId(String? channelId) {
    return channelData[channelId] ?? "일반";
  }

  static final Map<String, String> channelData = {
    "fcm_default_channel": "일반",
    "fcm_ads_channel": "광고",
    "fcm_message_channel": "메세지 전체",
  };
}
