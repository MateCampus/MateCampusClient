import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/size_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/textstyle_constans.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class NicknameInput extends StatefulWidget {
  final SignUpViewModel vm;
  const NicknameInput({Key? key, required this.vm}) : super(key: key);

  @override
  _NicknameInputState createState() => _NicknameInputState();
}

class _NicknameInputState extends State<NicknameInput> {
  @override
  void initState() {
    super.initState();

    widget.vm.userNicknameController.addListener(() {});
  }

  // @override
  // void dispose() {
  //   widget.vm.titleController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.vm.userNicknameFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('닉네임', style: kLabelTextStyle),

          TextFormField(
            //validation위해 textformfield 사용
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.next,
            // onFieldSubmitted: (value) {
            //   widget.vm.nicknameValidator(context, value);
            // },
            style: TextStyle(
              fontSize: kTextFieldInnerFontSize,
            ),
            controller: widget.vm.userNicknameController,
            maxLines: 1,
            maxLength: 8,
            validator: (value) => widget.vm.nicknameValidator(context, value),
            autocorrect: false,
            decoration: InputDecoration(
              hintText: "닉네임를 입력해주세요",
              hintStyle: TextStyle(
                  color: const Color(0xFF999999),
                  fontSize: kTextFieldInnerFontSize),
            ),
          ),
          // const Spacer(),
          // Padding(
          //   padding: EdgeInsets.all(getProportionateScreenWidth(6)),
          //   child: TextButton(
          //     onPressed: () {
          //       widget.vm.checkNicknameRedundancy(); //닉네임 중복확인 및 유효성 검사
          //     },
          //     child: const Text('중복 확인'),
          //     style: TextButton.styleFrom(
          //       backgroundColor: kMainColor,
          //       primary: Colors.white,
          //       textStyle: TextStyle(fontSize: kTextFieldInnerFontSize),
          //       minimumSize: Size(getProportionateScreenWidth(55),
          //           getProportionateScreenHeight(40)),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
