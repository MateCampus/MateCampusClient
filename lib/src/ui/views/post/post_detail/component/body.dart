import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_detail_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';
import 'package:zamongcampus/src/ui/views/post/post_detail/component/comment_input.dart';
import 'package:zamongcampus/src/ui/views/post/post_detail/component/comment_list.dart';
import 'package:zamongcampus/src/ui/views/post/post_detail/component/post_body.dart';
import 'package:zamongcampus/src/ui/views/post/post_detail/component/post_head.dart';

class Body extends StatelessWidget {
  PostDetailScreenViewModel vm;
  Body({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 5),
      child: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
                  child: Column(
            children: [
              PostHead(post: vm.postDetail), //카터고리 타이틀 프로필
              PostBody(vm: vm), //본문
              const VerticalSpacing(of: 15),
              CommentList(vm: vm) // 댓글
            ],
          ))),
          CommentInput()
        ],
      ),
    );
  }
}
