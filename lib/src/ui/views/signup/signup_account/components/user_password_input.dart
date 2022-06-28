import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/size_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';

class UserPasswordInput extends StatefulWidget {
  final SignUpViewModel vm;
  const UserPasswordInput({Key? key, required this.vm}) : super(key: key);

  @override
  _UserPasswordInputState createState() => _UserPasswordInputState();
}

class _UserPasswordInputState extends State<UserPasswordInput> {
  @override
  void initState() {
    super.initState();

    widget.vm.userPwController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '비밀번호',
          style: TextStyle(
              fontSize: kLabelFontSize,
              color: Colors.black54,
              fontWeight: FontWeight.w500),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
          child: TextFormField(
            //validation위해 textformfield 사용
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.next,
            style: TextStyle(fontSize: kLabelFontSize, color: Colors.black87),
            controller: widget.vm.userPwController,
            maxLines: 1,
            autovalidateMode:
                AutovalidateMode.onUserInteraction, //값이 들어오는 순간부터 자동 유효성 검사
            validator: (value) => widget.vm.pwValidator(value),
            autocorrect: false,
            obscureText: true,
            obscuringCharacter: '*',
            decoration: InputDecoration(
              prefixIcon: Icon(
                CupertinoIcons.lock_fill,
                color: kTextFieldHintColor,
                size: kTextFieldIconSizeCP,
              ),
              hintText: "비밀번호를 입력해주세요",
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
        ),
        const VerticalSpacing(of: 10),
        Text(
          '비밀번호 확인',
          style: TextStyle(
              fontSize: kLabelFontSize,
              color: Colors.black54,
              fontWeight: FontWeight.w500),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
          child: TextFormField(
            //validation위해 textformfield 사용
            keyboardType: TextInputType.multiline,

            style: TextStyle(fontSize: kLabelFontSize, color: Colors.black87),
            maxLines: 1,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => widget.vm.pwDoubleCheckValidator(value),
            autocorrect: false,
            obscureText: true,
            obscuringCharacter: '*',
            decoration: InputDecoration(
              prefixIcon: Icon(
                CupertinoIcons.lock_fill,
                color: kTextFieldHintColor,
                size: kTextFieldIconSizeCP,
              ),
              hintText: "비밀번호를 다시 입력해주세요",
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
        ),
      ],
    );
  }
}
