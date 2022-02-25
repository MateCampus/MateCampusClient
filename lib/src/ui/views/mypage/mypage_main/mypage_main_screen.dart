import 'package:flutter/material.dart';

class MypageMainScreen extends StatelessWidget {
  const MypageMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("mypage 메인 페이지"),
        alignment: Alignment.center,
      ),
    );
  }
}
