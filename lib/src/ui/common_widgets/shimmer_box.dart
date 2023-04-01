import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';

class ShimmerBox extends StatefulWidget {
  final double? width;
  final double? height;
  final BoxShape? boxShape;
  const ShimmerBox({Key? key, this.width, this.height, this.boxShape})
      : super(key: key);

  @override
  State<ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<ShimmerBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height ?? double.infinity,
      decoration: (widget.boxShape == null)
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(5), gradient: shimmerGradient)
          : const BoxDecoration(
              shape: BoxShape.circle, gradient: shimmerGradient),
    );
  }
}
