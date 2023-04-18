import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/textstyle_constans.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';

class StudentNumberInput extends StatelessWidget {
  final SignUpViewModel vm;
  const StudentNumberInput({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '학번',
          style: kLabelTextStyle,
        ),
        TextFormField(
          controller: vm.userStudentNumberController,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
          style: TextStyle(
            fontSize: kTextFieldInnerFontSize,
          ),
          // controller: widget.vm.userNicknameController,
          maxLines: 1,
          maxLength: 2,
          autocorrect: false,
          decoration: InputDecoration(
            hintText: "(예: 23학번이면 23)",
            hintStyle: TextStyle(
                color: const Color(0xFF999999),
                fontSize: kTextFieldInnerFontSize),
          ),
        ),
      ],
    );
  }
}
