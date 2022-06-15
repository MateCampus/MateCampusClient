import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/profile_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class InterestSameChip extends StatelessWidget {
  final InterestPresentation interest;
  const InterestSameChip({Key? key, required this.interest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.topRight, children: [
      Chip(
        label: Text(interest.title),
        labelStyle: TextStyle(
          fontSize: getProportionateScreenWidth(12),
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: Colors.white,
        side: const BorderSide(color: mainColor, width: 1.2),
      ),
      Container(
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: Icon(
            Icons.check_circle,
            color: mainColor,
            size: getProportionateScreenHeight(16),
          ))
    ]);
  }
}
