import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/mypage_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/disabled_default_btn.dart';

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
            const Text(
              '내 소개',
              style: TextStyle(fontSize: 12, color: Colors.black87),
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
                      style: const TextStyle(fontSize: 14),
                      controller: widget.vm.nicknameController,
                      maxLines: 1,
                      validator: (value) => widget.vm.nicknameValidator(value),
                      decoration: InputDecoration(
                        hintText: "닉네임",
                        hintStyle: const TextStyle(
                            color: Color(0xFFADADAD), fontSize: 14),
                        fillColor: const Color(0xfff8f8f8),
                        filled: true,
                        contentPadding:
                            EdgeInsets.all(getProportionateScreenHeight(10)),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
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
            TextFormField(
              keyboardType: TextInputType.multiline,
              style: const TextStyle(fontSize: 14),
              controller: widget.vm.introductionController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "본인을 자유롭게 표현해주세요",
                hintStyle:
                    const TextStyle(color: Color(0xFFADADAD), fontSize: 14),
                fillColor: const Color(0xfff8f8f8),
                filled: true,
                contentPadding:
                    EdgeInsets.all(getProportionateScreenHeight(10)),
                border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
