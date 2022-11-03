import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/arguments/post_liked_list_screen_args.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/size_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontal_spacing.dart';
import 'package:zamongcampus/src/ui/views/post/post_liked_list/post_liked_list_screen.dart';

class BottomCountInfo extends StatelessWidget {
  final PostPresentation post;
  const BottomCountInfo({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenHeight(12)),
      child: Row(
        children: [
          _likePostBtn(),
          const HorizontalSpacing(of: 15),
          _commentBtn(),
          const Spacer(),
          _likedListBtn(context)
        ],
      ),
    );
  }

  Widget _likePostBtn() {
    return InkWell(
      onTap: () {},
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
          )
        ],
      ),
    );
  }

  Widget _commentBtn() {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
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
        ],
      ),
    );
  }

  Widget _likedListBtn(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, PostLikedListScreen.routeName,
            arguments: PostLikedListScreenArgs(post.id));
      },
      child: Row(
        children: [
          Text(
            '좋아요\t' + post.likedCount,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kPostBtnColor,
              fontSize: resizeFont(13),
            ),
          ),
          Icon(
            CupertinoIcons.chevron_right,
            size: getProportionateScreenWidth(13),
            color: kPostBtnColor,
          )
        ],
      ),
    );
  }
}
