import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/arguments/post_liked_list_screen_args.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
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
  // final TextStyle _countTextStyle =
  //     TextStyle(fontSize: resizeFont(13), color: kPostBtnColor);

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
          _likedListBtn()
        ],
      ),
    );
  }

  // Widget _buttons() {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(5)),
  //     child: Row(
  //       children: [
  //         IconButton(
  //           onPressed: () {
  //             widget.vm.likePost(widget.vm.postDetail.id);
  //           },
  //           icon: widget.vm.isliked
  //               ? Icon(
  //                   CupertinoIcons.heart_fill,
  //                   size: kPostDetailIconSizeCP,
  //                   color: kMainColor,
  //                 )
  //               : Icon(
  //                   CupertinoIcons.heart,
  //                   size: kPostDetailIconSizeCP,
  //                   color: kPostBtnColor,
  //                 ),
  //         ),
  //         const HorizontalSpacing(of: 5),
  //         IconButton(
  //           onPressed: () {
  //             widget.vm.focusNode.hasFocus
  //                 ? widget.vm.focusNode.unfocus()
  //                 : widget.vm.focusNode.requestFocus();
  //           },
  //           icon: Icon(
  //             CupertinoIcons.bubble_left,
  //             size: kPostDetailIconSizeCP,
  //             color: kPostBtnColor,
  //           ),
  //         ),
  //         const Spacer(),
  //         IconButton(
  //           onPressed: () {
  //             widget.vm.bookMarkPost(widget.vm.postDetail.id);
  //           },
  //           icon: widget.vm.isBookMarked
  //               ? Icon(
  //                   CupertinoIcons.bookmark_fill,
  //                   size: kPostDetailIconSizeCP,
  //                   color: Colors.orangeAccent,
  //                 )
  //               : Icon(
  //                   CupertinoIcons.bookmark,
  //                   size: kPostDetailIconSizeCP,
  //                   color: kPostBtnColor,
  //                 ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _likePostBtn() {
    return InkWell(
      onTap: () {
        widget.vm.likePost(widget.vm.postDetail.id);
      },
      child: Row(
        children: [
          widget.vm.isliked
              ? Icon(
                  CupertinoIcons.heart_fill,
                  size: kPostDetailIconSizeCP,
                  color: kMainColor,
                )
              : Icon(
                  CupertinoIcons.heart,
                  size: kPostDetailIconSizeCP,
                  color: kPostBtnColor,
                ),
          const HorizontalSpacing(of: 5),
          Text(
            widget.vm.postDetail.likedCount,
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
      onTap: () {
        widget.vm.focusNode.hasFocus
            ? widget.vm.focusNode.unfocus()
            : widget.vm.focusNode.requestFocus();
      },
      child: Row(
        children: [
          Icon(
            CupertinoIcons.bubble_left,
            size: kPostDetailIconSizeCP,
            color: kPostBtnColor,
          ),
          const HorizontalSpacing(of: 5),
          Text(
            widget.vm.postDetail.commentCount,
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

  Widget _likedListBtn() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, PostLikedListScreen.routeName,
            arguments: PostLikedListScreenArgs(widget.vm.postDetail.id));
      },
      child: Row(
        children: [
          Text(
            '좋아요\t' + widget.vm.postDetail.likedCount,
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

  // Widget _countText() {
  //   return Padding(
  //     padding: EdgeInsets.fromLTRB(
  //         getProportionateScreenWidth(17),
  //         getProportionateScreenHeight(20),
  //         getProportionateScreenWidth(17),
  //         getProportionateScreenHeight(5)),
  //     child: Row(
  //       children: [
  //         Text(
  //           '좋아요 ' + widget.vm.postDetail.likedCount,
  //           style: _countTextStyle,
  //         ),
  //         const HorizontalSpacing(of: 12),
  //         Text(
  //           '댓글 ' + widget.vm.postDetail.commentCount,
  //           style: _countTextStyle,
  //         ),
  //         const HorizontalSpacing(of: 12),
  //         Text(
  //           '조회수 ' + widget.vm.postDetail.viewCount,
  //           style: _countTextStyle,
  //         )
  //       ],
  //     ),
  //   );
  // }
}
