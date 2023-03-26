import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/bottom_fixed_btn_decobox.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/disabled_default_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/sign_up_rich_text.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_account/components/user_id_input.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_account/components/user_password_input.dart';

class Body extends StatefulWidget {
  final SignUpViewModel vm;
  const Body({Key? key, required this.vm}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();

    widget.vm.userIdController.addListener(() {
      widget.vm.notifyListeners();
    });
  }

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
                      colorText: '사용하실 아이디와 비밀번호', postPositionText: '를'),
                  const VerticalSpacing(of: 30),
                  UserIdInput(vm: widget.vm),
                  const VerticalSpacing(of: 30),
                  UserPasswordInput(vm: widget.vm),
                ],
              ),
            ),
          ),
        ),
        SafeArea(
          child: BottomFixedBtnDecoBox(
            child: (widget.vm.userIdController.text.isNotEmpty &&
                    widget.vm.isValidPW)
                ? DefaultBtn(
                    text: '다음',
                    press: () {
                      widget.vm.checkIdRedundancy(context);
                    },
                  )
                : const DisabledDefaultBtn(text: '다음'),
          ),
        ),
      ],
    );
  }
}
