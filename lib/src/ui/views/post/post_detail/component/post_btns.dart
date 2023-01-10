import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/arguments/post_liked_list_screen_args.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/size_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_detail_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontal_spacing.dart';
import 'package:zamongcampus/src/ui/views/post/post_liked_list/post_liked_list_screen.dart';

class PostBtns extends StatefulWidget {
  final PostDetailScreenViewModel vm;
  const PostBtns({Key? key, required this.vm}) : super(key: key);

  @override
  _PostBtnsState createState() => _PostBtnsState();
}

class _PostBtnsState extends State<PostBtns> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(10),
          vertical: getProportionateScreenHeight(0)),
      child: Row(
        children: [
          _likePostBtn(),
          // const HorizontalSpacing(of: 5),
          _commentBtn(),
          const Spacer(),
          _likedListBtn()
        ],
      ),
    );
  }

  Widget _likePostBtn() {
    return TextButton.icon(
      onPressed: () {
        widget.vm.likePost(widget.vm.postDetail.id);
      },
      icon: widget.vm.isliked
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
        widget.vm.postDetail.likedCount,
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

  Widget _commentBtn() {
    return TextButton.icon(
      onPressed: () {
        widget.vm.focusNode.hasFocus
            ? widget.vm.focusNode.unfocus()
            : widget.vm.focusNode.requestFocus();
      },
      icon: Icon(
        CupertinoIcons.bubble_left,
        size: kPostIconSizeCP,
        color: kPostBtnColor,
      ),
      label: Text(
        widget.vm.postDetail.commentCount,
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

  Widget _likedListBtn() {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, PostLikedListScreen.routeName,
            arguments: PostLikedListScreenArgs(widget.vm.postDetail.id));
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
