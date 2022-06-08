import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_detail_screen_viewmodel.dart';
import 'package:zamongcampus/src/ui/common_widgets/bottom_fixed_btn_decobox.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';
import 'package:zamongcampus/src/ui/views/post/post_detail/component/comment_input.dart';
import 'package:zamongcampus/src/ui/views/post/post_detail/component/comment_list.dart';
import 'package:zamongcampus/src/ui/views/post/post_detail/component/post_body.dart';
import 'package:zamongcampus/src/ui/views/post/post_detail/component/post_head.dart';

class Body extends StatelessWidget {
  final PostDetailScreenViewModel vm;
  const Body({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
        SafeArea(
          child: CompositedTransformTarget(
            link: vm.layerLink,
            child: BottomFixedBtnDecoBox(child: CommentInput(vm: vm)),
          ),
        )
      ],
    );
  }
}
