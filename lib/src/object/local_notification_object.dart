import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:zamongcampus/src/business_logic/arguments/chat_detail_screen_args.dart';
import 'package:zamongcampus/src/business_logic/arguments/post_detail_screen_args.dart';
import 'package:zamongcampus/src/business_logic/arguments/voice_detail_screen_args.dart';
import 'dart:convert';

import 'package:zamongcampus/src/business_logic/models/chatRoom.dart';
import 'package:zamongcampus/src/business_logic/view_models/chat_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/home_viewmodel.dart';
import 'package:zamongcampus/src/config/navigation_service.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/object/sqflite_object.dart';
import 'package:zamongcampus/src/services/chat/chat_service.dart';
import 'package:zamongcampus/src/services/notification/notification_service.dart';

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
    if (payload == null) return;
    var res = await jsonDecode(payload);
    if (res["navigate"] != null) {
      NotificationService notificationService =
          serviceLocator<NotificationService>();
      notificationService.updateMyNotificationRead(
          id: int.parse(res['notificationId']));
    }
    switch (res["navigate"]) {
      case "/chatDetail":

        /// load data 할 필요 없다. 왜냐하면 이미 다 구독하고 있는 상태이기 때문.
        /// 1. load local 값 or 새로운 값 생성
        ChatService chatService = serviceLocator<ChatService>();
        // TODO: chatroom을 다시 만드는 것이 아니라, roomId로 해당 값을 local이든,server에서 불러야함.
        // 그게 맞는 로직인 듯. fcm의 용도는 오직 클릭 시 어디로 가야하는지와 그를 위한 id 정도만 있도록 한다.
        ChatRoom chatRoom =
            await chatService.getChatRoomByRoomId(res["roomId"]) ??
                ChatRoom(
                    roomId: res["roomId"],
                    title: res["title"],
                    type: res["type"],
                    lastMessage: "",
                    lastMsgCreatedAt: DateTime(2021, 05, 05),
                    imageUrl: res["imageUrl"],
                    unreadCount: 0);
        HomeViewModel homeViewModel = serviceLocator<HomeViewModel>();
        homeViewModel.changeCurrentIndex(2);
        NavigationService().pushNamedAndRemoveUntil(
            "/chatDetail", "/", ChatDetailScreenArgs(chatRoom, -1));
        break;
      case "/voiceDetail":
        NavigationService().pushNamedAndRemoveUntil("/voiceDetail", "/",
            VoiceDetailScreenArgs(id: int.parse(res["voiceRoomId"])));
        HomeViewModel homeViewModel = serviceLocator<HomeViewModel>();
        homeViewModel.changeCurrentIndex(0);
        break;
      case "/postDetail":
        NavigationService().pushNamedAndRemoveUntil(
            "/postDetail", "/", PostDetailScreenArgs(int.parse(res["postId"])));
        HomeViewModel homeViewModel = serviceLocator<HomeViewModel>();
        homeViewModel.changeCurrentIndex(1);
        break;
      case "/friend":
        NavigationService().pushNamedAndRemoveUntilWithoutArgs("/friend", "/");
        HomeViewModel homeViewModel = serviceLocator<HomeViewModel>();
        homeViewModel.changeCurrentIndex(2);
        break;
      default:
        break;
    }
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
      if (message.data["navigate"] == "/chatDetail") {
        ChatViewModel chatViewModel = serviceLocator<ChatViewModel>();
        if (message.data["roomId"] == chatViewModel.insideRoomId) return;
      }
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
    "fcm_voiceroom_invite_channel": "음성대화방 초대",
  };
}
