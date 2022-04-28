import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/chat_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/object/prefs_object.dart';
import 'package:zamongcampus/src/object/stomp_object.dart';

class AuthService extends ChangeNotifier {
  static String? _loginId;
  static String? _token;

  bool get isLogined => _token?.isNotEmpty ?? false;
  static String? get loginId => _loginId;
  static String? get token => _token;

  /// login하면서 loginId(user)에 해당되는 데이터들 불러옴
  /// 1. token,loginId 값 넣기
  /// 2. 추천친구,추천대화방 load
  /// 3. 밀린 메시지 불러오고, 채팅방 초기화(+채팅방 불러오기)
  /// setGlobalLoginIdTokenAndInitUserData
  static Future<void> setGlobalLoginIdTokenAndInitUserData(
      {required String token, required String loginId}) async {
    _loginId = loginId;
    _token = token;
    VoiceMainScreenViewModel voicemainvm =
        serviceLocator<VoiceMainScreenViewModel>();
    voicemainvm.loadRecommendUsers();
    voicemainvm.loadVoiceRoom();
    ChatViewModel chatViewModel = serviceLocator<ChatViewModel>();
    await chatViewModel.loadChatRooms();
    await StompObject.connectStomp();
    // await chatViewModel
    //     .loadChatRooms()
    //     .then((value) => StompObject.connectStomp());

    /// 로그인인데 아직 채팅방 없는 사람과 로그인 안한 사람 구분 해야함.
    /// 로그인한 사람은 무조건 본인의 devicetoken도 구독해야함.
    /// 근데 로그인 안한 사람은 stomp만 연결함.
    /// 로그인 상태인지 아닌지를 뭘로 구분짓지?
    /// 전역변수? 흠.. 일단 그렇게 진행하자.
    /** 
      * 근데 이렇게 하면, load를 할 필요가 없넹. voiceroom의 경우에는?
      * 그러면 하단 탭 누를 떄마다 load를 안할지도.
      * 근데 post는 load할 듯. 그러면 좀 이상한가.
      * 그러면 post는 load를 언제하지. initstate말고. 하단 tab 2번 누를때마다?
    */
  }

  static Future<void> logout(BuildContext context) async {
    PrefsObject.removeLoginIdAndToken();
    Navigator.pushReplacementNamed(context, "/login");
    toastMessage("로그아웃하셨습니다!");
  }

  static Map<String, String> get_auth_header() {
    return {
      "Content-Type": "application/json",
      "x-auth-token": _token!,
    };
  }

  @override
  String toString() {
    return 'AuthToken{loginId: $_loginId, token: $_token}';
  }
}
