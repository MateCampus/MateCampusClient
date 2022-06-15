import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/bottom_fixed_btn_decobox.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_btn.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_optional_profile/components/select_profile_image.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_optional_profile/components/user_introduce_input.dart';

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
                  SelectProfileImage(vm: vm),
                  UserIntroduceInput(vm: vm)
                ],
              ),
            ),
          ),
        ),
        SafeArea(
          child: BottomFixedBtnDecoBox(
            child:
                (vm.userImgPath != '' && vm.userIntroduceController.text != '')
                    ? DefaultBtn(
                        text: '회원가입 완료',
                        press: () {
                          vm.createUser(context);
                        },
                      )
                    : DefaultBtn(
                        text: '회원가입 완료',
                        btnColor: Colors.grey.withOpacity(0.5),
                        press: () {
                          vm.createUser(context);
                        },
                      ),
          ),
        ),
      ],
    );
  }
}
