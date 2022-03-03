import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class Logo extends StatelessWidget {
  final double height;
  const Logo({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(height),
      alignment: Alignment.center,
      child: Text(
        "자몽캠퍼스",
        style: TextStyle(
          fontSize: getProportionateScreenWidth(45),
          letterSpacing: 5,
          foreground: Paint()
            ..shader = const LinearGradient(colors: [
              kPrimaryColor,
              kSecondaryColor,
            ]).createShader(Rect.fromLTWH(0.0, 0.0, 300.0, 170.0)),
          shadows: const <Shadow>[
            Shadow(
              offset: Offset(1.0, 1.0),
              blurRadius: 3.0,
              color: kSecondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
