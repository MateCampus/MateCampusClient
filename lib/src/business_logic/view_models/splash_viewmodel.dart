import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/config/init.dart';
import 'package:zamongcampus/src/ui/common_components/signup_bottom_sheet_component/signup_bottom_sheet.dart';

class SplashViewModel extends BaseModel {
  String _firstRoute = '';
  bool _isBuild = false;
  String _splashImg = '';
  String loginImg = '';
  String appStatus = '';

  String get splashImg => _splashImg;

  Future<void> splashInit(BuildContext context) async {
    _firstRoute = await Init.initialize();
    print(_firstRoute + " 로 이동!");
    if (_firstRoute == "/") {
      // await Future.delayed(const Duration(milliseconds: 2000));
      Navigator.of(context).pushNamedAndRemoveUntil(
          _firstRoute, (Route<dynamic> route) => false);
    } else if (_firstRoute == "/login") {
      print(_isBuild);
      // await Future.delayed(const Duration(milliseconds: 2000));
      if (!_isBuild) {
        buildLoginSheet(context);
      }
    } else {
      Navigator.of(context)
          .pushNamedAndRemoveUntil("/error", (Route<dynamic> route) => false);
    }
  }

  void setImage() {
    // int num = Random().nextInt(_splashList.length);
    // _splashImg = _splashList[num][0];
    // loginImg = _splashList[num][1];
    _splashImg = 'assets/images/splash/spalsh_testversion.jpg';
  }

  void buildLoginSheet(BuildContext context) {
    _isBuild = true;
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        barrierColor: Colors.transparent,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) {
          return const SignUpBottomSheet();
        }).whenComplete(() {
      print(_firstRoute);
      Navigator.of(context)
          .pushNamedAndRemoveUntil(_firstRoute, (route) => false);
    });
  }

  void changeAppStatus(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        appStatus = "resumed";
        notifyListeners();
        break;
      case AppLifecycleState.inactive:
        appStatus = "inactive";
        notifyListeners();
        break;
      case AppLifecycleState.detached:
        appStatus = "detached";
        notifyListeners();
        break;
      case AppLifecycleState.paused:
        appStatus = "paused";
        notifyListeners();
        break;
      default:
        appStatus = "active";
        notifyListeners();
        break;
    }
  }
}
