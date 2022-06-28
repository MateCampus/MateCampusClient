import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';
import 'package:zamongcampus/src/ui/common_widgets/bottom_fixed_btn_decobox.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/disabled_default_btn.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_required_profile/components/middle_text.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_required_profile/components/nickname_input.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_required_profile/components/select_interests.dart';

class Body extends StatelessWidget {
  final SignUpViewModel vm;
  const Body({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch, //temptext 왼쪽 정렬위함 ->추후 수정
      children: [
        NicknameInput(vm: vm),
        const MiddleText(),
        Expanded(child: SelectInterests(vm: vm)),
        SafeArea(
            child: BottomFixedBtnDecoBox(
          child: (vm.isValidNickname && vm.selectedInterests.length >= 3)
              ? DefaultBtn(
                  text: '다음',
                  press: () {
                    Navigator.pushNamed(context, '/signUpOptionalProfile');
                  },
                )
              : const DisabledDefaultBtn(text: '다음'),
        ))
      ],
    );
  }
}
