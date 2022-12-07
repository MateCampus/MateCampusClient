import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/bottom_fixed_btn_decobox.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/sign_up_rich_text.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';
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
            controller: vm.optionalProfileScrollController,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                  vertical: getProportionateScreenHeight(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSpacing(of: 30),
                  const SignUpRichText(colorText: '프로필', postPositionText: '을'),
                  const VerticalSpacing(of: 30),
                  SelectProfileImage(vm: vm),
                  const VerticalSpacing(of: 30),
                  UserIntroduceInput(vm: vm)
                ],
              ),
            ),
          ),
        ),
        SafeArea(
          child: BottomFixedBtnDecoBox(
            child: DefaultBtn(
              text: '건너뛰기',
              textColor: (vm.userImgPath.isNotEmpty&&vm.userIntroduceController.text.isNotEmpty) ? Colors.white: Color(0xff999999),
              btnColor: (vm.userImgPath.isNotEmpty&&vm.userIntroduceController.text.isNotEmpty)?kMainColor:Color(0xffe5e5ec),
              press: () {
                // FocusScope.of(context).unfocus();
                Navigator.pushNamed(context, "/signUpInterest");
              },
            ),
          ),
        ),
      ],
    );
  }
}
