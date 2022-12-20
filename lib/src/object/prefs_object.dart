import 'package:shared_preferences/shared_preferences.dart';

// loginID와 Token를 authservice가 아닌, 여기에 둘 수도 있다.
// loginId와 token이 변경될 때, 달라지는 것이 있는가 ?
// 없다면 굳이 구분지을 필요 없이. 한 곳에 두는 것이 좋다(authservice와 storagekeys)
// 4.6(목)
class StorageKeys {
  // static const String token = "TOKEN";
  static const String loginId = "LOGINID";
  static const String totalLastMsgCreatedAt = "TOTALLASTMSGCREATEDAT";
  static const String blockedUsers = "BLOCKEDUSERS";

  static const String cookie = "COOKIE";
}

class PrefsObject {
  static late SharedPreferences _prefs;

  static Future<SharedPreferences> init() async {
    print("prefs init start");
    _prefs = await SharedPreferences.getInstance();
    print("prefs init end");
    return _prefs;
  }

  ///getter, setter for cookie -> 쿠키를 ;를 기준으로 잘라서 리스트에다 넣어둔 것. 그 중 첫번째가 refresh토큰 값인데
  ///이 값은 SecureStorage에도 저장을 해둔다. 혹시 몰라서 전체 잘라진 쿠키도 여기다 저장해두는 것.

  static List<String>? getCookie() {
    return _prefs.getStringList(StorageKeys.cookie);
  }

  static void setCookie(List<String> cookies) async {
    _prefs.setStringList(StorageKeys.cookie, cookies);
  }

  /// getter, setter for loginId, token
  static Future<String?> getLoginId() async {
    return _prefs.getString(StorageKeys.loginId);
  }

  // static Future<String?> getToken() async {
  //   return _prefs.getString(StorageKeys.token);
  // }

  static Future<void> setPrefsLoginId(String loginId) async {
    _prefs.setString(StorageKeys.loginId, loginId);
  }

  static Future<void> deleteLoginId() async {
    _prefs.remove(StorageKeys.loginId);
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

  ///getter, setter for BlockedUser
  static Future<List<String>?> getBlockedUsers() async {
    return _prefs.getStringList(StorageKeys.blockedUsers);
  }

//어떠한 로그인 아이다가 차단 리스트에 존재하는지 유무 판단.
  static Future<bool> getBlockedUserByLoginId(String loginId) async {
    List<String> blockedUsers =
        _prefs.getStringList(StorageKeys.blockedUsers) ?? [];
    if (blockedUsers.isNotEmpty) {
      int index = blockedUsers.indexOf(
          loginId); //여기서 만약에 리스트 자체는 비어있지 않은데 내가 찾아보려는 로그인 아이디가 리스트안에 없으면 -1을 반환하는 것 같다. 따라서 분기를 한 번 더 해줌.
      if (index < 0) {
        return false;
      } else {
        print("로컬디비에 저장된 차단된 로그인 아이디 : " + blockedUsers.elementAt(index));
        return true;
      }
    } else {
      return false;
    }
  }

  //차단하는 유저아이디 로컬디비에 추가.
  static void setBlockedUser(String blockedUserId) {
    List<String> blockedUsers =
        _prefs.getStringList(StorageKeys.blockedUsers) ?? [];
    blockedUsers.add(blockedUserId);
    _prefs.setStringList(StorageKeys.blockedUsers, blockedUsers);
  }

  static void setBlockedUsers(List<String> blockedUsers) {
    _prefs.setStringList(StorageKeys.blockedUsers, blockedUsers);
  }
}
