import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/textstyle_constans.dart';
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
      padding: EdgeInsets.only(top: getProportionateScreenHeight(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Spacer(),
          Container(
            width: getProportionateScreenWidth(299),
            decoration: const BoxDecoration(
                color: Color(0xfff7f7fb),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Row(
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
                        fontSize: resizeFont(13),
                        color: const Color(0xff767676)),
                  ),
                ),
              ],
            ),
          ),
        ],
        // crossAxisAlignment: CrossAxisAlignment.start,
        // children: [
        //   index == 0
        //       ? SizedBox(
        //           width: getProportionateScreenWidth(20),
        //           child: Icon(
        //             CupertinoIcons.arrow_turn_down_right,
        //             size: getProportionateScreenWidth(18),
        //             color: kPostBtnColor,
        //           ))
        //       : SizedBox(
        //           width: getProportionateScreenWidth(20),
        //         ),
        //   const HorizontalSpacing(of: 5),
        //   Expanded(
        //       child: Container(
        //     padding: EdgeInsets.all(getProportionateScreenHeight(10)),
        //     decoration: BoxDecoration(
        //         color: kMainColor.withOpacity(0.06),
        //         borderRadius: const BorderRadius.all(Radius.circular(5))),
        //     child: Text(
        //       '삭제된 댓글입니다',
        //       style: TextStyle(
        //           fontSize: resizeFont(12), color: Colors.grey.shade700),
        //     ),
        //   ))
        // ],
      ),
    );
  }
}
