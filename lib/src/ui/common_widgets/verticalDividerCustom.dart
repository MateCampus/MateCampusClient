//사용중

import 'package:flutter/material.dart';

class VerticalDividerCustom extends StatelessWidget {
  final double? thickness;
  final double? height;
  final Color? color;

  const VerticalDividerCustom(
      {Key? key, this.thickness, this.height, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: thickness ?? 1,
      height: height,
      color: color ?? Colors.grey.withOpacity(0.3),
    );
  }
}
