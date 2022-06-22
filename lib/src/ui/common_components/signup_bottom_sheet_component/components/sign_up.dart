import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_btn.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(5),
          horizontal: getProportionateScreenWidth(20)),
      child: DefaultBtn(
        text: '자몽캠퍼스 회원가입',
        press: () {
          Navigator.pushNamed(context, '/signUpAccount');
        },
        btnColor: Colors.white,
        textColor: kMainColor,
        borderColor: kMainColor,
      ),
    );
  }
}
