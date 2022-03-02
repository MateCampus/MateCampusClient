import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/auth/auth_service.dart';
import 'package:zamongcampus/src/config/service_locator.dart';

class MypageMainScreen extends StatelessWidget {
  MypageMainScreen({Key? key}) : super(key: key);
  AuthService authService = serviceLocator<AuthService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Text("로그아웃"),
          IconButton(
              onPressed: () {
                authService.logout(context);
              },
              icon: const Icon(Icons.cleaning_services))
        ],
      ),
      body: Container(
        child: Text("mypage 메인 페이지"),
        alignment: Alignment.center,
      ),
    );
  }
}
