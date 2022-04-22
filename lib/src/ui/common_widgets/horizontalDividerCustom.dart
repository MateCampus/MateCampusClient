//사용중
import 'package:flutter/material.dart';

class HorizontalDividerCustom extends StatelessWidget {
  final double? thickness;
  final double? width;
  final Color? color;

  const HorizontalDividerCustom(
      {Key? key, this.thickness, this.width, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: thickness ?? 1,
      width: width,
      color: color ?? Colors.grey.withOpacity(0.3),
    );
  }
}
