import 'package:flutter/cupertino.dart';
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
          const VerticalSpacing(of: 70),
          LoginForm(vm: vm),
          gotoSignUp(context)
        ]),
      ]),
    );
  }

  backgroundImg() {
    return Image.asset(
      vm.loginBackgroundImg,
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      fit: BoxFit.cover,
      color: Colors.black.withOpacity(0.20),
      colorBlendMode: BlendMode.srcATop,
    );
  }

  logo() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(20)),
      child: SvgPicture.asset(
        'assets/images/svg/login_logo.svg',
        height: getProportionateScreenHeight(100),
        width: getProportionateScreenWidth(262),
        fit: BoxFit.cover,
      ),
    );
  }

  gotoSignUp(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        children: [
          Text(
            '아직 회원이 아니신가요?',
            style: TextStyle(
                color: Colors.white,
                fontSize: resizeFont(14),
                fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/signUpAccount');
            },
            // style: TextButton.styleFrom(
            //     backgroundColor: Colors.white.withOpacity(0.6),
            //     side: BorderSide(color: kMainColor)),
            child: Row(
              children: [
                Text(
                  '회원가입',
                  style: TextStyle(
                      fontSize: resizeFont(15),
                      fontWeight: FontWeight.w700,
                      // decoration: TextDecoration.underline,
                      color: kMainColor),
                ),
                Icon(
                  CupertinoIcons.arrow_right_circle_fill,
                  color: Colors.white,
                  size: getProportionateScreenWidth(18),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
