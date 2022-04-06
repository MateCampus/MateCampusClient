import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/object/prefs_object.dart';

class AuthService extends ChangeNotifier {
  static String? _loginId;
  static String? _token;

  bool get isLogined => _token?.isNotEmpty ?? false;
  static String? get loginId => _loginId;

  /// login하면서 loginId(user)에 해당되는 데이터들 불러옴
  /// 1. token,loginId 값 넣기
  /// 2. 밀린 메시지 불러오고, 채팅방 초기화(+채팅방 불러오기)
  /// 3. 추천친구,추천대화방 load
  static Future<void> loginAndSetInitData(
      {required String token, required String loginId}) async {
    setTokenAndLoginId(token: token, loginId: loginId);
    VoiceMainScreenViewModel voicemainvm =
        serviceLocator<VoiceMainScreenViewModel>();
    voicemainvm.loadRecommendUsers();
    voicemainvm.loadVoiceRoom();
    /** 
      * 근데 이렇게 하면, load를 할 필요가 없넹. voiceroom의 경우에는?
      * 그러면 하단 탭 누를 떄마다 load를 안할지도.
      * 근데 post는 load할 듯. 그러면 좀 이상한가.
      * 그러면 post는 load를 언제하지. initstate말고. 하단 tab 2번 누를때마다?
    */
  }

  static Future<void> setTokenAndLoginId(
      {required String token, required String loginId}) async {
    AuthService._loginId = loginId;
    AuthService._token = token;
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
