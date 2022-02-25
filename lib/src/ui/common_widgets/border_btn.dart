import 'package:flutter/material.dart';

import '../../config/size_config.dart';

class BorderBtn extends StatelessWidget {
  const BorderBtn({Key? key, required this.title, required this.press})
      : super(key: key);

  final String title;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(240),
      height: getProportionateScreenHeight(45),
      child: TextButton(
        onPressed: () {
          press;
        },
        style: TextButton.styleFrom(
          primary: Color(0xffFFF2EA),
          shape: //테두리를 둥글게
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          side: BorderSide(
              color: Color(0xffFFF2EA), width: getProportionateScreenWidth(2)),
          textStyle: TextStyle(
              //버튼안의 텍스트 스타일 지정
              fontSize: getProportionateScreenWidth(16),
              fontWeight: FontWeight.bold,
              letterSpacing: getProportionateScreenWidth(2)),
        ),
        child: Text(
          title,
        ),
      ),
    );
  }
}
