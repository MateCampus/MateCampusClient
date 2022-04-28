import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/object/firebase_object.dart';
import 'package:zamongcampus/src/object/prefs_object.dart';
import 'package:zamongcampus/src/object/sqflite_object.dart';
import 'package:zamongcampus/src/object/stomp_object.dart';

/**
 * config init하는 함수
 * prefs, sqflite, firebase
 */
class Init {
  static Future<String> initialize() async {
    // 여기서는 순서대로 하는 것이 맞다. 그래서 async await 개념으로 해야함. 그 안의 함수들도 다.
    await PrefsObject.init();
    await SqfliteObject.database;
    await FirebaseObject.init();
    // 서버 통신 후 token이 실제로 맞는지 확인까지 하고 이동?
    // bool isTokenValid = true;
    // TODO: 단순히 token이 있다고 가는 것이 아님. 확인까지 할 것. (4/6)
    String? loginId = await PrefsObject.getLoginId();
    String? token = await PrefsObject.getToken();
    if (loginId == null || token == null) {
      return "/login";
    } else {
      AuthService.setGlobalLoginIdTokenAndInitUserData(
          token: token, loginId: loginId);
      return "/";
    }
  }
}
