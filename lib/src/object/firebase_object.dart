import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:zamongcampus/src/business_logic/arguments/chat_detail_screen_args.dart';
import 'package:zamongcampus/src/business_logic/arguments/post_detail_screen_args.dart';
import 'package:zamongcampus/src/business_logic/arguments/voice_detail_screen_args.dart';
import 'package:zamongcampus/src/business_logic/view_models/chat_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/home_viewmodel.dart';
import 'package:zamongcampus/src/config/navigation_service.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/object/local_notification_object.dart';
import 'package:zamongcampus/src/services/chat/chat_service.dart';

import '../business_logic/models/chatRoom.dart';

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
    return null;
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

    //*
    // terminated된 상태는 stomp_object에서 stomp 연결완료 후 진행
    // stomp_object.dart */
    /* 사용하고 있는 상태(Foreground messages) */
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('foreground으로 메세지 받기 완료 Message data: ${message.data}');

      if (message.notification != null) {
        LocalNotificationObject.showNotification2(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('background 클릭했을 때 오는 곳! ');
      // background 상태일 때, msg가 오는지 sub은 잘 살아있는지에 따라 다를 수도.
      // 만약 살아있다면 얘도 load할 필요가 없음.
      print(message.data);
      switch (message.data["navigate"]) {
        case "/chatDetail":
          HomeViewModel homeViewModel = serviceLocator<HomeViewModel>();
          homeViewModel.changeCurrentIndex(2);

          /// 이미 해당 방이면 따로 navigate는 안함.
          ChatViewModel chatViewModel = serviceLocator<ChatViewModel>();
          if (message.data["roomId"] == chatViewModel.insideRoomId) return;

          /// 1. load local 값 or 새로운 값 생성
          ChatService chatService = serviceLocator<ChatService>();
          ChatRoom chatRoom =
              await chatService.getChatRoomByRoomId(message.data["roomId"]) ??
                  ChatRoom(
                      roomId: message.data["roomId"],
                      title: message.data["title"],
                      type: message.data["type"],
                      lastMessage: "",
                      lastMsgCreatedAt: DateTime(2021, 05, 05),
                      imageUrl: message.data["imageUrl"],
                      unreadCount: 0);

          NavigationService().pushNamedAndRemoveUntil(
              "/chatDetail", "/", ChatDetailScreenArgs(chatRoom, -1));
          break;
        case "/voiceDetail":
          NavigationService().pushNamedAndRemoveUntil(
              "/voiceDetail",
              "/",
              VoiceDetailScreenArgs(
                  id: int.parse(message.data["voiceRoomId"])));
          HomeViewModel homeViewModel = serviceLocator<HomeViewModel>();
          homeViewModel.changeCurrentIndex(0);
          break;
        case "/postDetail":
          NavigationService().pushNamedAndRemoveUntil("/postDetail", "/",
              PostDetailScreenArgs(int.parse(message.data["postId"])));
          HomeViewModel homeViewModel = serviceLocator<HomeViewModel>();
          homeViewModel.changeCurrentIndex(1);
          break;
        case "/friend":
          NavigationService()
              .pushNamedAndRemoveUntilWithoutArgs("/friend", "/");
          HomeViewModel homeViewModel = serviceLocator<HomeViewModel>();
          homeViewModel.changeCurrentIndex(2);
          break;
        default:
          break;
      }
    });

    /* 새로운 토큰 만들어질 때 사용되는 함수. */
    FirebaseMessaging.instance.onTokenRefresh.listen((event) {
      print("새로운 토큰이 발행되었을 때! ");
      print("이 경우에 서버와 통신해서 토큰을 바꿔주도록?");
    });
  }
}
