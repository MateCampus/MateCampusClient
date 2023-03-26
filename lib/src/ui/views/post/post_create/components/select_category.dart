

import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/textstyle_constans.dart';
import 'package:zamongcampus/src/business_logic/models/enums/postCategoryCode.dart';
import 'package:zamongcampus/src/business_logic/utils/post_category_data.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_create_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';

class SelectCategory extends StatelessWidget {
  final PostCreateScreenViewModel vm;
  const SelectCategory({ Key? key, required this.vm }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<PostCategoryCode> categoryCodes = PostCategoryCode.values;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const VerticalSpacing(),
        Text(
          '카테고리',
          style: kLabelTextStyle,
        ),
        const VerticalSpacing(of: 5),
        Wrap(
          // runSpacing: getProportionateScreenHeight(0),
          alignment: WrapAlignment.start,
          spacing: getProportionateScreenWidth(8),
          children: [
            ...categoryCodes.map(
                (categoryCode) => _buildOutLinedButton(categoryCode.toString()))
          ],
        ),
      ],
    );
  }

   Widget _buildOutLinedButton(dynamic categoryCode) {
    // String iconValue = from == "voice"
    //     ? VoiceCategoryData.iconOf(categoryCode)
    //     : PostCategoryData.iconOf(categoryCode);
    String korNameValue = PostCategoryData.korNameOf(categoryCode);
    if (vm.categoryCodeList.contains(categoryCode.split('.').last)) {
      return OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(12),
              vertical: getProportionateScreenHeight(8)),
          minimumSize: Size.zero,
          backgroundColor: kMainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          side: BorderSide.none,
        ),
        onPressed: () {
          vm.changecategoryCodeList(categoryCode.toString());
        },
        child: Text(
          korNameValue,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: kInterestTextFontSize,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),

      );
    } else {
      return OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(12),
              vertical: getProportionateScreenHeight(8)),
          minimumSize: Size.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          side: BorderSide(
              width: getProportionateScreenWidth(1), color: Color(0xffe5e5ec)),
        ),
        onPressed: () {
          vm.changecategoryCodeList(categoryCode.toString());
        },
        child: Text(
          korNameValue,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: kInterestTextFontSize,
            color: Color(0xff111111),
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    }
  }
}