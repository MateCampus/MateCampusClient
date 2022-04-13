import 'package:flutter/material.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class TagCategory extends StatelessWidget {
  const TagCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          right: getProportionateScreenWidth(20),
          left: getProportionateScreenWidth(20)),
      child: TextButton(
        onPressed: () {},
        child: const Text(
          '관심사 추가 +',
          style: TextStyle(fontSize: 12),
        ),
        style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: const Color(0xffff6f5e),
            shape: const StadiumBorder(),
            minimumSize: const Size(58, 17)),
      ),
    );
  }
}
