import 'package:flutter/material.dart';

class ChatMainScreen extends StatelessWidget {
  const ChatMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("chat 메인 페이지"),
        alignment: Alignment.center,
      ),
    );
  }
}
