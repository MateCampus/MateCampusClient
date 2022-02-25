import 'package:flutter/material.dart';

class VerticalDividerCustom extends StatelessWidget {
  const VerticalDividerCustom({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 1,
      height: height ?? 10,
      color: Colors.grey,
    );
  }
}
