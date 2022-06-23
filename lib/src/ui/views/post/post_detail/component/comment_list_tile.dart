import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_detail_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/custom_alert_dialog_components/delete/commemt_deleted_msg.dart';
import 'package:zamongcampus/src/ui/common_components/custom_alert_dialog_components/report_post/report_post_form.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontalDividerCustom.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontal_spacing.dart';
import 'package:zamongcampus/src/ui/views/post/post_detail/component/deleted_nested_comment_list_tile.dart';
import 'package:zamongcampus/src/ui/views/post/post_detail/component/nested_comment_list_tile.dart';

class CommentListTile extends StatelessWidget {
  final PostDetailScreenViewModel vm;
  final CommentPresentation comment;
  const CommentListTile({Key? key, required this.comment, required this.vm})
      : super(key: key);

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
                    comment.loginId == vm.postDetail.loginId
                        ? Text(
                            comment.userNickname,
                            style: TextStyle(
                                color: kMainColor,
                                fontSize: getProportionateScreenHeight(13),
                                fontWeight: FontWeight.bold),
                          )
                        : Text(
                            comment.userNickname,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
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
                Row(
                  children: [
                    _replyBtn(context),
                    const HorizontalSpacing(of: 12),
                    (comment.loginId == AuthService.loginId)
                        ? _deleteBtn(context)
                        : _reportBtn(context)
                  ],
                ),
                (comment.children.isNotEmpty)
                    ? Padding(
                        padding: EdgeInsets.only(
                            top: getProportionateScreenHeight(10)),
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: comment.children.length,
                            itemBuilder: (BuildContext context, int index) {
                              return comment.children[index].deleted
                                  ? DeletedNestedCommentListTile(
                                      vm: vm,
                                      nestedComment: comment.children[index],
                                      index: index,
                                    )
                                  : NestedCommentListTile(
                                      vm: vm,
                                      nestedComment: comment.children[index],
                                      index: index,
                                    );
                            }),
                      )
                    : const SizedBox(),
              ],
            )),
        const HorizontalDividerCustom(color: kMainScreenBackgroundColor)
      ],
    );
  }

  Widget _replyBtn(BuildContext context) {
    return TextButton(
      onPressed: () {
        vm.createNestedCommentOverlay(
            context, comment.userNickname, comment.id);
        vm.getScrollOffset(vm.commentScrollController.offset);
      },
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        primary: kPostBtnColor,
      ),
      child: Text(
        '답글달기',
        style: TextStyle(
          fontSize: getProportionateScreenHeight(12),
        ),
      ),
    );
  }

  Widget _deleteBtn(BuildContext context) {
    return TextButton(
      onPressed: () {
        buildCustomAlertDialog(
            context: context,
            contentWidget: const CommentDeletedMsg(),
            btnText: '삭제',
            press: () {
              vm.deleteComment(context, comment.id);
            });
      },
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        primary: kPostBtnColor,
      ),
      child: Text(
        '삭제',
        style: TextStyle(
          fontSize: getProportionateScreenHeight(12),
        ),
      ),
    );
  }

  Widget _reportBtn(BuildContext context) {
    return TextButton(
      onPressed: () {
        buildCustomAlertDialog(
            context: context,
            contentWidget: ReportPostForm(
              vm: vm,
            ),
            press: () {
              vm.reportComment(context, comment.id);
            },
            btnText: '신고');
      },
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        primary: kPostBtnColor,
      ),
      child: Text(
        '신고',
        style: TextStyle(
          fontSize: getProportionateScreenHeight(12),
        ),
      ),
    );
  }
}
