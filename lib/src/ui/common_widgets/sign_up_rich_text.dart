import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class SignUpRichText extends StatelessWidget {
  final String colorText;
  final String postPositionText;
  const SignUpRichText(
      {Key? key, required this.colorText, required this.postPositionText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: colorText,
            style: TextStyle(
              fontSize: resizeFont(26),
              fontWeight: FontWeight.w500,
              color: kMainColor,
            ),
            children: [
          TextSpan(
              text: '$postPositionText\n입력해주세요',
              style: TextStyle(
                  fontSize: resizeFont(26),
                  color: Color(0xff111111),
                  fontWeight: FontWeight.w500))
        ]));
  }
}
