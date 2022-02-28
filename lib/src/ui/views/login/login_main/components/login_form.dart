import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/login_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';

// /*
// * https://www.mobileframeworks.dev/flutter-login-signup/
// * */
class LoginForm extends StatelessWidget {
  LoginMainScreenViewModel model;
  LoginForm({Key? key, required this.model}) : super(key: key);

  TextEditingController loginIdTxtCtrl = TextEditingController();
  TextEditingController passwordTxtCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenHeight(350),
      child: Column(
        children: <Widget>[
          buildIDForm(),
          const VerticalSpacing(of: 30),
          buildPasswordForm(),
          const VerticalSpacing(of: 30),
          buildLoginButton(context: context),
        ],
      ),
    );
  }

  buildIDForm() {
    return Container(
      width: getProportionateScreenWidth(350),
      height: getProportionateScreenHeight(50),
      padding: const EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
      child: TextField(
        controller: loginIdTxtCtrl,
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          border: InputBorder.none,
          icon: Icon(
            Icons.person,
            color: kPrimaryColor,
          ),
          hintText: 'ID',
        ),
      ),
    );
  }

  buildPasswordForm() {
    return Container(
      width: getProportionateScreenWidth(350),
      height: getProportionateScreenHeight(50),
      padding: const EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
      child: TextFormField(
        obscureText: true,
        controller: passwordTxtCtrl,
        textInputAction: TextInputAction.done,
        decoration: const InputDecoration(
          border: InputBorder.none,
          icon: Icon(
            Icons.vpn_key,
            color: kPrimaryColor,
          ),
          hintText: 'Password',
        ),
      ),
    );
  }

  buildLoginButton({required BuildContext context}) {
    return InkWell(
      onTap: () {
        model.login(
            id: loginIdTxtCtrl.text,
            password: passwordTxtCtrl.text,
            context: context);
      },
      child: Container(
        height: getProportionateScreenHeight(50),
        width: getProportionateScreenWidth(50),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                kPrimaryColor,
                kSecondaryColor,
              ],
            ),
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: const Center(
          child: Text(
            "LOGIN",
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
