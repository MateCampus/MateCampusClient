import 'package:flutter/material.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class UnselectedInterestChip extends StatelessWidget {
  final String icon;
  const UnselectedInterestChip({Key? key, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(7)),
      width: getProportionateScreenWidth(60),
      height: getProportionateScreenHeight(60),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color: Colors.black.withOpacity(0.1),
              width: 2.5,
              style: BorderStyle.solid)),
      child: Center(
        child: Text(
          icon,
          style: const TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
