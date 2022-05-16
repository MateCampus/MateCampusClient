import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_disable_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_shadow.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_account/components/user_id_input.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_account/components/user_password_input.dart';

class Body extends StatelessWidget {
  final SignUpViewModel vm;
  const Body({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                  vertical: getProportionateScreenHeight(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserIdInput(vm: vm),
                  UserPasswordInput(vm: vm),
                ],
              ),
            ),
          ),
        ),
        DefaultShadowBox(
          child: Padding(
            padding: defaultPadding,
            child: (vm.isValidId && vm.isValidPW)
                ? DefaultBtn(
                    text: '다음',
                    press: () {
                      Navigator.pushNamed(context, "/signUpCollege");
                    },
                  )
                : const DefaultDisalbeBtn(text: '다음'), //비활성화 버튼
          ),
        ),
      ],
    );
  }
}
