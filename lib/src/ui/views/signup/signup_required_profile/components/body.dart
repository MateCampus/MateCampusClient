import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_disable_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_shadow.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_required_profile/components/nickname_input.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_required_profile/components/select_interests.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_required_profile/components/temp_text.dart';

class Body extends StatelessWidget {
  final SignUpViewModel vm;
  const Body({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const VerticalSpacing(of: 10),
        NicknameInput(vm: vm),
        const TempText(), // 임시방편 -> 나중에 수정할것
        Expanded(child: SelectInterests(vm: vm)),
      ],
    );
  }
}
