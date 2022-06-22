import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/models/enums/postCategoryCode.dart';
import 'package:zamongcampus/src/business_logic/models/enums/voiceCategoryCode.dart';
import 'package:zamongcampus/src/business_logic/utils/post_category_data.dart';
import 'package:zamongcampus/src/business_logic/utils/voice_category_data.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_create_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';

import '../../../../../business_logic/constants/font_constants.dart';

class CategorySelectLine extends StatelessWidget {
  dynamic vm;
  String from;
  CategorySelectLine({
    Key? key,
    required this.vm,
    required this.from,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> categoryCodes =
        from == "voice" ? VoiceCategoryCode.values : PostCategoryCode.values;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const VerticalSpacing(),
        Text(
          '카테고리',
          style: TextStyle(fontSize: kLabelFontSize, color: Colors.black87),
        ),
        const VerticalSpacing(of: 10),
        Wrap(
          runSpacing: getProportionateScreenHeight(2),
          alignment: WrapAlignment.start,
          spacing: getProportionateScreenWidth(5),
          children: [
            ...categoryCodes.map(
                (categoryCode) => buildOutLinedButton(categoryCode.toString()))
          ],
        ),
      ],
    );
  }

  Widget buildOutLinedButton(dynamic categoryCode) {
    String iconValue = from == "voice"
        ? VoiceCategoryData.iconOf(categoryCode)
        : PostCategoryData.iconOf(categoryCode);
    String korNameValue = from == "voice"
        ? VoiceCategoryData.korNameOf(categoryCode)
        : PostCategoryData.korNameOf(categoryCode);
    if (vm.categoryCodeList.contains(categoryCode.split('.').last)) {
      return Stack(alignment: Alignment.topRight, children: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
            minimumSize: Size.zero,
            // backgroundColor: kMainColor.withOpacity(0.05),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            side: BorderSide(width: 1.8, color: kMainColor),
          ),
          onPressed: () {
            vm.changecategoryCodeList(categoryCode.toString());
          },
          child: Text(
            iconValue + " " + korNameValue,
            style: TextStyle(
              fontSize: kInterestTextFontSize,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.white),
            child: Icon(
              Icons.check_circle,
              color: kMainColor,
              size: getProportionateScreenHeight(16),
            ))
      ]);
    } else {
      return OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
          minimumSize: Size.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          side: BorderSide(width: 1, color: Colors.black.withOpacity(0.2)),
        ),
        onPressed: () {
          vm.changecategoryCodeList(categoryCode.toString());
        },
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.end,
          children: [
            Text(
              iconValue,
              style: TextStyle(
                fontSize: kInterestTextFontSize,
              ),
            ),
            Text(
              " ",
              style: TextStyle(
                fontSize: kInterestTextFontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              korNameValue,
              style: TextStyle(
                fontSize: kInterestTextFontSize,
                color: Colors.black.withOpacity(0.4),
              ),
            ),
          ],
        ),
      );
    }
  }
}
