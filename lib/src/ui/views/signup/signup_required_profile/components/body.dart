import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/bottom_fixed_btn_decobox.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/disabled_default_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/sign_up_rich_text.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_required_profile/components/birthday_input.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_required_profile/components/check_gender.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_required_profile/components/grade_input.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_required_profile/components/nickname_input.dart';

class Body extends StatefulWidget {
  final SignUpViewModel vm;
  const Body({Key? key, required this.vm}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
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
                    const VerticalSpacing(of: 30),
                    const SignUpRichText(
                        colorText: '본인 정보', postPositionText: '를'),
                    const VerticalSpacing(of: 30),
                    NicknameInput(vm: widget.vm),
                    const VerticalSpacing(of: 30),
                    GradeInput(
                      vm: widget.vm,
                    ),
                    const VerticalSpacing(of: 30),
                    CheckGender(vm: widget.vm),
                    const VerticalSpacing(of: 30),
                    BirthdayInput(vm: widget.vm)
                  ]),
            ),
          ),
        ),
        // const MiddleText(),
        // Expanded(child: SelectInterests(vm: vm)),
        SafeArea(
            child: BottomFixedBtnDecoBox(
          child: (widget.vm.userNicknameController.text.isNotEmpty &&
                  widget.vm.gradeIndex != 0 &&
                  widget.vm.genderIndex != -1 &&
                  widget.vm.birthday != '0000-00-00')
              ? DefaultBtn(
                  text: '다음',
                  press: () {
                    widget.vm
                        .checkNicknameRedundancy(context); //닉네임 중복확인 및 유효성 검사
                    // Navigator.pushNamed(context, '/signUpOptionalProfile');
                  },
                )
              : const DisabledDefaultBtn(text: '다음'),
        ))
      ],
    );
  }
}
