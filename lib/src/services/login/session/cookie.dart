import 'package:http/http.dart' as http;
import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/object/prefs_object.dart';
import 'package:zamongcampus/src/object/secure_storage_object.dart';

class Cookie {
  //토큰을 재발행하면 쿠키에 넘어오는 refresh token을 로컬에 저장
  static void updateCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      final cookies = rawCookie.split(';');
      String rowRefreshToken = cookies.first;
      //조각낸 쿠키 전부 저장
      PrefsObject.setCookie(cookies);
      //refreshToken 부분만 암호화하여 저장
      SecureStorageObject.setRefreshToken(rowRefreshToken);
      print("헤더에서 뽑아낸 쿠키~~" + rowRefreshToken);
    }
  }
}
