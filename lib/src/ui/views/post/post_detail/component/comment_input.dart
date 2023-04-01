import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_detail_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_edit_interest/components/edit_interest.dart';

class CommentInput extends StatefulWidget {
  final PostDetailScreenViewModel vm;
  const CommentInput({Key? key, required this.vm}) : super(key: key);

  @override
  _CommentInputState createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenHeight(355),
      height: getProportionateScreenHeight(46),
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: const Color(0xffe5e5ec)),
      ),
      child: Row(
        children: [
          Expanded(child: _commentInputField()),
          // const Spacer(),
          _sendBtn(context),
        ],
      ),
    );
  }

  Widget _commentInputField() {
    return SizedBox(
        height: getProportionateScreenHeight(36),
        // width: getProportionateScreenWidth(265),
        child: Center(
          child: TextField(
            keyboardType: TextInputType.multiline,
            style: TextStyle(fontSize: kTextFieldInnerFontSize),
            maxLines: null,
            controller: (widget.vm.overlayEntry == null)
                ? widget.vm.commentTextController
                : widget.vm.nestedCommentTextController,
            focusNode: widget.vm.focusNode,
            autocorrect: false,
            //키보드offset관련
            // onTap: () {
            //   print(widget.vm.commentScrollController.offset);
            //   print(widget.vm.keyboardHeight);
            //   widget.vm.commentScrollController.animateTo(
            //       widget.vm.commentScrollController.offset +
            //           widget.vm.keyboardHeight,
            //       duration: const Duration(milliseconds: 400),
            //       curve: Curves.fastOutSlowIn);
            // },
            decoration: InputDecoration(
              hintText: '소중한 댓글을 남겨주세요.',
              hintStyle: TextStyle(
                  color: const Color(0xFF999999),
                  fontSize: kTextFieldInnerFontSize),
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              contentPadding: EdgeInsets.zero,
              isDense: true,
            ),
            cursorColor: kMainColor,
          ),
        ));
  }

  // Widget _sendBtn() {
  //   return TextButton(
  //     onPressed: () {
  //       if (widget.vm.overlayEntry == null) {
  //         widget.vm.createComment();
  //       } else {
  //         widget.vm.createNestedComment();
  //       }
  //     },
  //     child: const Text('전'),
  //     style: TextButton.styleFrom(
  //         minimumSize: Size(getProportionateScreenWidth(44),
  //             getProportionateScreenHeight(36)),
  //         backgroundColor: kMainColor,
  //         primary: Colors.white),
  //   );
  // }

  Widget _sendBtn(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (widget.vm.overlayEntry == null) {
          widget.vm.createComment(context);
          widget.vm.focusNode.unfocus();
        } else {
          widget.vm.createNestedComment(context);
          widget.vm.focusNode.unfocus();
        }
      },
      child: const Icon(
        CupertinoIcons.arrow_up,
        color: Colors.white,
      ),
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: const VisualDensity(horizontal: -4),
        elevation: 0,
        backgroundColor: kMainColor,
      ),
    );
  }
}
