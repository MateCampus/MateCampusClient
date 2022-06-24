import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_detail_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontalDividerCustom.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontal_spacing.dart';

class MyCommentListTile extends StatelessWidget {
  final CommentPresentation comment;
  const MyCommentListTile({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenHeight(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      comment.userNickname,
                      style: TextStyle(
                          color: kMainColor,
                          fontSize: getProportionateScreenHeight(13),
                          fontWeight: FontWeight.bold),
                    ),
                    const HorizontalSpacing(of: 8),
                    Text(
                      comment.createdAt,
                      style: TextStyle(
                          fontSize: kCreateAtFontSize,
                          color: kPostBtnColor,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenHeight(7)),
                  child: Text(
                    comment.body,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: getProportionateScreenHeight(13),
                        height: 1.3),
                  ),
                ),
              ],
            )),
        const HorizontalDividerCustom(color: kMainScreenBackgroundColor)
      ],
    );
  }
}
