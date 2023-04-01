import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/textstyle_constans.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';

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
        const VerticalSpacing(of: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _gradeRadioBtn(widget.vm.gradeList[0], 1),
            _gradeRadioBtn(widget.vm.gradeList[1], 2),
            _gradeRadioBtn(widget.vm.gradeList[2], 3),
            _gradeRadioBtn(widget.vm.gradeList[3], 4),
            _gradeRadioBtn(widget.vm.gradeList[4], 5)
          ],
        )
      ],
    );
  }

  Widget _gradeRadioBtn(String title, int index) {
    return ElevatedButton(
      onPressed: () {
        FocusScope.of(context).unfocus();
        widget.vm.changeGradeIndex(index);
      },
      child: Text(
        title,
        style: TextStyle(
            fontSize: resizeFont(12),
            color: widget.vm.gradeIndex == index ? Colors.white : Colors.grey),
      ),
      style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor:
              widget.vm.gradeIndex == index ? kMainColor : Colors.white,
          foregroundColor: kMainColor,
          fixedSize: Size(getProportionateScreenWidth(60),
              getProportionateScreenHeight(20)),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(200.0)),
          side: BorderSide(
              color: widget.vm.gradeIndex == index
                  ? kMainColor
                  : Color(0xffE5E5EC))),
    );
  }
}
