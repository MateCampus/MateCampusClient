import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';

import '../view_models/base_model.dart';

class AuthService extends BaseModel {
  String? loginId;
  String? token;

  bool get isLogined => token?.isNotEmpty ?? false;

  /* 1. token,loginId 값 넣기  2. 추천친구,추천대화방 load */
  Future<void> authInit(
      {required String token, required String loginId}) async {
    setTokenAndLoginId(token: token, loginId: loginId);
    VoiceMainScreenViewModel voicemainvm =
        serviceLocator<VoiceMainScreenViewModel>();
    voicemainvm.loadRecommendUsers();
    voicemainvm.loadVoiceRoom();
  }

  Future<void> setTokenAndLoginId(
      {required String token, required String loginId}) async {
    setBusy(true);
    this.loginId = loginId;
    this.token = token;
    setBusy(false);
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('loginId');
    prefs.remove('token');
    Navigator.pushReplacementNamed(context, "/login");
    toastMessage("로그아웃하셨습니다!");
  }

  Map<String, String> get_auth_header() {
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
