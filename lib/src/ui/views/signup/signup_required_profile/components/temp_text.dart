import 'package:flutter/material.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class TempText extends StatelessWidget {
  const TempText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenHeight(20),
          vertical: getProportionateScreenHeight(10)),
      child: Text(
        '관심사를 3개 이상 선택해주세요',
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 12, color: Colors.black87),
      ),
    );
  }
}
