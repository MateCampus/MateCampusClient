import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/bottom_fixed_btn_decobox.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/disabled_default_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';

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
                vertical: getProportionateScreenHeight(20),
                horizontal: getProportionateScreenWidth(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(
                        fontSize: kLabelFontSize, color: Colors.black87),
                    controller: vm.requestController,
                    maxLines: 7,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: "추가하려는 학교명 혹은 학과명을 입력해주세요",
                      hintStyle: TextStyle(
                          color: kTextFieldHintColor,
                          fontSize: kTextFieldInnerFontSize),
                      fillColor: kTextFieldColor,
                      filled: true,
                      border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                    ),
                  ),
                  const VerticalSpacing(of: 15),
                  Text(
                    '* 요청 사항에 대한 답변을 받아보고 싶다면 이메일 주소를 함께 남겨주세요.',
                    style: TextStyle(
                        // fontFamily: 'Gmarket',
                        fontSize: kPlainTextFontSize,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
        ),
        SafeArea(
          child: BottomFixedBtnDecoBox(
              child: (vm.requestController.text.isNotEmpty)
                  ? DefaultBtn(
                      text: '요청하기',
                      press: () {
                        vm.requestMajor(context);
                      },
                    )
                  : const DisabledDefaultBtn(text: '요청하기')),
        ),
      ],
    );
  }
}
