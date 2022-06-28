import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/mypage_comment_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_detail_screen_viewmodel.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontalDividerCustom.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_comment/components/my_comment_list_tile.dart';

class Body extends StatelessWidget {
  final MypageCommentViewModel vm;
  final List<CommentPresentation> commentList;
  const Body({Key? key, required this.vm, required this.commentList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      //최신순으로 보여주기 위함
      reverse: true,
      padding: EdgeInsets.zero,
      itemCount: commentList.length,
      itemBuilder: (BuildContext context, int index) =>
          MyCommentListTile(vm: vm, comment: commentList[index]),
      separatorBuilder: (BuildContext context, int index) =>
          const HorizontalDividerCustom(
        color: kMainScreenBackgroundColor,
      ),
    );
  }
}
