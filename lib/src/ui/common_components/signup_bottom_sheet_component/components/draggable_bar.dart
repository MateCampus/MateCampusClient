import 'package:flutter/material.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class DraggableBar extends StatelessWidget {
  const DraggableBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //상단의 회색 바. 그런데 이게 있는 순간 드래그가 되야할것 같은데 사실 굳이 드래그가 필요 없는 곳에서는 없어도 되지 않을까? 밑으로 내리는 것도 사실 드래그니까 놔둬야하나?
      margin: EdgeInsets.only(top: getProportionateScreenHeight(8)),
      height: getProportionateScreenHeight(4),
      width: getProportionateScreenWidth(36),
      decoration: const BoxDecoration(
          color: Color(0xffe2e2e2),
          borderRadius: BorderRadius.all(Radius.circular(20))),
    );
  }
}
