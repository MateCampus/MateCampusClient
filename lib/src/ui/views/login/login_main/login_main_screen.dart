import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/login_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';

import 'components/body.dart';

class LoginMainScreen extends StatelessWidget {
  const LoginMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginMainScreenViewModel vm = serviceLocator<LoginMainScreenViewModel>();
    SizeConfig().init(context: context);
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        behavior: HitTestBehavior.translucent,
        child: Scaffold(backgroundColor: Colors.white, body: Body(vm: vm)));
  }
}
