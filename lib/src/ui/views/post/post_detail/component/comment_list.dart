import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_detail_screen_viewmodel.dart';
import 'package:zamongcampus/src/ui/views/post/post_detail/component/comment_list_tile.dart';
import 'package:zamongcampus/src/ui/views/post/post_detail/component/deleted_comment_list_tile.dart';

class CommentList extends StatelessWidget {
  final PostDetailScreenViewModel vm;
  const CommentList({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: vm.comments.length,
        itemBuilder: (BuildContext context, int index) {
          if (vm.comments[index].deleted) {
            return DeletedCommentListTile(vm: vm, comment: vm.comments[index]);
          } else {
            return CommentListTile(vm: vm, comment: vm.comments[index]);
          }
        });
  }
}
