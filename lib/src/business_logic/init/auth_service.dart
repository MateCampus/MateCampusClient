import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/chat_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/object/prefs_object.dart';
import 'package:zamongcampus/src/object/stomp_object.dart';

/// loginId와 token 값의 변화에 따라서 UI가 변경되는가?
/// 그렇지 않다면 ChangeNotifier를 뺴도 될 듯. (22.04.30)
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

    ChatViewModel chatViewModel = serviceLocator<ChatViewModel>();
    // await chatViewModel.loadChatRooms();
    // await StompObject.connectStomp();

    /// 로그인인데 아직 채팅방 없는 사람과 로그인 안한 사람 구분 해야함.
    /// 로그인한 사람은 무조건 본인의 devicetoken도 구독해야함.
    /// 근데 로그인 안한 사람은 stomp만 연결함.
    /// 로그인 상태인지 아닌지를 뭘로 구분짓지?
    /// 전역변수? 흠.. 일단 그렇게 진행하자.
    /** 
      * initstate에서 load를 하는게 맞는지,
      * 아님 하단탭 누를 때마다 load하는게 맞는지. 
    */
    // voicemainvm.loadRecommendUsers();
    // voicemainvm.loadVoiceRooms();
  }

  static Future<void> logout(BuildContext context) async {
    PrefsObject.removeLoginIdAndToken();
    Navigator.pushReplacementNamed(context, "/login");
    toastMessage("로그아웃하셨습니다!");
  }

  static Map<String, String> get_auth_header() {
    return {
      "Content-Type": "application/json",
      "Authorization": _token!,
    };
  }

  @override
  String toString() {
    return 'AuthToken{loginId: $_loginId, token: $_token}';
  }
}
