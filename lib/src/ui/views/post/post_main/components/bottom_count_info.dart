import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/arguments/post_detail_screen_args.dart';
import 'package:zamongcampus/src/business_logic/arguments/post_liked_list_screen_args.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/size_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontal_spacing.dart';
import 'package:zamongcampus/src/ui/views/post/post_detail/post_detail_screen.dart';
import 'package:zamongcampus/src/ui/views/post/post_liked_list/post_liked_list_screen.dart';

class BottomCountInfo extends StatelessWidget {
  final dynamic vm;
  final PostPresentation post;
  const BottomCountInfo({Key? key, required this.vm, required this.post})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(10),
          vertical: getProportionateScreenHeight(0)),
      child: Row(
        children: [
          _likePostBtn(context),
          // const HorizontalSpacing(of: 15),
          _commentBtn(context),
          const Spacer(),
          _likedListBtn(context)
        ],
      ),
    );
  }

  Widget _likePostBtn(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        vm.likePost(post);
      },
      icon: post.isLiked
          ? Icon(
              CupertinoIcons.heart_fill,
              size: kPostIconSizeCP,
              color: kMainColor,
            )
          : Icon(
              CupertinoIcons.heart,
              size: kPostIconSizeCP,
              color: kPostBtnColor,
            ),
      label: Text(
        post.likedCount,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: kPostBtnColor,
          fontSize: kPostIconFontSize,
        ),
      ),
      style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
    );
  }

  Widget _commentBtn(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        Navigator.pushNamed(context, PostDetailScreen.routeName,
            arguments: PostDetailScreenArgs(post.id));
      },
      icon: Icon(
        CupertinoIcons.bubble_left,
        size: kPostIconSizeCP,
        color: kPostBtnColor,
      ),
      label: Text(
        post.commentCount,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: kPostBtnColor,
          fontSize: kPostIconFontSize,
        ),
      ),
      style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
    );
  }

  Widget _likedListBtn(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, PostLikedListScreen.routeName,
            arguments: PostLikedListScreenArgs(post.id));
      },
      child: Row(
        children: [
          Text(
            '좋아요',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kPostBtnColor,
              fontSize: resizeFont(13),
            ),
          ),
          Icon(
            CupertinoIcons.chevron_forward,
            size: getProportionateScreenWidth(18),
            color: kPostBtnColor,
          )
        ],
      ),
      style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
    );
  }
}
