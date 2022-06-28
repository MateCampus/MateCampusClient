import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';

class GreetingText extends StatelessWidget {
  const GreetingText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(25)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '\u{1F34A}',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: getProportionateScreenHeight(30)),
          ),
          const VerticalSpacing(of: 10),
          Text('자몽캠퍼스에 오신것을 환영해요 :)',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: kTitleFontSize, fontWeight: FontWeight.w500))
        ],
      ),
    );
  }
}
