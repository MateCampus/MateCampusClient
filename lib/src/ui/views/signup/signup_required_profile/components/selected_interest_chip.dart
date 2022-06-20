import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class SelectedInterestChip extends StatelessWidget {
  final String icon;
  const SelectedInterestChip({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        margin: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(7)),
        width: getProportionateScreenWidth(60),
        height: getProportionateScreenHeight(60),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                color: kMainColor, width: 2.5, style: BorderStyle.solid)),
        child: Center(
          child: Text(
            icon,
            style: TextStyle(fontSize: getProportionateScreenWidth(30)),
          ),
        ),
      ),
      Positioned(
        bottom: 7,
        right: -1,
        child: Container(
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.white),
            child: Icon(
              Icons.check_circle,
              color: kMainColor,
              size: getProportionateScreenHeight(20),
            )),
      )
    ]);
  }
}
