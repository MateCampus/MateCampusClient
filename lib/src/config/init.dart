import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/utils/https_client.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/object/firebase_object.dart';
import 'package:zamongcampus/src/object/local_notification_object.dart';
import 'package:zamongcampus/src/object/prefs_object.dart';
import 'package:zamongcampus/src/object/secure_storage_object.dart';
import 'package:zamongcampus/src/object/sqflite_object.dart';
import 'package:zamongcampus/src/object/stomp_object.dart';
import 'package:http/http.dart' as http;
import 'package:zamongcampus/src/services/login/login_service.dart';

/**
 * config init하는 함수
 * prefs, sqflite, firebase
 */
class Init {
  static Future<String> initialize() async {
    // 여기서는 순서대로 하는 것이 맞다. 그래서 async await 개념으로 해야함. 그 안의 함수들도 다.
    await SecureStorageObject.init();
    await PrefsObject.init();
    await SqfliteObject.database;
    await FirebaseObject.init();
    await LocalNotificationObject.init();
    await HttpsClient().init();
    String? loginId = await PrefsObject.getLoginId();
    String? token = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();
    if (loginId == null || token == null || refreshToken == null) {
      return "/login";
    } else {
      /// 여기 logic
      /// 일단 토큰 재발급 받고
      // 이상 없으면 "/"
      // 아니면 loginId, token 삭제 후 "login"으로.
      LoginService _loginService = serviceLocator<LoginService>();
      bool res = await _loginService.reissueToken();
      if (res) {
        AuthService.setGlobalLoginIdTokenAndInitUserData(
            token: token, loginId: loginId, refreshToken: refreshToken);
        return "/";
      } else {
        return "/login";
      }

      // try {
      //   AuthService.setGlobalLoginIdTokenAndInitUserData(
      //       token: token, loginId: loginId, refreshToken: refreshToken);
      //   return "/";
      // } catch (e) {
      //   // 서버 꺼진 상태
      //   print("서버 꺼진 상태");
      //   PrefsObject.deleteLoginId();
      //   SecureStorageObject.deleteAllToken();
      //   return "/login";
      // }
    }
  }
}
