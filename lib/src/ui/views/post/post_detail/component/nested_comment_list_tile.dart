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
import 'package:zamongcampus/src/ui/common_components/custom_alert_dialog_components/report/report_form.dart';
import 'package:zamongcampus/src/ui/common_components/custom_alert_dialog_components/report_post/report_post_form.dart';
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
          //인덱스 아마 첫 대댓 아이콘 때문에 쓴걸텐데 이제 필요없을듯?
          // index == 0
          //     ? SizedBox(
          //         width: getProportionateScreenWidth(60),
          //         child: Icon(
          //           CupertinoIcons.arrow_turn_down_right,
          //           size: getProportionateScreenWidth(18),
          //           color: kPostBtnColor,
          //         ))
          //     : SizedBox(
          //         width: getProportionateScreenWidth(20),
          //       ),
          // const HorizontalSpacing(of: 5),
          SizedBox(
            width: getProportionateScreenWidth(30),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _nestedCommentUser(context),
              // Row(
              //   children: [
              //     nestedComment.loginId == AuthService.loginId
              //         ? Text(
              //             nestedComment.userNickname,
              //             style: TextStyle(
              //                 color: kMainColor,
              //                 fontSize: getProportionateScreenHeight(13),
              //                 fontWeight: FontWeight.bold),
              //           )
              //         : Text(
              //             nestedComment.userNickname,
              //             style: TextStyle(
              //                 color: Colors.black.withOpacity(0.7),
              //                 fontSize: getProportionateScreenHeight(13),
              //                 fontWeight: FontWeight.bold),
              //           ),
              //     const HorizontalSpacing(of: 7),
              //     Text(
              //       nestedComment.createdAt,
              //       style: TextStyle(
              //           fontSize: kCreateAtFontSize,
              //           color: kPostBtnColor,
              //           fontWeight: FontWeight.w300),
              //     ),
              //     const HorizontalSpacing(of: 7),
              //     (nestedComment.loginId == AuthService.loginId)
              //         ? _deleteBtn(context)
              //         : _reportBtn(context)
              //   ],
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Spacer(),
                  Container(
                    width: getProportionateScreenWidth(263),
                    decoration: const BoxDecoration(
                        color: Color(0xfff7f7fb),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(8),
                          vertical: getProportionateScreenHeight(10)),
                      child: Text(
                        nestedComment.body,
                        style: kPostCommentBodyStyle,
                      ),
                    ),
                  ),
                ],
              )
              // const VerticalSpacing(of: 7),
              // Text(
              //   nestedComment.body,
              //   style: kPostCommentBodyStyle,
              // ),
            ],
          ))
        ],
      ),
    );
  }

  Widget _nestedCommentUser(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      minLeadingWidth: 0.0,
      visualDensity: const VisualDensity(vertical: -4),
      leading: CircleAvatar(
        backgroundColor: Colors.grey,
        radius: getProportionateScreenHeight(14),
        backgroundImage: nestedComment.userImageUrl.startsWith('https')
            ? CachedNetworkImageProvider(nestedComment.userImageUrl)
                as ImageProvider
            : AssetImage(nestedComment.userImageUrl),
      ),
      title: nestedComment.loginId == vm.postDetail.loginId
          ? Text(
              nestedComment.userNickname + '(글쓴이)',
              style: TextStyle(
                  fontSize: resizeFont(12),
                  color: Color(0xff111111),
                  fontWeight: FontWeight.w500),
            )
          : Text(
              nestedComment.userNickname,
              style: TextStyle(
                  fontSize: resizeFont(12),
                  color: Color(0xff111111),
                  fontWeight: FontWeight.w500),
            ),
      subtitle: Text(
        nestedComment.collegeName + ' \u{00B7} ' + nestedComment.createdAt,
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

  _removeOrReportActionSheet(BuildContext context) {
    showAdaptiveActionSheet(
      context: context,
      actions: <BottomSheetAction>[
        (nestedComment.loginId == AuthService.loginId)
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
                        vm.deleteComment(context, nestedComment.id);
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
                        return ReportForm(
                            targetUserLoginId: nestedComment.loginId,
                            reportCategoryIndex: "3");
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
  //             vm.deleteComment(context, nestedComment.id);
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
  //         fontSize: resizeFont(11),
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
  //             return ReportPostForm(commentId: nestedComment.id);
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
  //         fontSize: resizeFont(11),
  //       ),
  //     ),
  //   );
  // }
}
