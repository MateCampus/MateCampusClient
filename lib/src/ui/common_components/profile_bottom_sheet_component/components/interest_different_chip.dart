import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/profile_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class InterestDifferentChip extends StatelessWidget {
  final InterestPresentation interest;
  const InterestDifferentChip({Key? key, required this.interest})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.topRight, children: [
      Chip(
        label: Text(interest.title),
        labelStyle: TextStyle(
          fontSize: getProportionateScreenWidth(12),
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: Colors.white,
        side: const BorderSide(color: Color(0xffe2e2e2), width: 1.2),
      ),
      Container(
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: Icon(
            Icons.check_circle,
            color: const Color(0xffe2e2e2),
            size: getProportionateScreenHeight(16),
          ))
    ]);
  }
}
