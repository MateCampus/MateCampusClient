import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/profile_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class InterestNoneChip extends StatelessWidget {
  final InterestPresentation interest;
  const InterestNoneChip({Key? key, required this.interest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(interest.title),
      labelStyle: TextStyle(
        fontSize: getProportionateScreenWidth(12),
        color: Colors.black.withOpacity(0.4),
        fontWeight: FontWeight.w600,
      ),
      backgroundColor: const Color(0xfff8f8f8),
      side: const BorderSide(color: Color(0xfff8f8f8), width: 1.2),
    );
  }
}
