import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_detail_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontal_spacing.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';

class NestedCommentListTile extends StatelessWidget {
  final PostDetailScreenViewModel vm;
  final CommentPresentation nestedComment;
  final int index;
  const NestedCommentListTile(
      {Key? key,
      required this.vm,
      required this.nestedComment,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: getProportionateScreenHeight(5)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          index == 0
              ? SizedBox(
                  width: getProportionateScreenWidth(20),
                  child: const Icon(CupertinoIcons.arrow_turn_down_right))
              : SizedBox(
                  width: getProportionateScreenWidth(20),
                ),
          const HorizontalSpacing(of: 5),
          Expanded(
              child: Container(
            padding: EdgeInsets.all(getProportionateScreenHeight(10)),
            decoration: BoxDecoration(
                color: mainColor.withOpacity(0.06),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    nestedComment.loginId == AuthService.loginId
                        ? Text(
                            nestedComment.userNickname + '(작성자)',
                            style: TextStyle(
                                color: mainColor,
                                fontSize: getProportionateScreenHeight(13),
                                fontWeight: FontWeight.bold),
                          )
                        : Text(
                            nestedComment.userNickname,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: getProportionateScreenHeight(13),
                                fontWeight: FontWeight.bold),
                          ),
                    const HorizontalSpacing(of: 10),
                    Text(
                      nestedComment.createdAt,
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(11),
                        color: postColor,
                      ),
                    ),
                    const HorizontalSpacing(of: 10),
                    (nestedComment.loginId == AuthService.loginId)
                        ? _deleteBtn(context)
                        : _reportBtn(context)
                  ],
                ),
                const VerticalSpacing(of: 8),
                Text(
                  nestedComment.body,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: getProportionateScreenHeight(13),
                      height: 1.3),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }

  Widget _deleteBtn(BuildContext context) {
    return TextButton(
      onPressed: () {
        buildCustomAlertDialog(
            context: context,
            contentText: '댓글을 삭제하시겠습니까?',
            btnText: '삭제',
            press: () {
              vm.deleteComment(context, nestedComment.id);
            });
      },
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        primary: postColor,
      ),
      child: Text(
        '삭제',
        style: TextStyle(
          fontSize: getProportionateScreenHeight(11),
        ),
      ),
    );
  }

  Widget _reportBtn(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        primary: postColor,
      ),
      child: Text(
        '신고',
        style: TextStyle(
          fontSize: getProportionateScreenHeight(11),
        ),
      ),
    );
  }
}
