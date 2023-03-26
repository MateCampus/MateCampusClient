import 'package:flutter/material.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class UnselectedInterestChip extends StatelessWidget {
  final String interestTitle;
  const UnselectedInterestChip({ Key? key , required this.interestTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      // padding: EdgeInsets.zero,
      // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      // visualDensity: const VisualDensity(vertical: -2),
      label: Text(interestTitle),
      labelStyle: TextStyle(
        fontSize: resizeFont(14),
        color: Colors.black87,
        fontWeight: FontWeight.w400,
      ),
      backgroundColor: Colors.white,
      // side:  BorderSide(color: Color(0xffe5e5ec), width: 1.2),

      side:  BorderSide(color: Colors.grey.withOpacity(0.3), width: 1.2),

    );
  }
}