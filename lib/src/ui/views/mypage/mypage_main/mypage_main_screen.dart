import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/auth/auth_service.dart';
import 'package:zamongcampus/src/config/service_locator.dart';

class MypageMainScreen extends StatelessWidget {
  const MypageMainScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          const Text("로그아웃"),
          IconButton(
              onPressed: () {
                AuthService.logout(context);
              },
              icon: const Icon(Icons.cleaning_services))
        ],
      ),
      body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Text("로그인ID : " + (AuthService.loginId ?? "")),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/voiceFriendForm");
                  },
                  child: Text("voicefriendform으로 이동"))
            ],
          )),
    );
  }
}
