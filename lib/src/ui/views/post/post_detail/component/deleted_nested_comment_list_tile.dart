import 'package:flutter/cupertino.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_detail_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontal_spacing.dart';

class DeletedNestedCommentListTile extends StatelessWidget {
  final PostDetailScreenViewModel vm;
  final CommentPresentation nestedComment;
  final int index;
  const DeletedNestedCommentListTile(
      {Key? key,
      required this.vm,
      required this.nestedComment,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: getProportionateScreenHeight(5)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          index == 0
              ? SizedBox(
                  width: getProportionateScreenWidth(20),
                  child: const Icon(CupertinoIcons.arrow_turn_down_right))
              : SizedBox(
                  width: getProportionateScreenWidth(20),
                ),
          const HorizontalSpacing(of: 5),
          Expanded(
              child: Container(
            padding: EdgeInsets.all(getProportionateScreenHeight(10)),
            decoration: BoxDecoration(
                color: mainColor.withOpacity(0.06),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: Text('삭제된 댓글입니다'),
          ))
        ],
      ),
    );
  }
}
