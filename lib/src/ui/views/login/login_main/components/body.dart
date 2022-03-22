import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/login_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';

import 'login_form.dart';
import 'logo.dart';

class Body extends StatelessWidget {
  LoginMainScreenViewModel model;
  Body({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        SizedBox(height: getProportionateScreenHeight(50)),
        Logo(height: getProportionateScreenHeight(200)),
        SizedBox(height: getProportionateScreenHeight(40)),
        LoginForm(model: model),
      ]),
    );
  }
}
