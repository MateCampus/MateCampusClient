import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/textstyle_constans.dart';
import 'package:zamongcampus/src/business_logic/view_models/mypage_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/disabled_default_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';

class EditText extends StatefulWidget {
  final MypageViewModel vm;
  const EditText({
    Key? key,
    required this.vm,
  }) : super(key: key);

  @override
  _EditTextState createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  @override
  void initState() {
    super.initState();
    widget.vm.nicknameController.text = widget.vm.myInfo.nickname;
    widget.vm.introductionController.text = widget.vm.myInfo.introduction;

    widget.vm.nicknameController.addListener(() {
      widget.vm.updateNickname();
    });
    widget.vm.introductionController.addListener(() {
      widget.vm.updateIntroduction();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenHeight(20)),
      child: Form(
        key: widget.vm.nicknameFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '닉네임',
              style: kLabelTextStyle,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(10)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      autocorrect: false,
                      style: TextStyle(fontSize: kTextFieldInnerFontSize),
                      controller: widget.vm.nicknameController,
                      maxLines: 1,
                      validator: (value) => widget.vm.nicknameValidator(value),
                      decoration: InputDecoration(
                        hintText: "닉네임",
                        hintStyle: TextStyle(
                            color: const Color(0xFF999999),
                            fontSize: kTextFieldInnerFontSize),
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Color(0xffe5e5ec)),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Color(0xffe5e5ec)),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        contentPadding:
                            EdgeInsets.all(getProportionateScreenHeight(10)),
                        border: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Color(0xffe5e5ec)),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          left: getProportionateScreenWidth(10)),
                      child: (widget.vm.nicknameController.text ==
                              widget.vm.myInfo.nickname)
                          ? DisabledDefaultBtn(
                              text: '변경',
                              width: getProportionateScreenWidth(60),
                              height: getProportionateScreenHeight(43),
                            )
                          : DefaultBtn(
                              text: '변경',
                              press: () {
                                //닉네임 중복확인 및 유효성 검사
                                widget.vm.checkNicknameRedundancy();
                              },
                              width: getProportionateScreenWidth(60),
                              height: getProportionateScreenHeight(43),
                            ))
                ],
              ),
            ),
            const VerticalSpacing(of: 15),
            Text(
              '자기 소개',
              style: kLabelTextStyle,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(10)),
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                style: TextStyle(fontSize: kTextFieldInnerFontSize),
                controller: widget.vm.introductionController,
                maxLines: 7,
                maxLength: 150,
                decoration: InputDecoration(
                  hintText: "본인을 자유롭게 표현해주세요",
                  hintStyle: TextStyle(
                      color: const Color(0xFF999999),
                      fontSize: kTextFieldInnerFontSize),
                  contentPadding:
                      EdgeInsets.all(getProportionateScreenHeight(10)),
                  enabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: Color(0xffe5e5ec)),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: Color(0xffe5e5ec)),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  border: const OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: Color(0xffe5e5ec)),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
