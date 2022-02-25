import 'package:flutter/material.dart';

import '../../business_logic/utils/constants.dart';

class OutlineChip extends StatelessWidget {
  final String text;
  final Color lineColor;
  final Color textColor;

  const OutlineChip(
      {Key? key,
      required this.text,
      required this.lineColor,
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(right: kDefaultPadding / 2),
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding / 2,
        vertical: kDefaultPadding / 4, // 5 padding top and bottom
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          border: Border.all(width: 1, color: Colors.grey),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)]),
      child: Text(
        text,
        style: const TextStyle(color: Colors.grey, fontSize: 13),
      ),
    );
  }
}
