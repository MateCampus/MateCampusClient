import 'package:flutter_secure_storage/flutter_secure_storage.dart';

///accessToken, cookie(refreshToken) 저장 -> 토큰값만 저장해두자!
///일단은 sharedPref과 비슷하게..

class SecureStorageKeys {
  static const String accessToken = "ACCESSTOKEN";
  // static const String loginId = "LOGINID";
  static const String refreshToken = "REFRESHTOKEN";
}

class SecureStorageObject {
  static late FlutterSecureStorage _storage;

  static Future<FlutterSecureStorage> init() async {
    print('init secureStorage');
    //나중에 뭔가 이 안에서 옵션을 설정해야한다면 인스턴스 만드는 이 부분에서 해줘야함.
    _storage = const FlutterSecureStorage();
    return _storage;
  }

  ///getter
  static Future<String?> getAccessToken() async {
    return _storage.read(key: SecureStorageKeys.accessToken);
  }

  // static Future<String?> getLoginId() async {
  //   return _storage.read(key: SecureStorageKeys.loginId);
  // }

  //쿠키의 첫번째 스트링 값만 빼내서 저장. 사실 서버에는 얘만 보내도 무관한데 추후 쿠키값이 늘어난다면 안될지도
  static Future<String?> getRefreshToken() async {
    return _storage.read(key: SecureStorageKeys.refreshToken);
  }

  ///setter
  static Future<void> setAccessTokenForFistLogin(String accessToken) async {
    _storage.write(key: SecureStorageKeys.accessToken, value: accessToken);
  }

  //토큰이 재발행되는 모든 순간에는 이걸 써야함. 왜냐면 재발행되는 토큰은 헤더가 아닌 body에서 빼오기때문에 Bearer이 없음
  static Future<void> setAccessToken(String accessToken) async {
    _storage.write(
        key: SecureStorageKeys.accessToken, value: "Bearer " + accessToken);
  }

  // static void setLoginId(String loginId) async {
  //   _storage.write(key: SecureStorageKeys.loginId, value: loginId);
  // }

  static Future<void> setRefreshToken(String refreshToken) async {
    _storage.write(key: SecureStorageKeys.refreshToken, value: refreshToken);
  }

  ///func
  ///원래 prefs에서는 로그인 따로 토큰 따로 set하는 것이 없고 한꺼번에 set했었음. 이거는 생각을 좀 해봐야하는데 일단 똑같이 테스트 해보기 위해서 만듦.
  // static void setSecureStorageLoginIdToken(
  //     String loginId, String accessToken) async {
  //   _storage.write(key: SecureStorageKeys.loginId, value: loginId);
  //   _storage.write(key: SecureStorageKeys.accessToken, value: accessToken);
  // }
  static void deleteAccessToken() async {
    _storage.delete(key: SecureStorageKeys.accessToken);
  }

  static void deleteRefreshToken() async {
    _storage.delete(key: SecureStorageKeys.refreshToken);
  }

  static Future<void> deleteAllToken() async {
    _storage.delete(key: SecureStorageKeys.refreshToken);
    _storage.delete(key: SecureStorageKeys.accessToken);
  }

  static void showAllData() async {
    String? token = await _storage.read(key: SecureStorageKeys.accessToken);
    String? rtk = await _storage.read(key: SecureStorageKeys.refreshToken);
    print('토큰');
    print(token);
    print('쿠키토큰');
    print(rtk);
  }
}
