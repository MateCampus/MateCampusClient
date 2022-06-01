//하단에 고정되는 버튼의 쉐도우 효과를 위한 위젯

import 'package:flutter/material.dart';

class DefaultShadowBox extends StatelessWidget {
  final Widget child;
  Color? backgroundColor;

  DefaultShadowBox({Key? key, required this.child, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 0.5,
          )
        ],
      ),
      child: child,
    );
  }
}
