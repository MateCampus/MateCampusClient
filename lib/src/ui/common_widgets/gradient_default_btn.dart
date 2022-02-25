import 'package:flutter/material.dart';

import '../../business_logic/utils/constants.dart';
import '../../config/size_config.dart';

class GradientDefaultBtn extends StatelessWidget {
  const GradientDefaultBtn(
      {Key? key,
      required this.title,
      required this.press,
      this.width,
      this.height})
      : super(key: key);

  final String title;
  final double? width;
  final double? height;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      //textbutton의 크기는 컨테이너로 감싼 후 지정한다
      width: width ?? getProportionateScreenWidth(360),
      height: height ?? getProportionateScreenHeight(40),
      decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [mainColor, subColor]),
          borderRadius: BorderRadius.circular(5)),
      child: TextButton(
        onPressed: press,
        style: TextButton.styleFrom(
            primary: const Color(0xffFFFFFF), //버튼 안의 text색
            textStyle: TextStyle(
                //버튼안의 텍스트 스타일 지정
                fontSize: getProportionateScreenWidth(16),
                fontFamily: "SCDream5",
                letterSpacing: getProportionateScreenWidth(2))),
        child: Text(
          title,
        ),
      ),
    );
  }
}
