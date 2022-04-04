import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';

class AuthService extends ChangeNotifier {
  static String? loginId;
  static String? token;

  bool get isLogined => token?.isNotEmpty ?? false;

  /*  1. token,loginId 값 넣기  
      2. stomp 연결 / 채팅방 초기화 / 채팅방 불러오기
      3. 추천친구,추천대화방 load 
  */
  /* 아무곳에서나 못 사용하도록 static 선언 안함 */
  Future<void> loginAndSetInitData(
      {required String token, required String loginId}) async {
    setTokenAndLoginId(token: token, loginId: loginId);
    VoiceMainScreenViewModel voicemainvm =
        serviceLocator<VoiceMainScreenViewModel>();
    voicemainvm.loadRecommendUsers();
    voicemainvm.loadVoiceRoom();
    // 근데 이렇게 하면, load를 할 필요가 없넹. voiceroom의 경우에는?
    // 그러면 하단 탭 누를 떄마다 load를 안할지도.
    // 근데 post는 load할 듯. 그러면 좀 이상한가.
    // 그러면 post는 load를 언제하지. initstate말고.
  }

  Future<void> setTokenAndLoginId(
      {required String token, required String loginId}) async {
    AuthService.loginId = loginId;
    AuthService.token = token;
  }

  static Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('loginId');
    prefs.remove('token');
    Navigator.pushReplacementNamed(context, "/login");
    toastMessage("로그아웃하셨습니다!");
  }

  static Map<String, String> get_auth_header() {
    return {
      "Content-Type": "application/json",
      "x-auth-token": token!,
    };
  }

  @override
  String toString() {
    return 'AuthToken{loginId: $loginId, token: $token}';
  }
}
