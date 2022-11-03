import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/textstyle_constans.dart';
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
                vertical: getProportionateScreenHeight(5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _commentUser(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: getProportionateScreenWidth(299),
                          decoration: const BoxDecoration(
                              color: Color(0xfff7f7fb),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(8),
                                vertical: getProportionateScreenHeight(10)),
                            child: Text(
                              comment.body,
                              style: kPostCommentBodyStyle,
                            ),
                          ),
                        ),
                        _replyBtn(context),
                      ],
                    ),
                  ],
                ),
                (comment.children.isNotEmpty)
                    ? Padding(
                        padding: EdgeInsets.only(
                            top: getProportionateScreenHeight(3)),
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

  Widget _commentUser(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      minLeadingWidth: 0.0,
      visualDensity: const VisualDensity(vertical: -4),
      leading: CircleAvatar(
        backgroundColor: Colors.grey,
        radius: getProportionateScreenHeight(14),
        backgroundImage: comment.userImageUrl.startsWith('https')
            ? CachedNetworkImageProvider(comment.userImageUrl) as ImageProvider
            : AssetImage(comment.userImageUrl),
      ),
      title: comment.loginId == vm.postDetail.loginId
          ? Text(
              comment.userNickname + '(글쓴이)',
              style: TextStyle(
                  fontSize: resizeFont(12),
                  color: Color(0xff111111),
                  fontWeight: FontWeight.w500),
            )
          : Text(
              comment.userNickname,
              style: TextStyle(
                  fontSize: resizeFont(12),
                  color: Color(0xff111111),
                  fontWeight: FontWeight.w500),
            ),
      subtitle: Text(
        comment.collegeName + ' \u{00B7} ' + comment.createdAt,
        style: TextStyle(
            fontSize: resizeFont(11),
            color: Color(0xff767676),
            fontWeight: FontWeight.w300),
      ),
      trailing: IconButton(
        icon: const Icon(CupertinoIcons.ellipsis_vertical),
        color: Colors.black,
        iconSize: getProportionateScreenWidth(15),
        onPressed: () {
          //삭제 혹은 신고 기능
          _removeOrReportActionSheet(context);
        },
      ),
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
        padding:
            EdgeInsets.symmetric(vertical: getProportionateScreenHeight(5)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        primary: kPostBtnColor,
      ),
      child: Text(
        '답글달기',
        style: TextStyle(
          color: Color(0xff767676),
          fontSize: resizeFont(12),
        ),
      ),
    );
  }

  _removeOrReportActionSheet(BuildContext context) {
    showAdaptiveActionSheet(
      context: context,
      actions: <BottomSheetAction>[
        (comment.loginId == AuthService.loginId)
            ? BottomSheetAction(
                title: Text(
                  '삭제하기',
                  style: TextStyle(
                    fontSize: resizeFont(15.0),
                    color: Colors.black87,
                  ),
                ),
                onPressed: () {
                  //bottomsheet 내림
                  Navigator.pop(context);
                  //댓글삭제할거냐고 물어봄
                  buildCustomAlertDialog(
                      context: context,
                      contentWidget: const CommentDeletedMsg(),
                      btnText: '삭제',
                      press: () {
                        vm.deleteComment(context, comment.id);
                      });
                },
              )
            : BottomSheetAction(
                title: Text(
                  '신고하기',
                  style: TextStyle(
                    fontSize: resizeFont(15.0),
                    color: Colors.black87,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ReportPostForm(commentId: comment.id);
                      });
                },
              ),
      ],
      cancelAction: CancelAction(
          title: Text(
            '취소',
            style: TextStyle(
                fontSize: resizeFont(16.0), fontWeight: FontWeight.w500),
          ),
          onPressed: () {
            Navigator.pop(context);
          }),
    );
  }

  // Widget _deleteBtn(BuildContext context) {
  //   return TextButton(
  //     onPressed: () {
  //       buildCustomAlertDialog(
  //           context: context,
  //           contentWidget: const CommentDeletedMsg(),
  //           btnText: '삭제',
  //           press: () {
  //             vm.deleteComment(context, comment.id);
  //           });
  //     },
  //     style: TextButton.styleFrom(
  //       minimumSize: Size.zero,
  //       padding: EdgeInsets.zero,
  //       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //       primary: kPostBtnColor,
  //     ),
  //     child: Text(
  //       '삭제',
  //       style: TextStyle(
  //         fontSize: getProportionateScreenHeight(12),
  //       ),
  //     ),
  //   );
  // }

  // Widget _reportBtn(BuildContext context) {
  //   return TextButton(
  //     onPressed: () {
  //       showDialog(
  //           context: context,
  //           builder: (BuildContext context) {
  //             return ReportPostForm(commentId: comment.id);
  //           });
  //     },
  //     style: TextButton.styleFrom(
  //       minimumSize: Size.zero,
  //       padding: EdgeInsets.zero,
  //       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //       primary: kPostBtnColor,
  //     ),
  //     child: Text(
  //       '신고',
  //       style: TextStyle(
  //         fontSize: getProportionateScreenHeight(12),
  //       ),
  //     ),
  //   );
  // }
}
