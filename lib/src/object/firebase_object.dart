import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:zamongcampus/src/object/local_notification_object.dart';

class FirebaseObject {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static String? _deviceFcmToken;
  static String? get deviceFcmToken => _deviceFcmToken;

  static Future<void> init() async {
    print("firebase init start");
    _deviceFcmToken = await _getToken();
    await _initNotification();
    print("firebase init end");
  }

  static Future<String?> _getToken() async {
    try {
      String? token = await _messaging.getToken();
      // TODO: 여기에 vapidKey 필요. => 없어도 token를 가져오긴함.
      print("토큰 값 위치: " + token.toString());
      return token;
    } catch (e) {
      print("getToken error ");
    }
  }

  // getNotificationSettings, requestPermission 차이 확인할 것.
  static Future<void> _initNotification() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // permission 물어보는거인듯. 확인 필요(android 특히.)
    // FirebaseMessaging.instance.requestPermission();
    // print('User granted permission: ${settings.authorizationStatus}');

    /* 사용하고 있는 상태(Foreground messages) */
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('foreground으로 메세지 받기 완료 Message data: ${message.data}');

      if (message.notification != null) {
        LocalNotificationObject.showNotification2(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('background 클릭했을 때 오는 곳! ');
    });

    /* 새로운 토큰 만들어질 때 사용되는 함수. */
    FirebaseMessaging.instance.onTokenRefresh.listen((event) {
      print("새로운 토큰이 발행되었을 때! ");
      print("이 경우에 서버와 통신해서 토큰을 바꿔주도록?");
    });
  }
}
