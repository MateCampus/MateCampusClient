import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/object/firebase_object.dart';
import 'package:zamongcampus/src/object/local_notification_object.dart';
import 'package:zamongcampus/src/object/prefs_object.dart';
import 'package:zamongcampus/src/object/secure_storage_object.dart';
import 'package:zamongcampus/src/object/sqflite_object.dart';
import 'package:zamongcampus/src/object/stomp_object.dart';
import 'package:http/http.dart' as http;

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
    String? loginId = await PrefsObject.getLoginId();
    String? token = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();
    if (loginId == null || token == null || refreshToken == null) {
      return "/login";
    } else {
      //여기서 토큰 유효한지를 확인해야한다고 생각했는데 어차피 루트로 가자마자 .. 어떠한 api든 요청이되니까 상관없지 않을까..

      // return "/";

      /// 여기 logic
      // token의 validation 확인
      // 이상 없으면 "/"
      // 아니면 loginId, token 삭제 후 "login"으로.
      try {
        AuthService.setGlobalLoginIdTokenAndInitUserData(
            token: token, loginId: loginId, refreshToken: refreshToken);
        return "/";
      } catch (e) {
        // 서버 꺼진 상태
        print("서버 꺼진 상태");
        PrefsObject.deleteLoginId();
        SecureStorageObject.deleteAllToken();
        return "/login";
      }
    }
  }
}
