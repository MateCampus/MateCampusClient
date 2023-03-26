import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/bottom_fixed_btn_decobox.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_interest/components/interest_select.dart';

class Body extends StatelessWidget {
  final SignUpViewModel vm;
  const Body({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const VerticalSpacing(of: 30),
        Padding(
          padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
        vertical: getProportionateScreenHeight(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(
                      text: '관심사',
                      style: TextStyle(
                        fontSize: resizeFont(26),
                        fontWeight: FontWeight.w500,
                        color: kMainColor,
                      ),
                      children: [
                    TextSpan(
                        text: '를\n골라주세요',
                        style: TextStyle(
                            fontSize: resizeFont(26),
                            color: Color(0xff111111),
                            fontWeight: FontWeight.w500))
                  ])),
                  VerticalSpacing(of:5),
          Text(
            '최대 10개까지 선택할 수 있어요',
            style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: resizeFont(16),
                fontWeight: FontWeight.w500,
                color: kMainColor),
          )
            ],
          ),
        ),
        const VerticalSpacing(of: 30),
        Expanded(child: Padding(
          padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
        ),
          child: InterestSelect(vm: vm),
        )),
        SafeArea(
            child: BottomFixedBtnDecoBox(
                child: DefaultBtn(
                    text: '회원가입 완료하기',
                    textColor:(vm.selectedInterests.length>=3)?Colors.white: Color(0xff999999),
                    btnColor: (vm.selectedInterests.length>=3)?kMainColor:Color(0xffe5e5ec),
                    press: () {
                      vm.createUser(context);
                    })))
      ],
    );
  }
}
