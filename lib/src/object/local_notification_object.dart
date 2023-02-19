import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:zamongcampus/src/business_logic/arguments/chat_detail_screen_args.dart';
import 'package:zamongcampus/src/business_logic/arguments/post_detail_screen_args.dart';

import 'package:zamongcampus/src/business_logic/models/chatRoom.dart';
import 'package:zamongcampus/src/business_logic/view_models/chat_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/home_viewmodel.dart';
import 'package:zamongcampus/src/config/navigation_service.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
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
    
    HomeViewModel homeViewModel = serviceLocator<HomeViewModel>();
    
    if (payload == null) return;
    var res = await jsonDecode(payload);
    if (res["navigate"] != null && res["navigate"] != "/chatDetail") {
      NotificationService notificationService =
          serviceLocator<NotificationService>();
      notificationService.updateMyNotificationRead(
          id: int.parse(res['notificationId']));
    }
    switch (res["navigate"]) {
      case "/chatDetail":

        /// load data 할 필요 없다. 왜냐하면 이미 다 구독하고 있는 상태이기 때문.
        /// 1. load local 값(채팅방) or 새로운 값(채팅방) 생성 -> 새로운 채팅방을 여기서 생성하면 안됨. 모든 채팅방은 생성과 동시에 구독을 해야하는데 구독은 무조건 stomp에서만(23.02.19)
        /// 따라서 chatMain에서 무조건 chatRoom을 가져온다. fcm의 용도는 오직 클릭 시 어디로 가야하는지와 그를 위한 id 정도만 있도록 한다.
        ChatViewModel chatViewModel = serviceLocator<ChatViewModel>();
        //fcm에서 넘어온 roomId 값을 이용해 chatMainVM에서 해당 chatRoom을 찾음->이러면 index도 찾을수있지.(걱정되는건 이건 반드시 fcm이 날라오기전에 stomp에서 구독이 먼저 되어있어야 됨. 왜냐면 구독과 동시에 chatRoom을 삽입하기 때문.)
        ChatRoom chatRoom = chatViewModel.getChatRoomForFcm(res["roomId"]);
        if(chatRoom.roomId ==res["roomId"]){
        homeViewModel.changeCurrentIndex(1);
           NavigationService().pushNamedAndRemoveUntil(
            "/chatDetail", "/", ChatDetailScreenArgs(chatRoom, chatViewModel.getExistRoomIndex(res["roomId"])));
        }else{
          //혹시 chatRoom 삽입이 느렸을경우엔, chatMain 페이지로 넘겨버림
          homeViewModel.changeCurrentIndex(1);
          print('chatmain에서 chatRoom 못찾아서 chatdetail로 못가고 chatmain 으로 왔당');
          // NavigationService().navigateToScreen(Home());
          NavigationService().pushNamedAndRemoveUntilWithoutArgs("/", "/");
        }
       
        break;
      case "/voiceDetail":
        break;
      case "/postDetail":
        NavigationService().pushNamedAndRemoveUntil(
            "/postDetail", "/", PostDetailScreenArgs(int.parse(res["postId"])));
        homeViewModel.changeCurrentIndex(0);
        break;
      case "/friend":
       
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
