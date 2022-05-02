import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/object/prefs_object.dart';
import 'package:zamongcampus/src/services/login/login_service.dart';

class LoginMainScreenViewModel extends BaseModel {
  final LoginService _loginService = serviceLocator<LoginService>();

  void login(
      {required String id,
      required String password,
      required BuildContext context}) async {
    if (id == "" || password == "") {
      snackBar(context: context, message: "입력하지 않은 항목이 있습니다");
      return;
    }
    final response = await _loginService.login(id: id, password: password);
    if (response.statusCode != 200) {
      snackBar(context: context, message: "아이디와 패스워드를 다시 확인해주세요");
      return;
    }
    String token = response.headers["authorization"];
    PrefsObject.setPrefsLoginIdToken(id, token);
    toastMessage("로그인하셨습니다!");
    // 여기서 값이 어떤걸로 넘어오는지 확인할 것.
    AuthService.setGlobalLoginIdTokenAndInitUserData(token: token, loginId: id)
        .then((value) => {
              Future.delayed(const Duration(milliseconds: 1000), () {
                // Navigator.pushReplacementNamed(context, "/");
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/', (Route<dynamic> route) => false);
              }),
            });
  }
}
