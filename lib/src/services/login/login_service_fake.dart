import 'dart:collection';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:zamongcampus/src/services/login/login_service.dart';

class FakeLoginService implements LoginService {
  @override
  Future<bool> login({required String id, required String password}) async {
    Map<String, String> body = HashMap();
    body.putIfAbsent("loginId", () => id);
    body.putIfAbsent(
        "password", () => sha256.convert(utf8.encode(password)).toString());
    print("fake login");
    return true;
    // FakeRes(
    //     statusCode: 200, headers: {"authorization": "fakeauthtoken"});
  }

  @override
  Future<void> reissueToken() async {
    // TODO: implement checkTokenValidation
    throw UnimplementedError();
  }
}

class FakeRes {
  int statusCode;
  Map<String, String> headers;

  FakeRes({this.statusCode = 200, required this.headers});
}
