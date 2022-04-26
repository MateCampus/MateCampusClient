import 'package:flutter/material.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: getProportionateScreenHeight(3),
      alignment: WrapAlignment.center,
      spacing: getProportionateScreenWidth(5),
      children: [],
    );
  }
}
