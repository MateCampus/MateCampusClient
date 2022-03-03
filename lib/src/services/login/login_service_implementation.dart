import 'dart:collection';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/services/login/login_service.dart';
import 'package:http/http.dart' as http;

class LoginServiceImpl extends LoginService {
  @override
  Future login({required String id, required String password}) async {
    Map<String, String> body = HashMap();
    body.putIfAbsent("loginId", () => id);
    body.putIfAbsent(
        "password", () => sha256.convert(utf8.encode(password)).toString());

    final response = await http
        .post(Uri(path: devServer + "/api/login"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(body))
        .catchError((e) {
      throw Exception();
    });
    return response;
  }
}
