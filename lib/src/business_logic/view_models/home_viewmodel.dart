import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/models/notificationZC.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/services/notification/notification_service.dart';
import 'package:zamongcampus/src/ui/dummy_screen.dart';
import 'package:zamongcampus/src/ui/views/chat/chat_main/chat_main_screen.dart';
import 'package:zamongcampus/src/ui/views/loading_page.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_main/mypage_main_screen.dart';
import 'package:zamongcampus/src/ui/views/post/post_main/post_main_screen.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_main/voice_main_screen.dart';

import 'base_model.dart';

class HomeViewModel extends BaseModel {
  final NotificationService _notificationService =
      serviceLocator<NotificationService>();
  int currentTab = 0;
  Widget currentScreen = const LoadingPage(); // Dummy 말고 다른 보편적 페이지 구성 필요
  bool isNotificationExist = false;
  int unreadChatMessageCount = -1;

  final List<Widget> screens = [
    // const VoiceMainScreen(),
    const PostMainScreen(),
    const ChatMainScreen(),
    const MypageMainScreen()
  ];

  changeCurrentIndex(int index) {
    currentScreen = screens[index];
    currentTab = index;
    notifyListeners();
  }

  loadNotificationExist() async {
    // TODO: 나중에 고쳐야함.
    List<NotificationZC> notifications =
        await _notificationService.fetchMyUnreadNotification();
    isNotificationExist = notifications.length > 0 ? true : false;
    notifyListeners();
  }

  changeNotificationExist(bool value) {
    isNotificationExist = value;
    notifyListeners();
  }

  chageUnreadChatMessageCount(int count){
    unreadChatMessageCount = count;
    notifyListeners();

  }

}
