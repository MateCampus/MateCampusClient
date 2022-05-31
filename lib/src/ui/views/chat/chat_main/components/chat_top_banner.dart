import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class ChatTopBanner extends StatelessWidget {
  const ChatTopBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenHeight(10)),
      child: Container(
        height: getProportionateScreenHeight(80),
        width: getProportionateScreenWidth(335),
        child: Image.asset(
          'assets/images/temp/zamongad.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
