import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_detail_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/bottom_fixed_btn_decobox.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontalDividerCustom.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';
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
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20)),
                      child: Column(
                        children: [
                          PostHead(vm: vm), //프로필 카테고리
                          PostBody(vm: vm), //본문 (사진)
                        ],
                      ),
                    ),
                    const HorizontalDividerCustom(
                      color: Color(0xfff0f0f6),
                    ),
                    PostBtns(vm: vm), //좋아요, 댓글 버튼
                    //하단 아래 구분선
                    HorizontalDividerCustom(
                      thickness: getProportionateScreenHeight(8),
                      color: const Color(0xfff0f0f6),
                    ),
                    //댓글 시작 전 윗 공간
                    const VerticalSpacing(of: 10),
                    //댓글 영역
                    CommentList(vm: vm)
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
