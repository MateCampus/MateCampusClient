import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_detail_screen_viewmodel.dart';
import 'package:zamongcampus/src/ui/common_widgets/bottom_fixed_btn_decobox.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontalDividerCustom.dart';
import 'package:zamongcampus/src/ui/views/post/post_detail/component/comment_input.dart';
import 'package:zamongcampus/src/ui/views/post/post_detail/component/comment_list.dart';
import 'package:zamongcampus/src/ui/views/post/post_detail/component/post_body.dart';
import 'package:zamongcampus/src/ui/views/post/post_detail/component/post_btns.dart';
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
                physics:
                    const ClampingScrollPhysics(), // 스크롤이 맨 밑으로 움직일때 bouncing막기 위함
                controller: vm.commentScrollController,
                child: Column(
                  children: [
                    PostHead(vm: vm), //카터고리 타이틀 프로필
                    const HorizontalDividerCustom(
                      color: screenBackgroundColor,
                    ),
                    PostBody(vm: vm), //본문
                    //const HorizontalDividerCustom(),
                    PostBtns(vm: vm), //좋아요, 북마크 버튼
                    const HorizontalDividerCustom(
                      thickness: 10,
                      color: screenBackgroundColor,
                    ),
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
