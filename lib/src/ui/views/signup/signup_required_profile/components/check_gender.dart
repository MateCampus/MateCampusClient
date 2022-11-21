import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/textstyle_constans.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';

class CheckGender extends StatelessWidget {
  final SignUpViewModel vm;
  const CheckGender({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '성별',
          style: kLabelTextStyle,
        ),
      ],
    );
  }
}
