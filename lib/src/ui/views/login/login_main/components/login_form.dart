import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/size_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/login_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_btn.dart';

// /*
// * https://www.mobileframeworks.dev/flutter-login-signup/
// * */
class LoginForm extends StatefulWidget {
  LoginMainScreenViewModel vm;
  LoginForm({Key? key, required this.vm}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _loginIdTxtCtrl = TextEditingController();
  final TextEditingController _passwordTxtCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buildIDForm(),
        buildPasswordForm(),
        buildLoginButton(context: context),
      ],
    );
  }

  Widget buildIDForm() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenHeight(10)),
      child: TextField(
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.next,
        // autofocus: true,
        controller: _loginIdTxtCtrl,
        style: TextStyle(fontSize: kTextFieldInnerFontSize),
        maxLines: 1,
        decoration: InputDecoration(
          prefixIcon: Icon(
            CupertinoIcons.person_fill,
            color: kTextFieldHintColor,
            size: kTextFieldIconSizeCP,
          ),
          contentPadding: EdgeInsets.all(getProportionateScreenHeight(17)),
          hintText: "아이디를 입력해주세요",
          hintStyle:
              TextStyle(color: Colors.grey, fontSize: kTextFieldInnerFontSize),
          fillColor: Colors.white,
          filled: true,
          border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
      ),
    );
  }

  Widget buildPasswordForm() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenHeight(10)),
      child: TextField(
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.go,
        onSubmitted: (value) {
          widget.vm.login(
              id: _loginIdTxtCtrl.text,
              password: _passwordTxtCtrl.text,
              context: context);
        },
        controller: _passwordTxtCtrl,
        obscureText: true,
        style: TextStyle(fontSize: kTextFieldInnerFontSize),
        maxLines: 1,
        decoration: InputDecoration(
          prefixIcon: Icon(
            CupertinoIcons.lock_fill,
            color: kTextFieldHintColor,
            size: kTextFieldIconSizeCP,
          ),
          contentPadding: EdgeInsets.all(getProportionateScreenHeight(17)),
          hintText: "비밀번호를 입력해주세요",
          hintStyle:
              TextStyle(color: Colors.grey, fontSize: kTextFieldInnerFontSize),
          fillColor: Colors.white,
          filled: true,
          border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
      ),
    );
  }

  buildLoginButton({required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(10),
          horizontal: getProportionateScreenWidth(20)),
      child: DefaultBtn(
        height: getProportionateScreenHeight(50),
        text: '로그인',
        press: () {
          widget.vm.login(
              id: _loginIdTxtCtrl.text,
              password: _passwordTxtCtrl.text,
              context: context);
        },
      ),
    );
  }
}
