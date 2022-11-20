import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/object/prefs_object.dart';
import 'package:zamongcampus/src/object/secure_storage_object.dart';
import 'package:zamongcampus/src/services/login/login_service.dart';
import 'package:http/http.dart' as http;
import 'package:zamongcampus/src/services/login/session/cookie.dart';

class LoginServiceImpl extends LoginService {
  @override
  Future<bool> login({required String id, required String password}) async {
    var body = {"loginId": id, "password": password};
    final response = await http.post(Uri.parse(devServer + "/api/authenticate"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(body));

    if (response.statusCode == 200) {
      String? token = response.headers["authorization"];
      await PrefsObject.setPrefsLoginId(id);
      await SecureStorageObject.setAccessTokenForFistLogin(token!);
      Cookie.updateCookie(response);
      print('login impl 성공');
      return true;
    } else if (response.statusCode == 400) {
      //포스트맨에서 테스트했을때 400이 뜰때는 아이디, 비밀번호가 3자 이하로 쳤을때 400이 떴음.. 근데 왜 이렇게 되는진 모르겠는데
      //근데 이게 앱에서 돌려볼때는 200으로 넘어올수도 있기때문에 테스트는 무조건 3자넘겨서 해보자
      return false;
    } else if (response.statusCode == 401) {
      print('등록된 유저가 아님. 여기서는 아마 토큰 문제가 아님. 왜냐면 애초에 여기선 토큰을 서버에 보내질않음.');
      return false;
    } else {
      return false;
    }
  }

  @override
  Future<void> reissueToken() async {
    String? accessToken = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();
    final response = await http.post(
        Uri.parse(devServer + "/api/authenticate/refresh/jwt-token"),
        headers: AuthService.get_auth_header(
            accessToken: accessToken, refreshToken: refreshToken));
    if (response.statusCode == 200) {
      var json = await jsonDecode(utf8.decode(response.bodyBytes));
      String reissuedToken = json["token"];
      SecureStorageObject.setAccessToken(reissuedToken);
      print("새로발행된토큰" + reissuedToken);
      Cookie.updateCookie(response);
    } else {
      //토큰 재발행이 실패했을경우 -> 모든 토큰들 다 지우고 로그인화면으로 가야하지 않을까? 근데 로그인 화면으로 이동하기엔 context가 필요하다..
      //TODO: 좀 더 알맞는 방법이 있다면 수정해야함.
      PrefsObject.deleteLoginId();
      SecureStorageObject.deleteAllToken();
      // Navigator.of(context).pushNamedAndRemoveUntil(
      //               '/', (Route<dynamic> route) => false);
      print('토큰 재발행 실패. 로그인페이지 이동');
    }
  }
}
