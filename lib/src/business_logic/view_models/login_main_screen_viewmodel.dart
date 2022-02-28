import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/business_logic/view_models/main_view_model.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/services/login/login_service.dart';

class LoginMainScreenViewModel extends BaseModel {
  final LoginService _loginService = serviceLocator<LoginService>();

  void login(
      {required String id,
      required String password,
      required BuildContext context}) async {
    if (id == "" || password == "") {
      snackBar(message: "입력하지 않은 항목이 있습니다");
      return;
    }
    final response = await _loginService.login(id: id, password: password);
    if (response.statusCode != 200) {
      snackBar(message: "아이디와 패스워드를 다시 확인해주세요");
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', response.headers["x-auth-token"]);
    prefs.setString('loginId', id);
    snackBar(message: "로그인하셨습니다!", color: Colors.blueAccent);

    MainViewModel vm = serviceLocator<MainViewModel>();
    vm
        .setTokenAndLoginId(response.headers["x-auth-token"], id)
        .then((value) => print("token 값 변경 완료, 추천친구/대화방 불러오기 loginId로"));
    // HomeController.to
    //     .setTokenAndLoginId(
    //         response.headers["x-auth-token"], loginIdTxtCtrl.text)
    //     .then((value) => {
    //           Get.lazyPut(() => NewsController()),
    //           NewsController.to.initNewsController(),
    //           Get.put(ChatController()),
    //           Get.put(MatchController()),
    //         });
    Future.delayed(const Duration(milliseconds: 1000), () {
      Navigator.pushNamed(context, "/");
    });
  }
}
