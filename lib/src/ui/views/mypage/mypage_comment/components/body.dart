import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_detail_screen_viewmodel.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_comment/components/my_comment_list_tile.dart';

class Body extends StatelessWidget {
  final List<CommentPresentation> commentList;
  const Body({Key? key, required this.commentList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: commentList.length,
        itemBuilder: (BuildContext context, int index) =>
            MyCommentListTile(comment: commentList[index]));
  }
}
