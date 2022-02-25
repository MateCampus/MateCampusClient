import 'package:flutter/material.dart';

class VoiceMainScreen extends StatelessWidget {
  const VoiceMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("voice 메인 페이지"),
        alignment: Alignment.center,
      ),
    );
  }
}
