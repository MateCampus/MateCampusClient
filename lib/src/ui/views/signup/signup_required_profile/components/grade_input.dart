import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/textstyle_constans.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';

class GradeInput extends StatefulWidget {
  final SignUpViewModel vm;
  const GradeInput({Key? key, required this.vm}) : super(key: key);

  @override
  _GradeInputState createState() => _GradeInputState();
}

class _GradeInputState extends State<GradeInput> {
  @override
  void initState() {
    super.initState();

    widget.vm.userGradeController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '학년',
          style: kLabelTextStyle,
        ),
        TextFormField(
          //validation위해 textformfield 사용
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.next,
          style: TextStyle(fontSize: kLabelFontSize),
          controller: widget.vm.userGradeController,
          maxLines: 1,

          autocorrect: false,
          decoration: InputDecoration(
            hintText: "학년을 입력해주세요.(ex. 1학년)",
            hintStyle: TextStyle(
                color: const Color(0xFF999999),
                fontSize: kTextFieldInnerFontSize),
          ),
        ),
      ],
    );
  }
}
