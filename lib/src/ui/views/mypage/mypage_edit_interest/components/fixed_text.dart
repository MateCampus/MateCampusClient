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
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenHeight(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           RichText(
                  text: TextSpan(
                      text: '관심사',
                      style: TextStyle(
                        fontSize: resizeFont(26),
                        fontWeight: FontWeight.w500,
                        color: kMainColor,
                      ),
                      children: [
                    TextSpan(
                        text: '를\n골라주세요',
                        style: TextStyle(
                            fontSize: resizeFont(26),
                            color: Color(0xff111111),
                            fontWeight: FontWeight.w500))
                  ])),
                  VerticalSpacing(of:5),
          Text(
            '최대 10개까지 선택할 수 있어요',
            style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: resizeFont(16),
                fontWeight: FontWeight.w500,
                color: kMainColor),
          )
        ],
      ),
    );
  }
}
