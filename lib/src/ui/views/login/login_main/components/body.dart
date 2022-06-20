import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/login_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';

import 'login_form.dart';

class Body extends StatelessWidget {
  LoginMainScreenViewModel vm;
  Body({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Stack(alignment: AlignmentDirectional.center, children: [
        backgroundImg(),
        Column(children: [
          logo(),
          const VerticalSpacing(of: 80),
          LoginForm(vm: vm),
          gotoSignUp(context)
        ]),
      ]),
    );
  }
}

backgroundImg() {
  return Container(
    height: SizeConfig.screenHeight,
    width: SizeConfig.screenWidth,
    decoration: const BoxDecoration(
      image: DecorationImage(
          image: AssetImage('assets/images/temp/login_background.jpg'),
          fit: BoxFit.cover),
    ),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: Container(
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)),
      ),
    ),
  );
}

logo() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(20)),
    child: SvgPicture.asset(
      'assets/images/svg/textlogo.svg',
      height: getProportionateScreenHeight(68),
      width: getProportionateScreenWidth(252),
    ),
  );
}

gotoSignUp(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
    child: Row(
      children: [
        Text(
          '아직 회원이 아니신가요?',
          style: TextStyle(
              color: Colors.white,
              fontSize: getProportionateScreenWidth(14),
              fontWeight: FontWeight.w500),
        ),
        const Spacer(),
        TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/signUpAccount');
            },
            child: Text(
              '회원가입',
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(14),
                  decoration: TextDecoration.underline,
                  color: kMainColor),
            ))
      ],
    ),
  );
}
