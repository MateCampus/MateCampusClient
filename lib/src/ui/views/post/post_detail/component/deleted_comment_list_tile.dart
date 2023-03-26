import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_detail_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontalDividerCustom.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontal_spacing.dart';
import 'package:zamongcampus/src/ui/views/post/post_detail/component/deleted_nested_comment_list_tile.dart';
import 'package:zamongcampus/src/ui/views/post/post_detail/component/nested_comment_list_tile.dart';

class DeletedCommentListTile extends StatelessWidget {
  final PostDetailScreenViewModel vm;
  final CommentPresentation comment;
  const DeletedCommentListTile(
      {Key? key, required this.vm, required this.comment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenHeight(5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                    decoration: const BoxDecoration(
                        color: Color(0xfff7f7fb),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: _deletedText()),
                (comment.children.isNotEmpty)
                    ? Padding(
                        padding: EdgeInsets.only(
                            top: getProportionateScreenHeight(3)),
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: comment.children.length,
                            itemBuilder: (BuildContext context, int index) {
                              return comment.children[index].deleted
                                  ? DeletedNestedCommentListTile(
                                      vm: vm,
                                      nestedComment: comment.children[index],
                                      index: index,
                                    )
                                  : NestedCommentListTile(
                                      vm: vm,
                                      nestedComment: comment.children[index],
                                      index: index,
                                    );
                            }),
                      )
                    : const SizedBox()
              ],
            )),
        const HorizontalDividerCustom(color: kMainScreenBackgroundColor)
      ],
    );
  }

  Widget _deletedText() {
    return Row(
      children: [
        const HorizontalSpacing(of: 10),
        Icon(
          CupertinoIcons.exclamationmark_circle_fill,
          size: getProportionateScreenWidth(15),
          color: const Color(0xff999999),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(8),
              vertical: getProportionateScreenHeight(10)),
          child: Text(
            '삭제된 댓글입니다.',
            style: TextStyle(
                fontSize: resizeFont(13), color: const Color(0xff767676)),
          ),
        ),
      ],
    );
  }
}
