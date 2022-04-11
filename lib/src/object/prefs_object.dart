import 'package:shared_preferences/shared_preferences.dart';

// loginID와 Token를 authservice가 아닌, 여기에 둘 수도 있다.
// loginId와 token이 변경될 때, 달라지는 것이 있는가 ?
// 없다면 굳이 구분지을 필요 없이. 한 곳에 두는 것이 좋다(authservice와 storagekeys)
// 4.6(목)
class StorageKeys {
  static const String token = "TOKEN";
  static const String loginId = "LOGINID";
  static const String totalLastMsgCreatedAt = "TOTALLASTMSGCREATEDAT";
}

class PrefsObject {
  static late SharedPreferences _prefs;

  static Future<SharedPreferences> init() async {
    print("prefs init start");
    _prefs = await SharedPreferences.getInstance();
    print("prefs init end");
    return _prefs;
  }

  /// getter, setter for loginId, token
  static Future<String?> getLoginId() async {
    return _prefs.getString(StorageKeys.loginId);
  }

  static Future<String?> getToken() async {
    return _prefs.getString(StorageKeys.token);
  }

  static void setPrefsLoginIdToken(String loginId, String token) async {
    _prefs.setString(StorageKeys.loginId, loginId);
    _prefs.setString(StorageKeys.token, token);
  }

  static void removeLoginIdAndToken() async {
    _prefs.remove(StorageKeys.loginId);
    _prefs.remove(StorageKeys.token);
  }

  /// getter, setter for totalLastMsgCreatedAt
  /// TODO: 나중에 반드시 total -> 이거는 암호화해서 저장할 것
  static Future<String?> getTotalLastMsgCreatedAt() async {
    return _prefs.getString(StorageKeys.totalLastMsgCreatedAt);
  }

  static void setTotalLastMsgCreatedAt(String totalLastMsgCreatedAt) async {
    _prefs.setString(StorageKeys.totalLastMsgCreatedAt, totalLastMsgCreatedAt);
  }

  static void removeTotalLastMsgCreatedAt() async {
    _prefs.remove(StorageKeys.totalLastMsgCreatedAt);
  }
}
