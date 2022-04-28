import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/chat_detail_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/object/stomp_object.dart';

class ChatInputField extends StatefulWidget {
  final ChatDetailViewModel vm;
  const ChatInputField({Key? key, required this.vm}) : super(key: key);

  @override
  _ChatInputFieldState createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  // 메세지 보내기
  void _sendMessage(String text) {
    if (text != "") {
      print("메시지 전송 => 방번호: ${widget.vm.chatRoom.roomId}");
      StompObject.sendMessage(
          widget.vm.chatRoom.roomId, text, "TALK", widget.vm.chatRoom.type);
      setState(() {
        _textController.text = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(70),
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(12),
          vertical: getProportionateScreenHeight(12)),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [subColor, mainColor],
          stops: [0.5, 1.0],
        ),
      ),
      child: Row(
        children: [
          Container(
            width: getProportionateScreenWidth(300),
            height: getProportionateScreenHeight(50),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              keyboardType: TextInputType.multiline,
              textAlign: TextAlign.left,
              controller: _textController,
              onSubmitted: _sendMessage,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                hintText: "메세지를 입력하세요",
                hintStyle: TextStyle(),
                border: InputBorder.none,
              ),
            ),
          ),
          Expanded(child: Container()),
          IconButton(
            icon: Icon(Icons.send),
            padding: EdgeInsets.zero,
            color: Colors.white,
            iconSize: getProportionateScreenWidth(30),
            onPressed: () {
              _sendMessage(_textController.text);
            },
          ),
        ],
      ),
    );
  }
}
