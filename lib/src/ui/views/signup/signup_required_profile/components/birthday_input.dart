import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/textstyle_constans.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';

class BirthdayInput extends StatefulWidget {
  final SignUpViewModel vm;
  const BirthdayInput({Key? key, required this.vm}) : super(key: key);

  @override
  _BirthdayInputState createState() => _BirthdayInputState();
}

class _BirthdayInputState extends State<BirthdayInput> {
  @override
  void initState() {
    super.initState();

    widget.vm.userBirthDayController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '생년월일',
          style: kLabelTextStyle,
        ),
        TextFormField(
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.next,
          style: TextStyle(fontSize: kLabelFontSize),
          controller: widget.vm.userBirthDayController,
          maxLines: 1,
          autocorrect: false,
          decoration: InputDecoration(
            hintText: "EX) 2002-03-21",
            hintStyle: TextStyle(
                color: const Color(0xFF999999),
                fontSize: kTextFieldInnerFontSize),
          ),
        ),
      ],
    );
  }
}
