import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/models/chatMessage.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_detail_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/object/stomp_object.dart';

class VoiceRoomTextChatInputField extends StatefulWidget {
  final VoiceDetailViewModel vm;
  const VoiceRoomTextChatInputField({Key? key, required this.vm})
      : super(key: key);

  @override
  _VoiceRoomTextChatInputFieldState createState() =>
      _VoiceRoomTextChatInputFieldState();
}

class _VoiceRoomTextChatInputFieldState
    extends State<VoiceRoomTextChatInputField> {
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenHeight(355),
      height: getProportionateScreenHeight(56),
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kMainScreenBackgroundColor),
      child: Row(
        children: [
          _textChatInputField(),
          const Spacer(),
          _sendBtn(),
        ],
      ),
    );
  }

  Widget _textChatInputField() {
    return SizedBox(
        height: getProportionateScreenHeight(36),
        width: getProportionateScreenWidth(265),
        child: Center(
          child: TextField(
            keyboardType: TextInputType.multiline,
            controller: _textController,
            autocorrect: false,
            style: TextStyle(fontSize: kTextFieldInnerFontSize),
            maxLines: null,
            // controller: (widget.vm.overlayEntry == null)
            //     ? widget.vm.commentTextController
            //     : widget.vm.nestedCommentTextController,
            // focusNode: widget.vm.focusNode,
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
              hintText: '어떤 얘기를 나눠볼까요?',
              hintStyle: TextStyle(
                  color: const Color(0xFFADADAD),
                  fontSize: kTextFieldInnerFontSize),
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              contentPadding: EdgeInsets.zero,
            ),
            cursorColor: kMainColor,
          ),
        ));
  }

  Widget _sendBtn() {
    return TextButton(
      onPressed: () {
        _sendMessage(_textController.text);
      },
      child: const Text('전송'),
      style: TextButton.styleFrom(
          minimumSize: Size(getProportionateScreenWidth(44),
              getProportionateScreenHeight(36)),
          backgroundColor: kMainColor,
          primary: Colors.white),
    );
  }

  void _sendMessage(String text) {
    if (text.isNotEmpty) {
      // print("메시지 전송 => 방번호: ${widget.vm}");
      StompObject.sendMessage(
          widget.vm.voiceRoom.roomId, text, "TALK", "multi");
      setState(() {
        _textController.text = "";
      });
    }
  }
}
