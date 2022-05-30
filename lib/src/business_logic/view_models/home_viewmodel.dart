import 'package:flutter/material.dart';
import 'package:zamongcampus/src/ui/dummy_screen.dart';
import 'package:zamongcampus/src/ui/views/chat/chat_main/chat_main_screen.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_main/mypage_main_screen.dart';
import 'package:zamongcampus/src/ui/views/post/post_main/post_main_screen.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_main/voice_main_screen.dart';

import 'base_model.dart';

class HomeViewModel extends BaseModel {
  int currentTab = 0;
  Widget currentScreen = DummyScreen(); // Dummy 말고 다른 보편적 페이지 구성 필요

  final List<Widget> screens = [
    const VoiceMainScreen(),
    const PostMainScreen(),
    const ChatMainScreen(),
    const MypageMainScreen()
  ];

  changeCurrentIndex(int index) {
    currentScreen = screens[index];
    currentTab = index;
    notifyListeners();
  }
}
