import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/view_models/login_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';

import 'components/body.dart';

class LoginMainScreen extends StatefulWidget {
  const LoginMainScreen({Key? key}) : super(key: key);

  @override
  State<LoginMainScreen> createState() => _LoginMainScreenState();
}

class _LoginMainScreenState extends State<LoginMainScreen> {
  LoginMainScreenViewModel vm = serviceLocator<LoginMainScreenViewModel>();

  @override
  void initState() {
    vm.setImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return ChangeNotifierProvider.value(
        value: vm,
        child: Consumer<LoginMainScreenViewModel>(
          builder: (context, value, child) {
            return GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                behavior: HitTestBehavior.translucent,
                child: Scaffold(
                    backgroundColor: Colors.white, body: Body(vm: vm)));
          },
        ));
  }
}
