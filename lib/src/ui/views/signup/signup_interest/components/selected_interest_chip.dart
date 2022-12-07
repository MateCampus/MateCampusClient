import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class SelectedInterestChip extends StatelessWidget {
  final String interestTitle;
  const SelectedInterestChip({ Key? key, required this.interestTitle }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      // padding: EdgeInsets.zero,
      // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      // visualDensity: const VisualDensity(vertical: -2),
      label: Text(interestTitle),
      labelStyle: TextStyle(
        fontSize: resizeFont(14),
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
      backgroundColor: kMainColor,
      side: const BorderSide(color: kMainColor, width: 1.2),
    );
}}