//일단은 사용중

import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';

import 'vertical_spacing.dart';

class CenterSentence extends StatelessWidget {
  final String sentence;
  final double? topSpace;
  final double? bottomSpace;
  const CenterSentence(
      {Key? key, required this.sentence, this.topSpace, this.bottomSpace})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          VerticalSpacing(of: topSpace ?? 0),
          Center(
            child: Text(
              sentence,
              style: TextStyle(
                  color: Colors.black54, fontSize: kPlainTextFontSize),
            ),
          ),
          VerticalSpacing(of: bottomSpace ?? 0),
        ]);
  }
}
