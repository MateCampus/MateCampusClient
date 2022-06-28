import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';

class MiddleText extends StatelessWidget {
  const MiddleText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenHeight(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('어떤 것을 좋아하나요?',
              style: TextStyle(
                  // fontFamily: 'Gmarket',
                  fontSize: kTitleFontSize,
                  fontWeight: FontWeight.w700)),
          const VerticalSpacing(of: 2),
          Text(
            '관심사를 3개 이상 골라주세요!',
            style: TextStyle(
                // fontFamily: 'Gmarket',
                fontSize: kPlainTextFontSize,
                fontWeight: FontWeight.w400,
                color: kMainColor),
          )
        ],
      ),
    );
  }
}
