import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';

class ReportTileText extends StatelessWidget {
  const ReportTileText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: getProportionateScreenWidth(5),
          bottom: getProportionateScreenHeight(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '\u{1F6A8} 신고 사유 선택',
            style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: kTitleFontSize),
          ),
          const VerticalSpacing(of: 5),
          Text(
            '정확한 사유 1개를 선택해주세요.',
            style: TextStyle(
                fontSize: resizeFont(12), color: Colors.black.withOpacity(0.6)),
          ),
        ],
      ),
    );
  }
}
