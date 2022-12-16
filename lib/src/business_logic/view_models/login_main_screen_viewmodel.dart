import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/business_logic/view_models/splash_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/object/prefs_object.dart';
import 'package:zamongcampus/src/object/secure_storage_object.dart';
import 'package:zamongcampus/src/services/login/login_service.dart';

class LoginMainScreenViewModel extends BaseModel {
  final LoginService _loginService = serviceLocator<LoginService>();
  String _loginBackgroundImg = '';
  String? token;
  String? refreshToken;

  String get loginBackgroundImg => _loginBackgroundImg;

  void login(
      {required String id,
      required String password,
      required BuildContext context}) async {
    if (id == "" || password == "") {
      snackBar(context: context, message: "입력하지 않은 항목이 있습니다");
      return;
    }
    bool loginResult = await _loginService.login(id: id, password: password);
    if (loginResult) {
      token = await SecureStorageObject.getAccessToken();
      refreshToken = await SecureStorageObject.getRefreshToken();
      toastMessage('자몽캠퍼스에 오신걸 환영합니다!');
    } else {
      snackBar(context: context, message: "아이디와 패스워드를 다시 확인해주세요");
      return;
    }
    // final response = await _loginService.login(id: id, password: password);
    // String? token = await PrefsObject.getToken();
    // if (response.statusCode != 200) {
    //   snackBar(context: context, message: "아이디와 패스워드를 다시 확인해주세요");
    //   return;
    // }
    // String token = response.headers["authorization"];
    // print(token);
    // PrefsObject.setPrefsLoginIdToken(id, token);
    // toastMessage("로그인하셨습니다!");
    // 여기서 값이 어떤걸로 넘어오는지 확인할 것.
    await AuthService.setGlobalLoginIdTokenAndInitUserData(
            token: token!, loginId: id, refreshToken: refreshToken!)
        .then((value) => {
              Future.delayed(const Duration(milliseconds: 1000), () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/', (Route<dynamic> route) => false);
              }),
            });
  }

  void setImage() {
    // SplashViewModel splashViewModel = serviceLocator<SplashViewModel>();
    // _loginBackgroundImg = splashViewModel.loginImg;
    _loginBackgroundImg = 'assets/images/temp/login_background.jpg';
  }
}
