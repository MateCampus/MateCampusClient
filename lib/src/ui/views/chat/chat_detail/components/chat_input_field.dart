import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/object/stomp_object.dart';

class ChatInputField extends StatefulWidget {
  final String roomId;
  final String roomType;
  const ChatInputField({Key? key, required this.roomId, required this.roomType})
      : super(key: key);

  @override
  _ChatInputFieldState createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final _textController = TextEditingController();

  // @override
  // void initState() {
  //   _textController.addListener(() {});
  //   super.initState();
  // }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  // 메세지 보내기
  void _sendMessage(String text) {
    if (text.isNotEmpty) {
      print("메시지 전송 => 방번호: ${widget.roomId}");
      StompObject.sendMessage(widget.roomId, text, "TALK", widget.roomType);
      setState(() {
        _textController.text = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenHeight(355),
      height: getProportionateScreenHeight(46),
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          border: Border.all(color: const Color(0xffe5e5ec))),
      child: Row(
        children: [
          Expanded(child: _messageInputField()),
          // const Spacer(),
          _sendBtn(),
        ],
      ),
    );
  }

  Widget _messageInputField() {
    return SizedBox(
        height: getProportionateScreenHeight(36),
        // width: getProportionateScreenWidth(265),
        child: Center(
          child: TextField(
            keyboardType: TextInputType.text,
            maxLines: null,
            autocorrect: false,
            controller: _textController,
            onSubmitted: _sendMessage,
            style: TextStyle(fontSize: kTextFieldInnerFontSize),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              hintText: '메세지를 입력하세요',
              hintStyle: TextStyle(
                  color: const Color(0xFF999999),
                  fontSize: kTextFieldInnerFontSize),
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              isDense: true,
            ),
            cursorColor: kMainColor,
          ),
        ));
  }

  Widget _sendBtn() {
    return ElevatedButton(
      onPressed: () {
        _sendMessage(_textController.text);
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
        primary: kMainColor,
      ),
    );
  }

  // Widget _sendBtnDisable() {
  //   return TextButton(
  //       onPressed: null,
  //       child: const Text('전송'),
  //       style: TextButton.styleFrom(
  //         minimumSize: Size(getProportionateScreenWidth(44),
  //             getProportionateScreenHeight(36)),
  //         //backgroundColor: Colors.grey
  //       ));
  // }
}
