import 'package:flutter/material.dart';

import '../../config/size_config.dart';

class FilledBtn extends StatelessWidget {
  const FilledBtn({Key? key, required this.title, required this.press})
      : super(key: key);

  final String title;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      //textbutton의 크기는 컨테이너로 감싼 후 지정한다
      width: getProportionateScreenWidth(240),
      height: getProportionateScreenHeight(45),
      child: TextButton(
        onPressed: press,
        style: TextButton.styleFrom(
            backgroundColor: const Color(0xffFFF2EA),
            primary: const Color(0xff565656), //버튼 안의 text색
            shape: //테두리를 둥글게
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            textStyle: TextStyle(
                //버튼안의 텍스트 스타일 지정
                fontSize: getProportionateScreenWidth(16),
                fontWeight: FontWeight.bold,
                letterSpacing: getProportionateScreenWidth(2))),
        child: Text(
          title,
        ),
      ),
    );
  }
}
