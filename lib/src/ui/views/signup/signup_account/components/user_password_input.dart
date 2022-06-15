import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
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
          style: TextStyle(fontSize: kLabelFontSize, color: Colors.black87),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
          child: TextFormField(
            //validation위해 textformfield 사용
            keyboardType: TextInputType.multiline,
            style: TextStyle(fontSize: kTextFieldInnerFontSize),
            controller: widget.vm.userPwController,
            maxLines: 1,
            autovalidateMode:
                AutovalidateMode.onUserInteraction, //값이 들어오는 순간부터 자동 유효성 검사
            validator: (value) => widget.vm.pwValidator(value),
            autocorrect: false,
            obscureText: true,
            obscuringCharacter: '*',
            decoration: InputDecoration(
              hintText: "비밀번호를 입력해주세요",
              hintStyle: const TextStyle(
                color: Color(0xFFADADAD),
                fontSize: 14,
              ),
              fillColor: kTextFieldColor,
              filled: true,
              contentPadding: EdgeInsets.all(getProportionateScreenHeight(10)),
              border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
            ),
          ),
        ),
        const VerticalSpacing(of: 10),
        Text(
          '비밀번호 확인',
          style: TextStyle(fontSize: kLabelFontSize, color: Colors.black87),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
          child: TextFormField(
            //validation위해 textformfield 사용
            keyboardType: TextInputType.multiline,
            style: TextStyle(fontSize: kTextFieldInnerFontSize),
            maxLines: 1,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => widget.vm.pwDoubleCheckValidator(value),
            autocorrect: false,
            obscureText: true,
            obscuringCharacter: '*',
            decoration: InputDecoration(
              hintText: "비밀번호를 다시 입력해주세요",
              hintStyle: TextStyle(
                  color: Color(0xFFADADAD), fontSize: kTextFieldInnerFontSize),
              fillColor: kTextFieldColor,
              filled: true,
              contentPadding: EdgeInsets.all(getProportionateScreenHeight(10)),
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
