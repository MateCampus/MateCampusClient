import 'package:flutter/material.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/signup_bottom_sheet_component/components/draggable_bar.dart';
import 'package:zamongcampus/src/ui/common_components/signup_bottom_sheet_component/components/greeting_text.dart';
import 'package:zamongcampus/src/ui/common_components/signup_bottom_sheet_component/components/sign_in.dart';
import 'package:zamongcampus/src/ui/common_components/signup_bottom_sheet_component/components/sign_up.dart';

class SignUpBottomSheet extends StatelessWidget {
  const SignUpBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return Container(
      height: getProportionateScreenHeight(354),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Column(
        children: const [
          DraggableBar(),
          GreetingText(),
          SignIn(),
          SignUp(),
        ],
      ),
    );
  }
}
