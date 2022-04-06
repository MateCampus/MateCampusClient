import 'package:flutter/material.dart';

// 잡동사니 모아두는 느낌...

class MainService extends ChangeNotifier {
  String? _deviceToken;
  List<int> _likedPostIds = [];
  List<int> _bookMarkedPostIds = [];
  String? get deviceToken => _deviceToken;
  List<int> get likedPostIds => _likedPostIds;
  List<int> get bookMarkedPostIds => _bookMarkedPostIds;

  void changeDeviceToken(String token) {
    _deviceToken = token;
  }

  // loginId가 바뀔 때, 혹은 로그인할 때 활용하도록.
  // fetchUserData 라고 해놓고 가져오면 될듯?
}
