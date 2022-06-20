import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';

class FixedText extends StatelessWidget {
  const FixedText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(30),
          vertical: getProportionateScreenHeight(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('어떤 것을 좋아하세요?',
              style: TextStyle(
                  fontFamily: 'Gmarket',
                  fontSize: kTitleFontSize,
                  fontWeight: FontWeight.w700)),
          const VerticalSpacing(of: 3),
          Text(
            '관심사는 10개까지 선택할 수 있어요',
            style: TextStyle(
                fontFamily: 'Gmarket',
                fontSize: kPlainTextFontSize,
                fontWeight: FontWeight.w500,
                color: kMainColor),
          )
        ],
      ),
    );
  }
}
