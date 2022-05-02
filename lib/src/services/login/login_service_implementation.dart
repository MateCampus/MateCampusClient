import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/services/login/login_service.dart';
import 'package:http/http.dart' as http;

class LoginServiceImpl extends LoginService {
  @override
  Future login({required String id, required String password}) async {
    var body = {"loginId": id, "password": password};
    final response = await http
        .post(Uri.parse(devServer + "/api/authenticate"),
            headers: {
              "Content-Type": "application/json",
            },
            body: jsonEncode(body))
        .catchError((e) {
      throw Exception();
    });
    print("login impl");
    return response;
  }

  @override
  Future checkTokenValidation() {
    // TODO: implement checkTokenValidation
    throw UnimplementedError();
  }
}
