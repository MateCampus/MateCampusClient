import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/textstyle_constans.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontal_spacing.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';

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
        const VerticalSpacing(of: 10),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _genderRadioBtn(vm.genderList[0], 0),
            HorizontalSpacing(
              of: 10,
            ),
            _genderRadioBtn(vm.genderList[1], 1),
          ],
        )
      ],
    );
  }

  Widget _genderRadioBtn(String title, int index) {
    return ElevatedButton(
      onPressed: () {
        vm.changeGenderIndex(index);
      },
      child: Text(
        title,
        style: TextStyle(
            fontSize: resizeFont(12),
            color: vm.genderIndex == index ? Colors.white : Colors.grey),
      ),
      style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: vm.genderIndex == index ? kMainColor : Colors.white,
          foregroundColor: kMainColor,
          fixedSize: Size(getProportionateScreenWidth(50),
              getProportionateScreenHeight(20)),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(200.0)),
          side: BorderSide(
              color: vm.genderIndex == index ? kMainColor : Color(0xffE5E5EC))),
    );
  }
}
