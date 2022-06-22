import 'package:flutter/material.dart';

import 'package:zamongcampus/src/config/size_config.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            margin:
                EdgeInsets.symmetric(vertical: getProportionateScreenHeight(8)),
            height: getProportionateScreenHeight(4),
            width: getProportionateScreenWidth(36),
            decoration: const BoxDecoration(
                color: Color(0xffe2e2e2),
                borderRadius: BorderRadius.all(Radius.circular(20))),
          ),
        ),
        Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_horiz,
                color: const Color(0xffe2e2e2),
                size: getProportionateScreenWidth(30),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              splashRadius: getProportionateScreenWidth(20),
              constraints: const BoxConstraints(),
            ))
      ],
    );
  }
}
