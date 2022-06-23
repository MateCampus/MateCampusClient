import 'package:flutter/cupertino.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/size_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontal_spacing.dart';

class BottomCountInfo extends StatelessWidget {
  final PostPresentation post;
  const BottomCountInfo({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(13),
          vertical: getProportionateScreenHeight(15)),
      child: Row(
        children: [
          Icon(
            CupertinoIcons.heart,
            size: kPostMainIconSizeCP,
            color: kPostBtnColor,
          ),
          const HorizontalSpacing(of: 5),
          Text(
            post.likedCount,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kPostBtnColor,
              fontSize: resizeFont(13),
            ),
          ),
          const HorizontalSpacing(of: 15),
          Icon(
            CupertinoIcons.bubble_left,
            size: kPostMainIconSizeCP,
            color: kPostBtnColor,
          ),
          const HorizontalSpacing(of: 5),
          Text(
            post.commentCount,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kPostBtnColor,
              fontSize: resizeFont(13),
            ),
          ),
          const HorizontalSpacing(of: 15),
          Icon(
            CupertinoIcons.eye,
            size: kPostMainIconSizeCP,
            color: kPostBtnColor,
          ),
          const HorizontalSpacing(of: 5),
          Text(
            post.viewCount,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kPostBtnColor,
              fontSize: resizeFont(13),
            ),
          ),
          const Spacer(),
          Text(
            post.createdAt,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: kPostBtnColor,
                fontSize: kCreateAtFontSize,
                fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }
}
