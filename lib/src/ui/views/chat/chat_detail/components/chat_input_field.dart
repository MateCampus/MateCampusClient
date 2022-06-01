import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/chat_detail_viewmodel.dart';
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
      width: getProportionateScreenHeight(335),
      height: getProportionateScreenHeight(56),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Row(
        children: [
          _messageInputField(),
          _sendBtn(),
        ],
      ),
    );
  }

  Widget _messageInputField() {
    return SizedBox(
        width: getProportionateScreenWidth(275),
        child: TextField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          controller: _textController,
          onSubmitted: _sendMessage,
          decoration: InputDecoration(
            hintText: '메세지를 입력하세요',
            hintStyle: const TextStyle(color: Color(0xFFADADAD), fontSize: 14),
            border: const OutlineInputBorder(borderSide: BorderSide.none),
            contentPadding: EdgeInsets.all(getProportionateScreenHeight(10)),
            isDense: true,
          ),
          cursorColor: mainColor,
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
          backgroundColor: mainColor,
          primary: Colors.white),
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
