import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/config/size_config.dart';

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
        children: const [
          Text('어떤 것을 좋아하세요?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          Text(
            '관심사는 10개까지 선택할 수 있어요',
            style: TextStyle(fontSize: 13, color: mainColor),
          )
        ],
      ),
    );
  }
}
