import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/chat_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/home_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/object/firebase_object.dart';
import 'package:zamongcampus/src/object/interest_object.dart';
import 'package:zamongcampus/src/object/prefs_object.dart';
import 'package:zamongcampus/src/object/secure_storage_object.dart';
import 'package:zamongcampus/src/object/stomp_object.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';

/// loginId와 token 값의 변화에 따라서 UI가 변경되는가?
/// 그렇지 않다면 ChangeNotifier를 뺴도 될 듯. (22.04.30)
class AuthService extends ChangeNotifier {
  static String? _loginId;
  static String? _acccesToken;
  static String? _refreshToken;

  bool get isLogined => _acccesToken?.isNotEmpty ?? false;
  static String? get loginId => _loginId;
  static String? get token => _acccesToken;
  static String? get refreshToken => _refreshToken;

  /// login하면서 loginId(user)에 해당되는 데이터들 불러옴
  /// 1. access token,refresh token,loginId 값 넣기
  /// 2. 밀린 메시지 불러오고, 채팅방 초기화(+채팅방 불러오기)
  /// 3. 추천친구,추천대화방 load (이건 추후 변경할수도. 주석처리)
  static Future<void> setGlobalLoginIdTokenAndInitUserData(
      {required String loginId,
      required String token,
      required String refreshToken}) async {
    _loginId = loginId;
    _acccesToken = token;
    _refreshToken = refreshToken;

    print(
        'setGlobal data/ loginId: $_loginId /accessToken: $_acccesToken /refreshToken: $_refreshToken');
    HomeViewModel homeViewModel = serviceLocator<HomeViewModel>();
    await homeViewModel.loadNotificationExist();
    homeViewModel.changeCurrentIndex(0);
    ChatViewModel chatViewModel = serviceLocator<ChatViewModel>();
    await chatViewModel.loadChatRooms();
    await StompObject.connectStomp();

    updateUserDeviceToken(); // 추후 삭제될 수도 있음.

    InterestObject.loadMyInterests();

    /** 
      * initstate에서 load를 하는게 맞는지,
      * 아님 하단탭 누를 때마다 load하는게 맞는지. 
    VoiceMainScreenViewModel voicemainvm =
        serviceLocator<VoiceMainScreenViewModel>();
    voicemainvm.loadRecommendUsers();
    voicemainvm.loadVoiceRooms();
    */
  }

  static updateUserDeviceToken() async {
    String? accessToken = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();
    final body = jsonEncode({"deviceToken": FirebaseObject.deviceFcmToken});
    try {
      final response = await http.post(
          Uri.parse(devServer + "/api/user/updateDeviceToken"),
          body: body,
          headers: AuthService.get_auth_header(
              accessToken: accessToken, refreshToken: refreshToken));
      if (response.statusCode == 200) {
        print("서버 user의 devicetoken 변경 완료");
      } else {
        print("실퍠: 서버 user의 devicetoken 변경 못함.");
      }
    } catch (e) {
      // 서버 꺼진 상태
      print("devicetoken변경: 서버 꺼진 상태");
    }
  }

  static Future<void> logout(BuildContext context) async {
    await PrefsObject.deleteLoginId();
    await SecureStorageObject.deleteAllToken();
    StompObject.deactivateStomp();
    Navigator.pushReplacementNamed(context, "/login");
    // postmainviewmodel 삭제 필요.
    // 아마 채팅, 대화들도 필요하지 않을까?
    // 일단 postmainviewmodel만
    PostMainScreenViewModel postMainScreenViewModel =
        serviceLocator<PostMainScreenViewModel>();
    postMainScreenViewModel.resetData();
    VoiceMainScreenViewModel voiceMainScreenViewModel =
        serviceLocator<VoiceMainScreenViewModel>();
    voiceMainScreenViewModel.resetData();
    toastMessage("로그아웃하셨습니다!");
  }

  static Map<String, String> get_auth_header(
      {required String? accessToken, required String? refreshToken}) {
    print('서버로 전달하려는 헤더 accessToken: $accessToken');
    print('서버로 전달하려는 헤더 refreshToken: $refreshToken');
    return {
      "Content-Type": "application/json",
      "Authorization": accessToken!,
      "cookie": refreshToken!
    };
  }

  static Future<void> setAllTokenToAuthService() async {
    _acccesToken = await SecureStorageObject.getAccessToken();
    _refreshToken = await SecureStorageObject.getRefreshToken();
  }

  @override
  String toString() {
    return 'AuthToken{loginId: $_loginId, token: $_acccesToken, refreshToken: $_refreshToken}';
  }
}
