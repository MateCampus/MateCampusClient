import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/mypage_comment_viewmodel.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontalDividerCustom.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_comment/components/my_comment_list_tile.dart';

class Body extends StatelessWidget {
  final MypageCommentViewModel vm;
  final List<MyCommentPresentation> commentList;
  const Body({Key? key, required this.vm, required this.commentList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      //최신순으로 보여주기 위함. (근데 이거는 nextpagetoken안쓰고 한번에 다 가져오니까 가능한걸수도있다. 만약에 바뀐다면 서버에서 처리해서 주는게 맞음.)
      reverse: true,
      padding: EdgeInsets.zero,
      itemCount: commentList.length,
      itemBuilder: (BuildContext context, int index) =>
          MyCommentListTile(vm: vm, comment: commentList[index]),
      separatorBuilder: (BuildContext context, int index) =>
          const HorizontalDividerCustom(color: Color(0xfff0f0f6)),
    );
  }
}
