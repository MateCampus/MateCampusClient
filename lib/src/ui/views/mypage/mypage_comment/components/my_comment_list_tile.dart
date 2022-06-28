import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/mypage_comment_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_detail_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/custom_alert_dialog_components/delete/commemt_deleted_msg.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontal_spacing.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';

class MyCommentListTile extends StatelessWidget {
  final MypageCommentViewModel vm;
  final CommentPresentation comment;
  const MyCommentListTile({Key? key, required this.vm, required this.comment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenHeight(15)),
      child: Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                comment.createdAt,
                style: TextStyle(
                    fontSize: kCreateAtFontSize,
                    color: kPostBtnColor,
                    fontWeight: FontWeight.w300),
              ),
              const VerticalSpacing(of: 5),
              Text(
                comment.body,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: resizeFont(13.5),
                    color: Colors.black.withOpacity(0.8),
                    height: 1.5),
              )
            ],
          )),
          const HorizontalSpacing(of: 10),
          IconButton(
            onPressed: () {
              buildCustomAlertDialog(
                  context: context,
                  contentWidget: const CommentDeletedMsg(),
                  btnText: '삭제',
                  press: () {
                    vm.deleteMyComment(context, comment);
                  });
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(CupertinoIcons.trash),
            iconSize: getProportionateScreenWidth(16),
            color: kMainColor,
          ),
        ],
      ),
    );
  }
}
